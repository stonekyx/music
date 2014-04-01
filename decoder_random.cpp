#include "decoder_random.h"
#include <cstdlib>
#include <ctime>
#include <climits>

using namespace std;

DecoderRandom::DecoderRandom()
{
    srand(time(NULL));
}

DecoderRandom::~DecoderRandom()
{
}

int DecoderRandom::open(const char *filename)
{
    filename=filename;
    return 0;
}

void DecoderRandom::close()
{
}

int DecoderRandom::read(char *buf, int count)
{
    if(count==0) return 0;
    buf[0]=rand()%95+32;
    return 1;
}

int DecoderRandom::seek(double offset)
{
    offset=offset;
    return 0;
}

int DecoderRandom::read_comments(const char **, const char **)
{
    return 0;
}

int DecoderRandom::duration()
{
    return INT_MAX;
}

long DecoderRandom::bitrate()
{
    return 0;
}

long DecoderRandom::current_bitrate()
{
    return 0;
}

char *DecoderRandom::codec()
{
    return NULL;
}

char *DecoderRandom::codec_profile()
{
    return NULL;
}

bool DecoderRandom::isopen()
{
    return true;
}
