#ifndef PC_BOOST_H

#define PC_BOOST_H

#include <fstream>

#include "pc_boost_monitor.h"
#include "chunk.h"
#include "decoder.h"

class Application {
    public:
        enum State {
            STATE_PLAY, STATE_PAUSE, STATE_STOP, STATE_QUIT,
            STATE_MAX
        };
        Application();
        Application(int);
        virtual ~Application();
        void play();
        void pause();
        void stop();
        void quit();
    private:
        Monitor<Chunk> *mon;
        Chunk eof;
        void producer();
        void consumer();
        void watcher();
        boost::atomic<State> state;
        boost::condition_variable cond;
        boost::mutex mutex;
        boost::thread th_prod, th_cons, th_watch;
        void init(int);
        Decoder *decoder;
        std::ofstream outfile;
};

#endif
