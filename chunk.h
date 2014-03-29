#ifndef CHUNK_H

#define CHUNK_H

#include <boost/shared_array.hpp>

class Chunk {
    private:
        void init(int);
    public:
        boost::shared_array<char> buf;
        int l, h;
        int bufsize;
        Chunk();
        Chunk(int);
        ~Chunk();
        bool operator==(const Chunk &) const;
};

#endif
