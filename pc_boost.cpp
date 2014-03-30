#include <iostream>
#include <fstream>
#include <boost/thread.hpp>
#include <boost/atomic.hpp>

#include "decoder_ffmpeg.h"
#include "decoder_random.h"

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

void Application::producer() {
    bool readnext = true;
    Chunk *chunk = NULL;
    while(1) {
        if(!wait_on_state()) {
            continue;
        }
        if(state==STATE_QUIT) {
            if(chunk) delete chunk;
            cout<<"producer exiting..."<<endl;
            return;
        }
        if(readnext) {
            if(chunk) {
                delete chunk;
            }
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
    }
}

void Application::consumer() {
    while(1) {
        if(!wait_on_state()) {
            continue;
        }
        Chunk &chunk = mon->read();
        if(chunk==eof) {
            if(state==STATE_QUIT && mon->get_count()==0) {
                cout<<"consumer exiting..."<<endl;
                return;
            }
        } else {
            outfile.write(chunk.buf.get(), chunk.h-chunk.l);
            outfile.flush();
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
    decoder = new DecoderRandom();
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
}

void Application::play()
{
    if(!decoder->isopen()) {
        return;
    }
    state = STATE_PLAY;
    cond.notify_all();
}

void Application::pause()
{
    state = STATE_PAUSE;
}

void Application::stop()
{
    state = STATE_STOP;
    cond.notify_all();
    if(decoder->isopen()) {
        decoder->seek(0);
    }
    mon->clear();
}

void Application::quit()
{
    state = STATE_QUIT;
    cond.notify_all();
}
