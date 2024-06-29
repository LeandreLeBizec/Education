#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>

int main(){
	
	/*
	printf("Je suis le pere, mon id est le %d", getpid());
	printf(", celui de mon pere est le %d \n", getppid());
	
	
	for(int i=1; i<3; i++){
		sleep(1);
	
		if(fork() ==0){
			printf("Je suis le fils%d, mon id est le %d", i, getpid());
			printf(", celui de mon pere est le %d \n", getppid());
			for(int j=1; j<3; j++){
				if(fork() == 0){
					printf("Je suis le fils%d.%d, mon id est le %d", i, j, getpid());
					printf(", celui de mon pere est le %d \n", getppid());
					for(int k=1; k<3; k++){
						if(fork() == 0){
							printf("Je suis le fils%d.%d.%d, mon id est le %d", i, j, k, getpid());
							printf(", celui de mon pere est le %d \n", getppid());
							return 0;
						}
					}
				return 0;
				}
			}
		return 0;
		}
	}
	*/
	int i=0;
	int depth=4;
	int ancestors[4] = { 0 };
	for(i; i<depth; i++){
		pid_t pidFils = fork();
		if (pidFils != 0){
			pid_t pidFils = fork();
			if (pidFils != 0){
				printf("Mon niveau est %d, mon id est le %d", i, getpid());
				printf(", celui de mon pere est le %d \n", getppid());
				sleep(1);
				exit(0);
			}
		}
	}
	
	return 0;
}



