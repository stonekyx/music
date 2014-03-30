#ifndef DECODE_H

#define DECODE_H

#include "sf.h"
#include "channelmap.h"

class Decoder {
    private:
    public:
        virtual ~Decoder()=0;
        virtual int open(const char *filename)=0;
        virtual void close()=0;
        virtual int read(char *, int)=0;
        virtual int seek(double)=0;
        virtual int read_comments()=0; //TODO Not fully implemented.
        virtual int duration()=0;
        virtual long bitrate()=0;
        virtual long current_bitrate()=0;
        virtual char *codec()=0;
        virtual char *codec_profile()=0;
        virtual bool isopen()=0;
        virtual sample_format_t get_sf()=0;
        virtual channel_position_t *get_channelmap()=0;
        enum ErrorTypes {
            IP_ERROR_FILE_FORMAT,
            IP_ERROR_UNSUPPORTED_FILE_TYPE,
            IP_ERROR_INTERNAL,
            IP_ERROR_FUNCTION_NOT_SUPPORTED,
            IP_ERROR_MAX
        };
    protected:
};

#endif
