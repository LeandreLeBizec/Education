#include <stdlib.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <wait.h>

struct sigaction action;
sigset_t mask_nv;
sigset_t mask_anc;


void handler(int sig){
	printf("signal reçu \n");
}

int main(int argc, char * argv[]){

	sigemptyset(&mask_nv);
	sigaddset(&mask_nv, SIGUSR1);
	sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc);

	action.sa_handler=handler;
	sigaction(SIGUSR1,&action,NULL);
	
	pid_t pidFils = fork();
	
	if(pidFils == -1){
		printf("erreur lors de la création du fils");
		exit(0);
	}
	
	
	if(pidFils != 0 ){
	    printf("Debut du pere\n");
		int i=0;
		while(i<10){
			printf("a \n");
			i++;
		}
		kill(pidFils,SIGUSR1); 
      	wait(NULL);//Attente de la fin d'un fils
      	printf("Fin du pere\n");
	}else{
		printf("Debut du fils\n");
		sleep(1);
		sigsuspend(&mask_anc);
      	int i=0;
		while(i<10){
			printf("b \n");
			i++;
		}
      	printf("Fin du fils\n");
      	exit(0);
	}
	
	return 0;
}



