#include <iostream>
#include <fstream>
#include <boost/thread.hpp>
#include <boost/atomic.hpp>
#include <cstdlib>
#include <ctime>

#include "decoder_ffmpeg.h"

#include "pc_boost.h"

using namespace std;

void Application::producer() {
    while(1) {
        if(state==STATE_PAUSE) {
            boost::unique_lock<boost::mutex> mutex_lock(mutex);
            if(state==STATE_PLAY) continue;
            cond.wait(mutex_lock);
            continue;
        }
        Chunk chunk;
        int err = decoder->read(chunk.buf.get(), chunk.bufsize);
        if(err==0) {
            cout<<"producer EOF"<<endl;
            this->quit();
            cout<<"producer exiting..."<<endl;
            return;
        }
        if(err<0) continue;
        chunk.l=0;
        chunk.h=err;
        mon->write(chunk);
    }
}

void Application::consumer() {
    while(1) {
        if(state==STATE_PAUSE) {
            boost::unique_lock<boost::mutex> mutex_lock(mutex);
            if(state==STATE_PLAY) continue;
            cond.wait(mutex_lock);
            continue;
        }
        Chunk &chunk = mon->read();
        if(chunk==eof) {
            if(state==STATE_QUIT) {
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
    srand(time(NULL));
    state = STATE_PAUSE;
    mon = new Monitor<Chunk>(bufsize, eof);
    decoder = new DecoderFFmpeg();
    decoder->open("bleu.flac");
    outfile.open("/tmp/test.wav");
    th_prod = boost::thread(boost::bind(&Application::producer, this));
    th_cons = boost::thread(boost::bind(&Application::consumer, this));
    th_watch = boost::thread(boost::bind(&Application::watcher, this));
}

Application::~Application()
{
    outfile.close();
    decoder->close();
    th_prod.join();
    th_cons.join();
    th_watch.join();
}

void Application::play()
{
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
    decoder->close();
    mon->clear();
}

void Application::quit()
{
    state = STATE_QUIT;
    cond.notify_all();
}
