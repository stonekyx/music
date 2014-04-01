#include <cstring>
#include <boost/atomic.hpp>

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavformat/avio.h>
#include <libswresample/swresample.h>
#include <libavutil/opt.h>
#include <libavutil/audioconvert.h>
#include <libavutil/mathematics.h>
}

#include "decoder_ffmpeg.h"
extern "C" {
#include "sf.h"
#include "utils.h"
#include "channelmap.h"
}

#ifndef AVCODEC_MAX_AUDIO_FRAME_SIZE
#define AVCODEC_MAX_AUDIO_FRAME_SIZE 192000
#endif

/* --------------------------------------------------------------------- */

// Removing some symbols defined by Cmus.
#define d_print(...)

/* --------------------------------------------------------------------- */

class DecoderFFmpeg::Private {
    public:
        DecoderFFmpeg &owner;
        Private(DecoderFFmpeg &o):owner(o){}
        static int inited;
        AVCodec *codec;
        AVCodecContext *codec_context;
        AVFormatContext *input_context;
        SwrContext *swr;
        int stream_index;
        boost::atomic<sample_format_t> sf;
        channel_position_t channel_map[CHANNELS_MAX];
        AVDictionaryEntry *tag;
        struct ffmpeg_input {
            AVPacket pkt;
            int curr_pkt_size;
            uint8_t *curr_pkt_buf;
            unsigned long curr_size;
            unsigned long curr_duration;
        } *input;

        struct ffmpeg_output {
            uint8_t *buffer;
            uint8_t *buffer_malloc;
            uint8_t *buffer_pos;	/* current buffer position */
            int buffer_used_len;
        } *output;
        struct ffmpeg_input *ffmpeg_input_create(void);
        void ffmpeg_input_free(struct ffmpeg_input *input);
        struct ffmpeg_output *ffmpeg_output_create(void);
        void ffmpeg_output_free(struct ffmpeg_output *output);
        void ffmpeg_buffer_flush(struct ffmpeg_output *output);
        int ffmpeg_fill_buffer();
};

struct DecoderFFmpeg::Private::ffmpeg_input *DecoderFFmpeg::Private::ffmpeg_input_create(void)
{
    struct ffmpeg_input *input = new ffmpeg_input();

    if (av_new_packet(&input->pkt, 0) != 0) {
        delete input;
        return NULL;
    }
    input->curr_pkt_size = 0;
    input->curr_pkt_buf = input->pkt.data;
    return input;
}

void DecoderFFmpeg::Private::ffmpeg_input_free(struct ffmpeg_input *input)
{
    av_free_packet(&input->pkt);
    delete input;
}

struct DecoderFFmpeg::Private::ffmpeg_output *DecoderFFmpeg::Private::ffmpeg_output_create(void)
{
    struct ffmpeg_output *output = new ffmpeg_output();

    output->buffer_malloc = new uint8_t[AVCODEC_MAX_AUDIO_FRAME_SIZE + 15];
    output->buffer = output->buffer_malloc;
    /* align to 16 bytes so avcodec can SSE/Altivec/etc */
    while ((intptr_t) output->buffer % 16)
        output->buffer += 1;
    output->buffer_pos = output->buffer;
    output->buffer_used_len = 0;
    return output;
}

void DecoderFFmpeg::Private::ffmpeg_output_free(struct ffmpeg_output *output)
{
    delete output->buffer_malloc;
    output->buffer_malloc = NULL;
    output->buffer = NULL;
    delete output;
}

void DecoderFFmpeg::Private::ffmpeg_buffer_flush(struct ffmpeg_output *output)
{
    output->buffer_pos = output->buffer;
    output->buffer_used_len = 0;
}

/* ----------------------------------------------------------------- */

int DecoderFFmpeg::Private::inited = 0;

DecoderFFmpeg::DecoderFFmpeg() {
    priv = new Private(*this);
    priv->inited=0;
    priv->codec_context=NULL;
    priv->input_context=NULL;
    priv->codec=NULL;
    priv->swr=NULL;
    priv->tag=NULL;
    priv->input=NULL;
    priv->output=NULL;
}

DecoderFFmpeg::~DecoderFFmpeg() {
    if(this->isopen()) {
        this->close();
    }
    delete priv;
}

