#include "pc_boost.h"

#define DEFAULT_PLAYLIST "music.lst"

void Application::pl_add(const char *filename)
{
    Trackinfo buf;
    if(read_comments(filename, buf)>=0) {
        mutex_pl.lock();
        pl.add(buf);
        mutex_pl.unlock();
    }
}

void Application::pl_add_list(const char *filename)
{
    mutex_pl.lock();
    pl.readfile(filename);
    mutex_pl.unlock();
}

void Application::pl_remove(unsigned int idx)
{
    mutex_pl.lock();
    unsigned int cur_idx = pl_pos - pl.begin();
    if(idx==cur_idx) {
        pl_pos++;
    } else if(cur_idx>idx) {
        pl_pos--;
    }
    pl.remove(idx);
    mutex_pl.unlock();
}

void Application::pl_clear()
{
    mutex_pl.lock();
    pl.clear();
    pl_pos=pl.begin();
    mutex_pl.unlock();
}

void Application::pl_save()
{
    mutex_pl.lock();
    pl.save(DEFAULT_PLAYLIST);
    mutex_pl.unlock();
}

void Application::pl_load()
{
    mutex_pl.lock();
    pl.clear();
    pl.readfile(DEFAULT_PLAYLIST);
    pl_pos=pl.begin();
    mutex_pl.unlock();
}

const Playlist &Application::get_pl()
{
    //Conflicts when accessing this readonly-pl should be dealt with
    //by the front-end.
    //It's inappropriate to use multi-thread in the front-end.
    return pl;
}

void Application::set_play_mode(bool moving, bool cycling)
{
    mutex_pl.lock();
    pl_moving = moving;
    pl_cycling = cycling;
    mutex_pl.unlock();
}
