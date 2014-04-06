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

bool Playlist::remove(unsigned int idx)
{
    if(idx>=data.size()) return false;
    data.erase(data.begin()+idx);
    return true;
}

void Playlist::clear()
{
    data.clear();
}

int Playlist::size()
{
    return data.size();
}

Playlist::iterator Playlist::begin()
{
    return data.begin();
}

Playlist::iterator Playlist::end()
{
    return data.end();
}

Playlist::const_iterator Playlist::begin() const
{
    return data.begin();
}

Playlist::const_iterator Playlist::end() const
{
    return data.end();
}

void Playlist::readfile(const char *filename)
{
    ifstream file(filename);
    static char buf[PATH_MAX];
    Trackinfo ti_buf;
    while(file.getline(buf, PATH_MAX)) {
        Application::read_comments(buf, ti_buf);
        ti_buf.path = buf;
        this->add(ti_buf);
    }
    file.close();
}

void Playlist::save(const char *filename)
{
    ofstream file(filename);
    for(Playlist::iterator it = this->begin();
            it!=this->end(); it++) {
        file<<it->path<<endl;
    }
    file.close();
}
