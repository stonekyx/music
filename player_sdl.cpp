#include <SDL2/SDL_audio.h>
#include <SDL2/SDL.h>
#include <cstring>

#include "pc_boost_monitor.h"
#include "chunk.h"

#include "player_sdl.h"

class PlayerSDL::Private {
    public:
        SDL_AudioSpec wanted;
        static void fill_audio(void *, Uint8 *, int);
        SDL_AudioFormat sf_get_format(sample_format_t sf);
        sample_format_t sf;
        bool isopen;
        Monitor<Chunk> *mon;
};

void PlayerSDL::Private::fill_audio(
        void *udata, Uint8 *stream, int len)
{
    PlayerSDL::Private *priv = (PlayerSDL::Private*)udata;
    static Chunk chunk(1);
    static bool readnext=true;
    while(len>0) {
        if(readnext && !priv->mon->read(chunk)) {
            memset(stream, 0, len);
            return;
        }
        int copylen = len;
        if(copylen>chunk.h-chunk.l) {
            copylen = chunk.h-chunk.l;
        }
        memcpy(stream, chunk.buf+chunk.l, copylen);
        chunk.l+=copylen;
        len-=copylen;
        stream+=copylen;
        readnext = (chunk.l>=chunk.h);
    }
}

SDL_AudioFormat PlayerSDL::Private::sf_get_format(sample_format_t sf)
{
    //mapping[bits][signed][bigendian]
    static const SDL_AudioFormat mapping[3][2][2] = {
        {{AUDIO_U8, AUDIO_U8}, {AUDIO_S8, AUDIO_S8},},
        {{AUDIO_U16, AUDIO_U16MSB}, {AUDIO_S16, AUDIO_S16MSB},},
        {{AUDIO_S32, AUDIO_S32MSB}, {AUDIO_S32, AUDIO_S32MSB},},
    };
    switch(sf_get_bits(sf)) {
        case 8:
            return mapping[0]
                [sf_get_signed(sf)][sf_get_bigendian(sf)];
        case 32:
            return mapping[2]
                [sf_get_signed(sf)][sf_get_bigendian(sf)];
        case 16:
        default:
            return mapping[1]
                [sf_get_signed(sf)][sf_get_bigendian(sf)];
    }
}

//-------------------------------------------------------

PlayerSDL::PlayerSDL()
{
    priv = new Private();
    priv->isopen = false;
    priv->mon = new Monitor<Chunk>(64);
}

PlayerSDL::~PlayerSDL()
{
    delete priv->mon;
    delete priv;
}

int PlayerSDL::init()
{
    return 0;
}

int PlayerSDL::exit()
{
    return 0;
}

int PlayerSDL::open(sample_format_t sf, const channel_position_t *cp)
{
    (void)cp;
    priv->wanted.freq = sf_get_rate(sf)/*sf_get_channels(sf)*/;
    priv->wanted.format = priv->sf_get_format(sf);
    priv->wanted.channels = sf_get_channels(sf);
    priv->wanted.samples = 1024;
    priv->wanted.callback = priv->fill_audio;
    priv->wanted.userdata = (void*)priv;
    if(SDL_OpenAudio(&priv->wanted, NULL)<0) {
        return -OP_ERROR_NOT_OPEN;
    }
    priv->isopen = true;
    priv->sf = sf;
    SDL_PauseAudio(0);
    return OP_ERROR_SUCCESS;
}

bool PlayerSDL::isopen()
{
    return priv->isopen;
}

int PlayerSDL::close()
{
    SDL_CloseAudio();
    priv->isopen=false;
    return 0;
}

int PlayerSDL::drop()
{
    priv->mon->clear();
    return 0;
}

int PlayerSDL::write(const char *buf, int cnt)
{
    static Chunk chunk;
    chunk.h=cnt;
    chunk.l=0;
    memcpy(chunk.buf, buf, cnt);
    cnt=priv->mon->write(chunk)?cnt:0;
    return cnt;
}

int PlayerSDL::buffer_space() //TODO: not implemented.
{
    return 0;
}

int PlayerSDL::pause()
{
    SDL_PauseAudio(1);
    return 0;
}

int PlayerSDL::unpause()
{
    SDL_PauseAudio(0);
    return 0;
}

int PlayerSDL::set_option(int key, const char *val)
{
    key=key;
    val=val;
    return 0;
}

int PlayerSDL::get_option(int key, char **val)
{
    key=key;
    val=val;
    return 0;
}
