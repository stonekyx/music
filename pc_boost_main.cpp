#include <iostream>

#include <termios.h>

#include "pc_boost.h"

using namespace std;

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

int main(int argc, char *argv[])
{
    Application app(128);
    app.open(argc>1?argv[1]:"bleu.flac");
    int x;
    terminal_init();
    while((x=getchar())!=EOF) {
        if(x=='a') {
            app.play();
        } else if(x=='s') {
            app.pause();
        } else if(x=='d') {
            app.stop();
        } else if(x=='f') {
            app.quit();
            break;
        }
    }
    terminal_exit();
    return 0;
}
