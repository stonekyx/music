#ifndef DECODER_FFMPEG_H

#define DECODER_FFMPEG_H

extern "C" {
#include "sf.h"
#include "channelmap.h"
#include "decoder.h"
}

class DecoderFFmpeg : public Decoder {
    private:
        class Private;
        Private *priv;
    public:
        DecoderFFmpeg();
        ~DecoderFFmpeg();
        int open(const char *filename);
        void close();
        int read(char *, int);
        int seek(double);
        int read_comments(const char **, const char **); //TODO Not fully implemented.
        int duration();
        long bitrate();
        long current_bitrate();
        char *codec();
        char *codec_profile();
        bool isopen();
        sample_format_t get_sf();
        channel_position_t *get_channelmap();
    protected:
};

#endif
