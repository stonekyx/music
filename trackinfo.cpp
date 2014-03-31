#include "trackinfo.h"

bool TICTitle::operator()(const Trackinfo &o1, const Trackinfo &o2)
{
    int res;
    if((res=o1.title.compare(o2.title))) {
        return res<0;
    }
    if((res=o1.album.compare(o2.album))) {
        return res<0;
    }
    if((res=o1.artist.compare(o2.artist))) {
        return res<0;
    }
    return false;
}

bool TICAlbum::operator()(const Trackinfo &o1, const Trackinfo &o2)
{
    int res;
    if((res=o1.album.compare(o2.album))) {
        return res<0;
    }
    if((res=o1.artist.compare(o2.artist))) {
        return res<0;
    }
    if((res=o1.title.compare(o2.title))) {
        return res<0;
    }
    return false;
}

bool TICArtist::operator()(const Trackinfo &o1, const Trackinfo &o2)
{
    int res;
    if((res=o1.artist.compare(o2.artist))) {
        return res<0;
    }
    if((res=o1.album.compare(o2.album))) {
        return res<0;
    }
    if((res=o1.title.compare(o2.title))) {
        return res<0;
    }
    return false;
}
