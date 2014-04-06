#ifndef PLAYLIST_H

#define PLAYLIST_H

#include <vector>
#include <string>
#include <algorithm>
#include "trackinfo.h"

class Playlist {
    private:
        std::vector<Trackinfo> data;
    public:
        typedef std::vector<Trackinfo>::iterator iterator;
        typedef std::vector<Trackinfo>::const_iterator const_iterator;
        Playlist();
        ~Playlist();
        template<typename T> void sort(T comp, iterator &it);
        void add(const Trackinfo &);
        bool remove(const std::string &);
        bool remove(unsigned int idx);
        void clear();
        int size();
        iterator begin();
        iterator end();
        const_iterator begin() const;
        const_iterator end() const;
        void readfile(const char *);
        void save(const char *);
    protected:
};

template<typename T>
void Playlist::sort(T comp, Playlist::iterator &it)
{
    Trackinfo &old = *it;
    stable_sort(data.begin(), data.end(), comp);
    for(Playlist::iterator p = data.begin(); p!=data.end(); p++) {
        if(*p==old) {
            it=p;
            return;
        }
    }
}

#endif
