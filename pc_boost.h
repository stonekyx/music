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
            STATE_FLUSHED,
            STATE_MAX
        };
        Application();
        Application(int);
        virtual ~Application();

        //--------BEGIN PLAY CONTROL API---------------
        int open(const char *);
        void close();
        void play();
        void pause();
        void stop();
        bool next();
        bool prev();
        void seek(double offset);
        void set_vol(int, int);
        int get_vol_l();
        int get_vol_r();
        //--------END PLAY CONTROL API-----------------

        //--------BEGIN STATUS API---------------------
        bool get_ti(Trackinfo &);
        char *get_codec_type();
        //--------END STATUS API-----------------------

        //--------BEGIN PLAYLIST API-------------------
        //Don't use this in front-end!
        static int read_comments(const char *, Trackinfo &);
        void pl_add(const char *filename);
        void pl_add_list(const char *filename);
        void pl_remove(unsigned int idx);
        void pl_clear();
        void pl_save();
        void pl_load();
        void set_play_mode(bool moving, bool cycling);
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
