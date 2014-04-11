#include <cstdio>
#ifdef __linux
#include <termios.h>
#endif

#include "pc_boost.h"

using namespace std;

#ifdef __linux

struct termios saved_attributes;

static int terminal_init()
{
    struct termios tattr;

    tcgetattr (0, &saved_attributes);

    memcpy(&tattr,&saved_attributes,sizeof(struct termios));
    tattr.c_lflag &= ~(ICANON|ECHO);
    tattr.c_cc[VMIN] = 1;
    tattr.c_cc[VTIME] = 0;
    tcsetattr (0, TCSAFLUSH, &tattr);
    return 0;
}

static void terminal_exit()
{
    tcsetattr (0, TCSAFLUSH, &saved_attributes);
}

#endif

int main(int argc, char *argv[])
{
    Application app(128);
    //app.open(argc>1?argv[1]:"bleu.flac");
    int x;
#ifdef __linux
    terminal_init();
#endif
    while((x=getchar())!=EOF) {
        if(x=='a') {
            puts("main: a");
            app.play();
        } else if(x=='s') {
            puts("main: s");
            app.pause();
        } else if(x=='d') {
            puts("main: d");
            app.stop();
        } else if(x=='f') {
            puts("main: f");
            app.next();
        } else if(x=='g') {
            Trackinfo ti;
            app.get_ti(ti);
            printf("Path:\t%s\n", ti.path.c_str());
            printf("Title:\t%s\n", ti.title.c_str());
            printf("Artist:\t%s\n", ti.artist.c_str());
            printf("Album:\t%s\n", ti.album.c_str());
        } else if(x=='=') {
            int vol = app.get_vol_l()+10;
            if(vol>100) vol=100;
            app.set_vol(vol, vol);
        } else if(x=='-') {
            int vol = app.get_vol_l()-10;
            if(vol<0) vol=0;
            app.set_vol(vol, vol);
        }
    }
#ifdef __linux
    terminal_exit();
#endif
    return 0;
}
