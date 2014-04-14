#ifndef PC_BOOST_H

#define PC_BOOST_H

#include <fstream>

#include "pc_boost_monitor.h"
#include "chunk.h"
#include "decoder.h"
#include "player.h"
#include "playlist.h"
#include "softvol.h"
#include "trackinfo.h"

class Application {
    public:
        enum State {
            STATE_PLAY, STATE_PAUSE, STATE_STOP,
            STATE_FLUSHED, //the track is finished, but waiting for decoder.
            STATE_MAX
        };
        Application();
        Application(int);
        virtual ~Application();

        //--------BEGIN PLAY CONTROL API---------------
        //open custom file (those not in playlist).
        int open(const char *);
        //close app, doesn't need to be called in most cases.
        void close();
        //start playing current track.
        void play();
        //start playing specified track in playlist.
        //idx starts from 0, identifing the track to play.
        void play(int idx);
        void pause();
        //stop playing, reset playing progress.
        void stop();
        //next track in playlist.
        bool next();
        //previous track in playlist. TODO: not implemented.
        bool prev();
        //start playing from specified position. offset is in seconds.
        void seek(double offset);
        //set left and right volume.
        void set_vol(int, int);
        //get current volume.
        int get_vol_l();
        int get_vol_r();
        //--------END PLAY CONTROL API-----------------

        //--------BEGIN STATUS API---------------------
        //get metadata of current track.
        bool get_ti(Trackinfo &);
        //get file format of current track(flac, ape, ...).
        char *get_codec_type();
        //--------END STATUS API-----------------------

        //--------BEGIN PLAYLIST API-------------------
        //Don't use this function in front-end!
        static int read_comments(const char *, Trackinfo &);
        //add a file to playlist.
        void pl_add(const char *filename);
        //add a list to playlist.
        void pl_add_list(const char *filename);
        //remove index from playlist.
        void pl_remove(unsigned int idx);
        //remove all tracks from playlist.
        void pl_clear();
        //save default playlist.
        void pl_save();
        //load default playlist.
        void pl_load();
        //moving: play next track when this one is finished.
        //cycling: play the first track when the last one is finished.
        void set_play_mode(bool moving, bool cycling);
        //get a read-only reference of playlist.
        const Playlist &get_pl(); //used for front-end iteration
        //--------END PLAYLIST API---------------------
    private:
        Monitor<Chunk> *mon;
        void producer();
        void consumer();
        boost::atomic<unsigned int> consumer_pos;
        boost::atomic<State> state;
        boost::condition_variable cond;
        boost::mutex mutex, mutex_prod, mutex_cons, mutex_pl;
        boost::thread th_prod, th_cons;
        void init(int);
        Decoder *decoder;
        static Decoder *comment_decoder;
        Player *player;
        bool wait_on_state(boost::mutex &);
        Softvol softvol;
        //-----------PROTECTED BY MUTEX_PL--------------
        Playlist pl; //real playlist, the only instance.
        //used for back-end iteration
        Playlist::iterator pl_pos;
        bool pl_moving;
        bool pl_cycling;
        //-------------END MUTEX_PL---------------------
        bool ispaused;
        //std::ofstream fout;
};

#endif
