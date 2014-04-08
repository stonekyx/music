#ifndef PLAYER_SDL_H

#define PLAYER_SDL_H

#include "player.h"
#include "sf.h"
#include "channelmap.h"

class PlayerSDL : public Player {
    private:
        class Private;
        Private *priv;
    public:
        ~PlayerSDL();
        PlayerSDL();
        int init();
        int exit();
        int open(sample_format_t, const channel_position_t *);
        bool isopen();
        int close();
        int drop();
        int write(const char *, int);
        int buffer_space();
        int pause();
        int unpause();
        int set_option(int, const char *);
        int get_option(int, char **);
    protected:
};

#endif
