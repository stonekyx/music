#include <iostream>
#include <fstream>
#include <boost/thread.hpp>
#include <boost/atomic.hpp>

#include "decoder_ffmpeg.h"
#include "player_alsa.h"
#include "utils.h"

#include "pc_boost.h"

using namespace std;

//This method is call in multiple threads
inline bool Application::wait_on_state()
{
    if(state!=STATE_PAUSE && state!=STATE_STOP) {
        return true;
    }
    boost::unique_lock<boost::mutex> mutex_lock(mutex);
    if(state!=STATE_PAUSE && state!=STATE_STOP) {
        return true;
    }
    cond.wait(mutex_lock);
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
        if(state==STATE_STOP) {
            decoder->seek(0);
            reset_chunk(&chunk);
            readnext=true;
        }
        if(!wait_on_state()) {
            continue;
        }
        if(state==STATE_QUIT) {
            reset_chunk(&chunk);
            cout<<"producer exiting..."<<endl;
            return;
        }
        if(readnext) {
            reset_chunk(&chunk);
            chunk = new Chunk();
            int err = decoder->read(chunk->buf.get(), chunk->bufsize);
            if(err==0) {
                cout<<"producer EOF"<<endl;
                this->quit();
                delete chunk;
                cout<<"producer exiting..."<<endl;
                return;
            }
            if(err<0) continue;
            chunk->l=0;
            chunk->h=err;
        }
        readnext = mon->write(*chunk);
        if(!readnext) {
            ms_sleep(50);
        }
    }
}

void Application::consumer() {
    bool readnext=true;
    Chunk *chunk=NULL;
    while(1) {
        if(!wait_on_state()) {
            continue;
        }
        if(readnext || state==STATE_STOP) {
            chunk = &mon->read();
        }
        if(*chunk==eof) {
            if(state==STATE_QUIT && mon->get_count()==0) {
                cout<<"consumer exiting..."<<endl;
                return;
            }
            ms_sleep(50);
        } else {
            /*outfile.write(chunk->buf.get(),
                    chunk->h - chunk->l);
            outfile.flush();
            int rc=chunk->h-chunk->l;*/
            int rc = player->write(chunk->buf.get()+chunk->l,
                    chunk->h - chunk->l);
            if(rc>0) {
                chunk->l += rc;
            }
            readnext = (chunk->l>=chunk->h);
        }
    }
}

void Application::watcher()
{
    int last=0;
    while(1) {
        if(state==STATE_QUIT && mon->get_count()<=0) {
            cout<<"watcher exiting..."<<endl;
            return;
        }
        sleep(1);
        cout<<mon->statis-last<<"\t"<<mon->get_count()<<endl;
        last = mon->statis;
    }
}

Application::Application():eof(Chunk(1))
{ init(128); }

Application::Application(int bufsize):eof(Chunk(1))
{ init(bufsize); }

void Application::init(int bufsize)
{
    state = STATE_PAUSE;
    mon = new Monitor<Chunk>(bufsize, eof);
    decoder = new DecoderFFmpeg();
    player = new PlayerALSA();
    player->init();
    th_prod = boost::thread(boost::bind(&Application::producer, this));
    th_cons = boost::thread(boost::bind(&Application::consumer, this));
    th_watch = boost::thread(boost::bind(&Application::watcher, this));
}

Application::~Application()
{
    th_prod.join();
    th_cons.join();
    th_watch.join();
    delete mon;
    delete decoder;
    delete player;
}

int Application::open(const char *filename)
{
    this->close();
    outfile.open("/tmp/test.wav");
    //state is not changed.
    return decoder->open(filename);
}

void Application::close()
{
    if(decoder->isopen()) {
        decoder->close();
    }
    if(outfile.is_open()) {
        outfile.close();
    }
    if(player->isopen()) {
        player->close();
    }
}

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
    player->pause();
    state = STATE_PAUSE;
}

void Application::stop()
{
    state = STATE_STOP;
    cond.notify_all();
    mon->clear();
}

void Application::quit()
{
    state = STATE_QUIT;
    cond.notify_all();
}