int DecoderFFmpeg::open(const char *filename)
{
    int err = 0;
    int stream_index = -1;
    int64_t channel_layout = 0;
    AVCodec *codec;
    AVCodecContext *cc = NULL;
    AVFormatContext *ic = NULL;
    SwrContext *swr = NULL;

    if(!Private::inited) {
        av_register_all();
        Private::inited=1;
    }
    err = avformat_open_input(&ic, filename, NULL, NULL);
    if (err < 0) {
        d_print("av_open failed: %d\n", err);
        return -IP_ERROR_FILE_FORMAT;
    }

    do {
        err = avformat_find_stream_info(ic, NULL);
        if (err < 0) {
            d_print("unable to find stream info: %d\n", err);
            err = -IP_ERROR_FILE_FORMAT;
            break;
        }

        for (unsigned i = 0; i < ic->nb_streams; i++) {
            cc = ic->streams[i]->codec;
            if (cc->codec_type == AVMEDIA_TYPE_AUDIO) {
                stream_index = i;
                break;
            }
        }

        if (stream_index == -1) {
            d_print("could not find audio stream\n");
            err = -IP_ERROR_FILE_FORMAT;
            break;
        }

        codec = avcodec_find_decoder(cc->codec_id);
        if (!codec) {
            d_print("codec not found: %d, %s\n", cc->codec_id, cc->codec_name);
            err = -IP_ERROR_UNSUPPORTED_FILE_TYPE;
            break;
        }

        if (codec->capabilities & CODEC_CAP_TRUNCATED)
            cc->flags |= CODEC_FLAG_TRUNCATED;

        if (avcodec_open2(cc, codec, NULL) < 0) {
            d_print("could not open codec: %d, %s\n", cc->codec_id, cc->codec_name);
            err = -IP_ERROR_UNSUPPORTED_FILE_TYPE;
            break;
        }

        /* We assume below that no more errors follow. */
    } while (0);

    if (err < 0) {
        /* Clean up.  cc is never opened at this point.  (See above assumption.) */
        avformat_close_input(&ic);
        return err;
    }

    priv->codec_context = cc;
    priv->input_context = ic;
    priv->codec = codec;
    priv->stream_index = stream_index;
    priv->input = priv->ffmpeg_input_create();
    if (priv->input == NULL) {
        avcodec_close(cc);
        avformat_close_input(&ic);
        free(priv);
        return -IP_ERROR_INTERNAL;
    }
    priv->output = priv->ffmpeg_output_create();

    /* Prepare for resampling. */
    swr = swr_alloc();
    av_opt_set_int(swr, "in_channel_layout",  av_get_default_channel_layout(cc->channels), 0);
    av_opt_set_int(swr, "out_channel_layout", av_get_default_channel_layout(cc->channels), 0);
    av_opt_set_int(swr, "in_sample_rate",     cc->sample_rate, 0);
    av_opt_set_int(swr, "out_sample_rate",    cc->sample_rate, 0);
    av_opt_set_sample_fmt(swr, "in_sample_fmt",  cc->sample_fmt, 0);
    priv->swr = swr;

    priv->sf = sf_rate(cc->sample_rate) | sf_channels(cc->channels);
    switch (cc->sample_fmt) {
        case AV_SAMPLE_FMT_U8:
            priv->sf |= sf_bits(8) | sf_signed(0);
            av_opt_set_sample_fmt(swr, "out_sample_fmt", AV_SAMPLE_FMT_U8,  0);
            break;
        case AV_SAMPLE_FMT_S32:
            priv->sf |= sf_bits(32) | sf_signed(1);
            av_opt_set_sample_fmt(swr, "out_sample_fmt", AV_SAMPLE_FMT_S32,  0);
            break;
            /* AV_SAMPLE_FMT_S16 */
        default:
            priv->sf |= sf_bits(16) | sf_signed(1);
            av_opt_set_sample_fmt(swr, "out_sample_fmt", AV_SAMPLE_FMT_S16,  0);
            break;
    }
    swr_init(swr);
#ifdef WORDS_BIGENDIAN
    priv->sf |= sf_bigendian(1);
#endif
    channel_layout = cc->channel_layout;
    channel_map_init_waveex(cc->channels, channel_layout, priv->channel_map);
    return 0;
}

void DecoderFFmpeg::close()
{
    avcodec_close(priv->codec_context);
    avformat_close_input(&priv->input_context);
    swr_free(&priv->swr);
    priv->ffmpeg_input_free(priv->input);
    priv->ffmpeg_output_free(priv->output);

    priv->codec_context=NULL;
    priv->input_context=NULL;
    priv->swr=NULL;
    priv->input=NULL;
    priv->output=NULL;
}

