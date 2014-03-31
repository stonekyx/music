#include <boost/thread.hpp>
#include <boost/atomic.hpp>

#include "decoder_ffmpeg.h"
#include "player_alsa.h"
#include "utils.h"

#include "pc_boost.h"

using namespace std;

//This method is call in multiple threads
inline bool Application::wait_on_state(boost::mutex &thread_mutex)
{
    if(state!=STATE_PAUSE && state!=STATE_STOP) {
        return true;
    }
    boost::unique_lock<boost::mutex> mutex_lock(mutex);
    if(state!=STATE_PAUSE && state!=STATE_STOP) {
        return true;
    }
    thread_mutex.unlock();
    cond.wait(mutex_lock);
    thread_mutex.lock();
    return false;
}

inline void Application::reset_chunk(Chunk **chunk)
{
    if(*chunk) {
        delete *chunk;
        *chunk=NULL;
    }
}

void Application::producer() {
    bool readnext = true;
    Chunk *chunk = NULL;
    while(1) {
        mutex_prod.lock();
        if(state==STATE_STOP) {
            decoder->seek(0);
            reset_chunk(&chunk);
            readnext=true;
        }
        if(!wait_on_state(mutex_prod)) {
            mutex_prod.unlock();
            continue;
        }
        if(readnext) {
            reset_chunk(&chunk);
            chunk = new Chunk();
            int err = decoder->read(chunk->buf.get(), chunk->bufsize);
            if(err==0) {
                //TODO deal with EOF
                ms_sleep(50);
            }
            if(err<0) {
                mutex_prod.unlock();
                continue;
            }
            chunk->l=0;
            chunk->h=err;
        }
        readnext = mon->write(*chunk);
        if(!readnext) {
            ms_sleep(50);
        }
        mutex_prod.unlock();
    }
}

void Application::consumer() {
    bool readnext=true;
    Chunk *chunk=NULL;
    while(1) {
        mutex_cons.lock();
        if(state==STATE_STOP) {
            readnext=true;
        }
        if(!wait_on_state(mutex_cons)) {
            mutex_cons.unlock();
            continue;
        }
        if(readnext) {
            chunk = &mon->read();
            softvol.scale_samples(chunk->buf.get(),
                    chunk->h - chunk->l, decoder->get_sf());
        }
        if(*chunk==eof) {
            ms_sleep(50);
        } else {
            int rc = player->write(chunk->buf.get()+chunk->l,
                    chunk->h - chunk->l);
            if(rc>0) {
                chunk->l += rc;
            }
            readnext = (chunk->l>=chunk->h);
        }
        mutex_cons.unlock();
    }
}

Application::Application():
    eof(1),pl(),softvol()
{ init(128); }

Application::Application(int bufsize):
    eof(1),pl(),softvol()
{ init(bufsize); }

void Application::init(int bufsize)
{
    state = STATE_PAUSE;
    //TODO: pl.load();
    mon = new Monitor<Chunk>(bufsize, eof);
    decoder = new DecoderFFmpeg();
    player = new PlayerALSA();
    player->init();
    th_prod = boost::thread(boost::bind(&Application::producer, this));
    th_cons = boost::thread(boost::bind(&Application::consumer, this));
}

Application::~Application()
{
    //TODO: pl.save();
    th_prod.join();
    th_cons.join();
    delete mon;
    delete decoder;
    delete player;
}

int Application::open(const char *filename)
{
    this->close();
    //state is not changed.
    return decoder->open(filename);
}

void Application::close()
{
    if(decoder->isopen()) {
        decoder->close();
    }
    if(player->isopen()) {
        player->close();
    }
}

//TODO: play without open: playlist.
void Application::play()
{
    if(!decoder->isopen()) {
        return;
    }
    if(!player->isopen()) {
        player->open(decoder->get_sf(), decoder->get_channelmap());
    }
    state = STATE_PLAY;
    cond.notify_all();
    player->unpause();
}

void Application::pause()
{
    if(state==STATE_STOP) {
        return;
    }
    player->pause();
    state = STATE_PAUSE;
}

void Application::stop()
{
    state = STATE_STOP;
    mon->clear();
    cond.notify_all();
}

void Application::seek(double offset)
{
    mutex_prod.lock();
    mutex_cons.lock();

    decoder->seek(offset);
    mon->clear();

    mutex_cons.unlock();
    mutex_prod.unlock();
}
