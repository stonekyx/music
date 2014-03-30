#include "chunk.h"

using namespace std;

Chunk::Chunk()
{ init(60*1024); }

Chunk::Chunk(int bufsize)
{ init(bufsize); }

void Chunk::init(int bufsize)
{
    l=h=0;
    boost::shared_array<char> tmpbuf(new char[bufsize]);
    buf = tmpbuf;
    this->bufsize = bufsize;
}

Chunk::~Chunk()
{
    buf.reset();
}

bool Chunk::operator==(const Chunk &o1) const
{
    return this->buf==o1.buf && this->l==o1.l && this->h==o1.h &&
        this->bufsize==o1.bufsize;
}
