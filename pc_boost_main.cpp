#include <iostream>

#include "pc_boost.h"

using namespace std;

int main()
{
    Application app(128);
    while(1) {
        int x;
        scanf("%d", &x);
        if(x==10) {
            app.play();
        } else if(x==20) {
            app.pause();
        } else {
            app.quit();
            break;
        }
    }
    return 0;
}
