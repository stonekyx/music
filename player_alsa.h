#ifndef PLAYER_ALSA_H

#define PLAYER_ALSA_H

extern "C" {
#include "player.h"
#include "sf.h"
#include "channelmap.h"
}

class PlayerALSA : public Player {
    private:
        class Private;
        Private *priv;
        bool opened;
    public:
        PlayerALSA();
        ~PlayerALSA();
        int init();
        int exit();
        int open(sample_format_t sf, const channel_position_t *channel_map);
        bool isopen();
        int close();
        int drop();
        int write(const char *, int);
        int buffer_space();
        int pause();
        int unpause();
        int set_option(int, const char *);
        int get_option(int, char **);
};

#endif
