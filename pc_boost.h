#ifndef PC_BOOST_H

#define PC_BOOST_H

#include "pc_boost_monitor.h"
#include "chunk.h"
#include "decoder.h"
#include "player.h"

class Application {
    public:
        enum State {
            STATE_PLAY, STATE_PAUSE, STATE_STOP,
            STATE_MAX
        };
        Application();
        Application(int);
        virtual ~Application();
        int open(const char *);
        void close();
        void play();
        void pause();
        void stop();
    private:
        Monitor<Chunk> *mon;
        Chunk eof;
        void producer();
        void consumer();
        boost::atomic<State> state;
        boost::condition_variable cond;
        boost::mutex mutex;
        boost::thread th_prod, th_cons;
        void init(int);
        Decoder *decoder;
        Player *player;
        bool wait_on_state();
        void reset_chunk(Chunk **chunk);
};

#endif
