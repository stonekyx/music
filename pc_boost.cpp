#include <iostream>
#include <boost/thread.hpp>
#include <boost/atomic.hpp>
#include <cstdlib>
#include <ctime>

#include "pc_boost.h"

using namespace std;

void Application::producer() {
    while(1) {
        if(state==STATE_QUIT) {
            //cout<<"producer exiting..."<<endl;
            return;
        }
        if(state!=STATE_PLAY) {
            boost::unique_lock<boost::mutex> mutex_lock(mutex);
            if(state==STATE_PLAY) continue;
            cond.wait(mutex_lock);
            continue;
        }
        mon->write(rand()%95+32);
    }
}

void Application::consumer() {
    while(1) {
        if(state==STATE_QUIT) {
            //cout<<"consumer exiting..."<<endl;
            return;
        }
        if(state!=STATE_PLAY) {
            boost::unique_lock<boost::mutex> mutex_lock(mutex);
            if(state==STATE_PLAY) continue;
            cond.wait(mutex_lock);
            continue;
        }
        mon->read();
    }
}

void Application::watcher()
{
    int last=0;
    while(1) {
        if(state==STATE_QUIT) {
            //cout<<"watcher exiting..."<<endl;
            return;
        }
        sleep(1);
        cout<<mon->statis-last<<endl;
        last = mon->statis;
    }
}

Application::Application()
{ init(128); }

Application::Application(int bufsize)
{ init(bufsize); }

void Application::init(int bufsize)
{
    srand(time(NULL));
    state = STATE_STOP;
    mon = new Monitor<char>(bufsize);
    th_prod = boost::thread(boost::bind(&Application::producer, this));
    th_cons = boost::thread(boost::bind(&Application::consumer, this));
    th_watch = boost::thread(boost::bind(&Application::watcher, this));
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
    mon->clear();
}

void Application::quit()
{
    state = STATE_QUIT;
    th_prod.join();
    th_cons.join();
    th_watch.join();
}
