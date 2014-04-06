#ifndef PC_BOOST_MONITOR_H
#define PC_BOOST_MONITOR_H

#include <boost/thread.hpp>
#include <boost/atomic.hpp>

template<typename T>
class Monitor {
    private:
        T *buf;
        boost::atomic<size_t> head_, tail_, bufsize;
    public:
        int statis;
        Monitor<T>(int);
        virtual ~Monitor<T>();
        bool read(T&);
        bool write(const T&);
        void clear();
        int get_count();
    protected:
};

template<typename T>
Monitor<T>::Monitor(int bufsize):head_(0), tail_(0)
{
    this->bufsize = bufsize;
    buf = new T[bufsize];
    statis=0;
}

template<typename T>
Monitor<T>::~Monitor()
{
    delete[] buf;
}

template<typename T>
bool Monitor<T>::read(T &val)
{
    size_t tail = tail_.load(boost::memory_order_relaxed);
    if(tail==head_.load(boost::memory_order_acquire)) {
        return false;
    }
    val = buf[tail];
    tail_.store((tail+1)%bufsize, boost::memory_order_release);
    statis++;

    /*pthread_mutex_lock(&mutex); //avoid chaotic output
    std::cout<<"R "<<ridx<<"\t"<<buffer[ridx]<<std::endl;
    pthread_mutex_unlock(&mutex);*/

    return true;
}

template<typename T>
bool Monitor<T>::write(const T &t)
{
    size_t head = head_.load(boost::memory_order_relaxed);
    size_t next_head = (head+1)%bufsize;
    if(next_head == tail_.load(boost::memory_order_acquire)) {
        return false;
    }
    buf[head] = t;
    head_.store(next_head, boost::memory_order_release);

    /*pthread_mutex_lock(&mutex); //avoid chaotic output
    std::cout<<"W "<<widx<<"\t"<<t<<std::endl;
    pthread_mutex_unlock(&mutex);*/

    return true;
}

template<typename T>
void Monitor<T>::clear()
{
    head_.store(0, boost::memory_order_seq_cst);
    tail_.store(0, boost::memory_order_seq_cst);
}

#endif
