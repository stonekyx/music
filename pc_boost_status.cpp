#include "pc_boost.h"

bool Application::get_ti(Trackinfo &buf)
{
    mutex_pl.lock();
    if(pl_pos==pl.end()) {
        mutex_pl.unlock();
        return false;
    }
    buf = *pl_pos;
    mutex_pl.unlock();
    return true;
}

char *Application::get_codec_type()
{
    mutex_prod.lock();
    char *res = decoder->codec();
    mutex_prod.unlock();
    return res;
}
