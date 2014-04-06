#ifndef CHUNK_H

#define CHUNK_H

class Chunk {
    private:
        void init(int);
    public:
        char *buf;
        int l, h;
        int bufsize;
        Chunk();
        Chunk(int);
        Chunk(const Chunk &);
        ~Chunk();
        bool operator==(const Chunk &) const;
        Chunk &operator=(const Chunk &);
};

#endif
