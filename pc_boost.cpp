#include <boost/thread.hpp>
#include <boost/atomic.hpp>
#include <iostream>

#include "decoder_ffmpeg.h"
#include "player_alsa.h"
#include "player_sdl.h"
#include "utils.h"

#include "pc_boost.h"

using namespace std;

//This method is called in multiple threads
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

void Application::producer() {
    bool readnext = true;
    Chunk chunk;
    while(1) {
        mutex_prod.lock();
        if(state==STATE_STOP) {
            if(decoder->isopen()) {
                decoder->seek(0);
            }
            readnext=true;
        }
        if(!wait_on_state(mutex_prod)) {
            mutex_prod.unlock();
            continue;
        }
        if(readnext) {
            int err=0;
            if(decoder->isopen()) {
                err = decoder->read(chunk.buf, chunk.bufsize);
                //if(err>0) cout<<"read chunk, size: "<<err<<endl;
            }
            if(err==0) { //EOF or decoder closed
                if(state==STATE_FLUSHED) {
                    mutex_prod.unlock();
                    this->next();
                    mutex_prod.lock();
                }
                mutex_prod.unlock();
                ms_sleep(50);
                continue;
            }
            if(err<0) {
                mutex_prod.unlock();
                continue;
            }
            chunk.l=0;
            chunk.h=err;
            State expected = STATE_FLUSHED;
            state.compare_exchange_strong(expected, STATE_PLAY,
                    boost::memory_order_release);
        }
        readnext = mon->write(chunk);
        if(!readnext) {
            ms_sleep(50);
        }
        mutex_prod.unlock();
    }
}

void Application::consumer() {
    bool readnext=true;
    Chunk chunk(1);
    bool got_chunk = false;
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
            if((got_chunk = mon->read(chunk))) {
                softvol.scale_samples(chunk.buf,
                        chunk.h-chunk.l, decoder->get_sf());
                //fout.write(chunk.buf, chunk.h-chunk.l);
            }
        }
        if(!got_chunk) {
            if(player->buffer_space()<=0) {
                cout<<"flushed"<<endl;
                State expected = STATE_PLAY;
                state.compare_exchange_strong(expected, STATE_FLUSHED);
            }
            //whether switching to pause/stop depends on producer.
            ms_sleep(50);
        } else {
            cout<<"ready to write chunk"<<endl;
            int rc = player->write(chunk.buf+chunk.l,
                    chunk.h-chunk.l);
            if(rc>0) {
                chunk.l += rc;
                consumer_pos += rc;
            }
            if(rc==0) {
                ms_sleep(25);
            }
            cout<<rc<<endl;
            readnext = (chunk.l>=chunk.h);
        }
        mutex_cons.unlock();
    }
}

Application::Application():
    softvol(),pl(),pl_pos(pl.begin())
{ init(128); }

Application::Application(int bufsize):
    softvol(),pl(),pl_pos(pl.begin())
{ init(bufsize); }

void Application::init(int bufsize)
{
    pl_moving = true;
    pl_cycling = true;
    state = STATE_PAUSE;
    pl_load();
    mon = new Monitor<Chunk>(bufsize);
    decoder = new DecoderFFmpeg();
    player = new PlayerSDL();
    player->init();
    th_prod = boost::thread(boost::bind(&Application::producer, this));
    th_cons = boost::thread(boost::bind(&Application::consumer, this));
}

Application::~Application()
{
    pl_save();
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
    int res = decoder->open(filename);
    return res;
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

void Application::play()
{
    /*static char cnt[]="0";
    string filename = "/tmp/out.wav";
    filename.append(cnt);
    (*cnt)++;
    fout.open(filename);*/
    cout<<"decoder isopen"<<endl;
    if(!decoder->isopen()) {
        mutex_pl.lock();
        if(pl_pos!=pl.end()) {
            mon->clear();
            decoder->open(pl_pos->path.c_str());
            mutex_pl.unlock();
        } else {
            mutex_pl.unlock();
            return;
        }
    }
    cout<<"player isopen"<<endl;
    if(!player->isopen()) {
        cout<<"player open"<<endl;
        player->open(decoder->get_sf(), decoder->get_channelmap());
        ispaused=false;
    }
    cout<<"state play"<<endl;
    state = STATE_PLAY;
    cout<<"playing"<<endl;
    cond.notify_all();
    if(ispaused) {
        player->unpause();
        ispaused=false;
    }
}

void Application::play(int idx)
{
    if(idx<pl.size()) {
        this->stop();
        pl_pos = pl.begin()+idx;
        this->play();
    }
}

void Application::pause()
{
    if(state==STATE_STOP) {
        return;
    }
    player->pause();
    ispaused=true;
    state = STATE_PAUSE;
    cout<<"pause"<<endl;
}

void Application::stop()
{
    state = STATE_STOP;
    mutex_cons.lock();
    mutex_prod.lock();
    /*cout<<"mon clear"<<endl;
    mon->clear();*/  //doing monitor clearing in play()
    cout<<"player isopen"<<endl;
    if(player->isopen()) {
        cout<<"player close"<<endl;
        player->drop();
        player->close();
    }
    cout<<"decoder isopen"<<endl;
    if(decoder->isopen()) {
        cout<<"decoder close"<<endl;
        decoder->close();
    }
    cout<<"notify"<<endl;
    mutex_cons.unlock();
    mutex_prod.unlock();
    cond.notify_all();
    cout<<"stop"<<endl;
    //fout.close();
}

//Clear buffer and try to find next track.
bool Application::next()
{
    this->stop();

    mutex_pl.lock();
    if(pl_moving && pl_pos!=pl.end()) {
        pl_pos++;
    }
    if(pl_pos==pl.end() && pl_cycling) {
        pl_pos = pl.begin();
    }
    if(pl_pos!=pl.end()) {
        mutex_pl.unlock();
        this->play();
        return true;
    } else {
        //TODO: should mark stopped.
        mutex_pl.unlock();
        return false;
    }
}

bool Application::prev()
{
    return false; //TODO: not implemented
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

void Application::set_vol(int l, int r)
{
    softvol.set_vol(l, r);
}

int Application::get_vol_l()
{
    return softvol.get_l();
}

int Application::get_vol_r()
{
    return softvol.get_r();
}

Decoder *Application::comment_decoder = NULL;

int Application::read_comments(const char *filename, Trackinfo &buf)
{
    if(comment_decoder==NULL) {
        comment_decoder = new DecoderFFmpeg();
    }
    if(comment_decoder->open(filename)) {
        return -1;
    }
    const char *key, *value;
    while(comment_decoder->read_comments(&key, &value)) { //have rec
        buf.fill(key, value);
    }
    comment_decoder->close();
    return 0;
}
