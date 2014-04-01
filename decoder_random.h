#ifndef DECODER_RANDOM_H

#define DECODER_RANDOM_H

#include "decoder.h"

class DecoderRandom : public Decoder {
    public:
        DecoderRandom();
        ~DecoderRandom();
        int open(const char *filename);
        void close();
        int read(char *, int);
        int seek(double);
        int read_comments(const char **, const char **);
        int duration();
        long bitrate();
        long current_bitrate();
        char *codec();
        char *codec_profile();
        bool isopen();
};

#endif
