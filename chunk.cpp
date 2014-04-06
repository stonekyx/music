#include <cstring>

#include "chunk.h"

Chunk::Chunk()
{ init(60*1024); }

Chunk::Chunk(int bufsize)
{ init(bufsize); }

void Chunk::init(int bufsize)
{
    l=h=0;
    buf = new char[bufsize];
    this->bufsize = bufsize;
}

Chunk::Chunk(const Chunk &o)
{
    this->buf=NULL;
    *this=o;
}

Chunk::~Chunk()
{
    delete[] buf;
}

bool Chunk::operator==(const Chunk &o1) const
{
    return this->buf==o1.buf && this->l==o1.l && this->h==o1.h &&
        this->bufsize==o1.bufsize;
}

Chunk &Chunk::operator=(const Chunk &o)
{
    if(this->buf!=o.buf) {
        if(this->buf) delete[] this->buf;
        this->buf=new char[o.bufsize];
        memcpy(this->buf, o.buf, o.bufsize);
        this->l=o.l;
        this->h=o.h;
        this->bufsize=o.bufsize;
    }
    return *this;
}
