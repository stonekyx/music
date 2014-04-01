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
        Playlist();
        ~Playlist();
        template<typename T> void sort(T comp) {
            stable_sort(data.begin(), data.end(), comp);
        }
        void add(const Trackinfo &);
        bool remove(const std::string &);
        const Trackinfo &it_get();
        bool it_next();
        void it_reset();
        void readfile(const char *);
    protected:
        std::vector<Trackinfo>::iterator it;
};

#endif
