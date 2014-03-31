#include "playlist.h"

using namespace std;

Playlist::Playlist():
    data(vector<Trackinfo>())
{
    it = data.begin();
}

Playlist::~Playlist()
{
    data.clear();
}

void Playlist::add(const Trackinfo &o)
{
    data.push_back(o);
}

bool Playlist::remove(const string &o)
{
    for(vector<Trackinfo>::iterator it = data.begin();
            it!=data.end();
            it++) {
        if(o==it->path) {
            data.erase(it);
            return true;
        }
    }
    return false;
}

const Trackinfo &Playlist::it_get()
{
    return *it;
}

bool Playlist::it_next()
{
    if(it!=data.end()) {
        it++;
        return true;
    }
    return false;
}

void Playlist::it_reset()
{
    it = data.begin();
}
