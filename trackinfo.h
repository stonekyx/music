#ifndef TRACKINFO_H

#define TRACKINFO_H

#include <string>

class Trackinfo {
    private:
    public:
        std::string path;
        std::string title;
        std::string artist;
        std::string album;
    protected:
};

class TIComparator {
    private:
    public:
        virtual bool operator()(const Trackinfo &, const Trackinfo &)=0;
    protected:
};

class TICTitle : public TIComparator {
    public:
        bool operator()(const Trackinfo &, const Trackinfo &);
};

class TICAlbum : public TIComparator {
    public:
        bool operator()(const Trackinfo &, const Trackinfo &);
};

class TICArtist : public TIComparator {
    public:
        bool operator()(const Trackinfo &, const Trackinfo &);
};

#endif
