#include <stdlib.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <wait.h>


int prog = 0;
struct sigaction action;

void handler(int sig){
	printf("Progression : %d \n", prog);
}

int main(int argc, char * argv[]){
	action.sa_handler = handler;
    sigaction(SIGTSTP, &action, NULL); //ctrl+z
    while (1)
    {
        for (int i = 0; i < 10000; i++)
        {
        }
        prog++;
    }
    exit(0);
}


