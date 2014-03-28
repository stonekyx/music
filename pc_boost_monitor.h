#ifndef PC_BOOST_MONITOR_H
#define PC_BOOST_MONITOR_H

#include <boost/thread.hpp>
#include <boost/atomic.hpp>

template<typename T>
class Monitor {
    private:
        T *buf;
        boost::atomic<int> ridx, widx, count, bufsize;
    public:
        int statis;
        Monitor<T>(int);
        virtual ~Monitor<T>();
        T &read();
        void write(const T&);
        void clear();
    protected:
};

template<typename T>
Monitor<T>::Monitor(int bufsize)
{
    this->bufsize = bufsize;
    buf = new T[bufsize];
    ridx=widx=count=statis=0;
}

template<typename T>
Monitor<T>::~Monitor()
{
    delete[] buf;
}

template<typename T>
T &Monitor<T>::read()
{
    while(count==0) {
        boost::this_thread::yield();
    }
    ridx=(ridx+1)%bufsize;
    count--;
    statis++;

    /*pthread_mutex_lock(&mutex); //avoid chaotic output
    std::cout<<"R "<<ridx<<"\t"<<buffer[ridx]<<std::endl;
    pthread_mutex_unlock(&mutex);*/

    return buf[ridx];
}

template<typename T>
void Monitor<T>::write(const T &t)
{
    while(count==bufsize) {
        boost::this_thread::yield();
    }
    buf[widx=(widx+1)%bufsize] = t;
    count++;

    /*pthread_mutex_lock(&mutex); //avoid chaotic output
    std::cout<<"W "<<widx<<"\t"<<t<<std::endl;
    pthread_mutex_unlock(&mutex);*/

}

template<typename T>
void Monitor<T>::clear()
{
    count=0;
    ridx=widx=0;
}

#endif