int DecoderFFmpeg::Private::ffmpeg_fill_buffer()
{
    AVFrame *frame = avcodec_alloc_frame();
    int got_frame;
    while (1) {
        int len;

        if (input->curr_pkt_size <= 0) {
            av_free_packet(&input->pkt);
            if (av_read_frame(input_context, &input->pkt) < 0) {
                /* Force EOF once we can read no longer. */
                avcodec_free_frame(&frame);
                return 0;
            }
            input->curr_pkt_size = input->pkt.size;
            input->curr_pkt_buf = input->pkt.data;
            input->curr_size += input->pkt.size;
            input->curr_duration += input->pkt.duration;
            continue;
        }

        {
            AVPacket avpkt;
            av_new_packet(&avpkt, input->curr_pkt_size);
            memcpy(avpkt.data, input->curr_pkt_buf, input->curr_pkt_size);
            len = avcodec_decode_audio4(codec_context, frame, &got_frame, &avpkt);
            av_free_packet(&avpkt);
        }
        if (len < 0) {
            /* this is often reached when seeking, not sure why */
            input->curr_pkt_size = 0;
            continue;
        }
        input->curr_pkt_size -= len;
        input->curr_pkt_buf += len;
        if (got_frame) {
            int res = swr_convert(swr,
                    &output->buffer,
                    frame->nb_samples,
                    (const uint8_t **)frame->extended_data,
                    frame->nb_samples);
            if (res < 0)
                res = 0;
            output->buffer_pos = output->buffer;
            output->buffer_used_len = res * codec_context->channels * sizeof(int16_t);
            avcodec_free_frame(&frame);
            return output->buffer_used_len;
        }
    }
    /* This should never get here. */
    return -IP_ERROR_INTERNAL;
}

int DecoderFFmpeg::read(char *buffer, int count)
{
    struct Private::ffmpeg_output *output = priv->output;
    int rc;
    int out_size;

    if (output->buffer_used_len == 0) {
        rc = priv->ffmpeg_fill_buffer();
        if (rc <= 0) {
            return rc;
        }
    }
    out_size = min(output->buffer_used_len, count);
    memcpy(buffer, output->buffer_pos, out_size);
    output->buffer_used_len -= out_size;
    output->buffer_pos += out_size;
    return out_size;
}

int DecoderFFmpeg::seek(double offset)
{
    AVStream *st = priv->input_context->streams[priv->stream_index];
    int ret;

    int64_t pts = av_rescale_q(offset * AV_TIME_BASE, AV_TIME_BASE_Q, st->time_base);

    {
        avcodec_flush_buffers(priv->codec_context);
        /* Force reading a new packet in next ffmpeg_fill_buffer(). */
        priv->input->curr_pkt_size = 0;
    }

    ret = av_seek_frame(priv->input_context, priv->stream_index, pts, 0);

    if (ret < 0) {
        return -IP_ERROR_FUNCTION_NOT_SUPPORTED;
    } else {
        priv->ffmpeg_buffer_flush(priv->output);
        return 0;
    }
}

//TODO Not fully implemented.
int DecoderFFmpeg::read_comments(const char **key, const char **value)
{
    while ((priv->tag =
                av_dict_get(priv->input_context->metadata,
                    "", priv->tag, AV_DICT_IGNORE_SUFFIX)) &&
            !priv->tag->value[0]) {
    }
    if(!priv->tag) {
        return 0;
    } else {
        *key = priv->tag->key;
        *value = priv->tag->value;
    }
    return 1;
}

int DecoderFFmpeg::duration()
{
    return priv->input_context->duration / AV_TIME_BASE;
}

long DecoderFFmpeg::bitrate()
{
    long bitrate = priv->input_context->bit_rate;
    return bitrate ? bitrate : -IP_ERROR_FUNCTION_NOT_SUPPORTED;
}

long DecoderFFmpeg::current_bitrate()
{
    AVStream *st = priv->input_context->streams[priv->stream_index];
    long bitrate = -1;

    /* ape codec returns silly numbers */
    if (priv->codec->id == CODEC_ID_APE)
        return -1;

    if (priv->input->curr_duration > 0) {
        double seconds = priv->input->curr_duration * av_q2d(st->time_base);
        bitrate = (8 * priv->input->curr_size) / seconds;
        priv->input->curr_size = 0;
        priv->input->curr_duration = 0;
    }
    return bitrate;
}

char *DecoderFFmpeg::codec()
{
    return strdup(priv->codec->name);
}

char *DecoderFFmpeg::codec_profile()
{
    const char *profile;
    profile = av_get_profile_name(priv->codec, priv->codec_context->profile);
    return profile ? strdup(profile) : NULL;
}

bool DecoderFFmpeg::isopen()
{
    return priv->input_context;
}

sample_format_t DecoderFFmpeg::get_sf()
{
    return priv->sf;
}

channel_position_t *DecoderFFmpeg::get_channelmap()
{
    return priv->channel_map;
}
