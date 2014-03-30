#ifndef PLAYER_H

#define PLAYER_H

#include "sf.h"
#include "channelmap.h"

class Player {
    private:
    public:
        virtual ~Player()=0;
        virtual int init()=0;
        virtual int exit()=0;
        virtual int open(sample_format_t sf, const channel_position_t *channel_map)=0;
        virtual bool isopen()=0;
        virtual int close()=0;
        virtual int drop()=0;
        virtual int write(const char *, int)=0;
        virtual int buffer_space()=0;
        virtual int pause()=0;
        virtual int unpause()=0;
        virtual int set_option(int, const char *)=0;
        virtual int get_option(int, char **)=0;
        enum ErrorTypes {
            /* no error */
            OP_ERROR_SUCCESS,
            /* system error (error code in errno) */
            OP_ERROR_ERRNO,
            /* no such plugin */
            OP_ERROR_NO_PLUGIN,
            /* plugin not initialized */
            OP_ERROR_NOT_INITIALIZED,
            /* function not supported */
            OP_ERROR_NOT_SUPPORTED,
            /* mixer not open */
            OP_ERROR_NOT_OPEN,
            /* plugin does not support the sample format */
            OP_ERROR_SAMPLE_FORMAT,
            /* plugin does not have this option */
            OP_ERROR_NOT_OPTION,
            /*  */
            OP_ERROR_INTERNAL
        };
    protected:
};

#endif
