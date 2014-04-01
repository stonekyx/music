#include <fstream>

#include "pc_boost.h"
#include "playlist.h"

#ifndef PATH_MAX
#define PATH_MAX 4096
#endif

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

void Playlist::readfile(const char *filename)
{
    ifstream file(filename);
    static char buf[PATH_MAX];
    Trackinfo ti_buf;
    while(file.getline(buf, PATH_MAX)) {
        Application::read_comments(buf, ti_buf);
        this->add(ti_buf);
    }
    file.close();
}
