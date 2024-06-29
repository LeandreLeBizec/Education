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

int send = 0;
int received = 0;

void handler(int sig){
	//if(sig==SIGTSTP){
		printf("signaux envoyé : %d \n", send);
		printf("signaux reçu : %d \n", received);
	//}
}

int main(int argc, char * argv[]){

	sigemptyset(&mask_nv);
	sigaddset(&mask_nv, SIGUSR1);
	sigaction(SIGTSTP, &action, NULL); //ctrl+z
	sigprocmask(SIG_BLOCK, &mask_nv, &mask_anc);

	action.sa_handler=handler;
	sigaction(SIGUSR1,&action,NULL);
	sigaction(SIGTSTP, &action, NULL);
	
	pid_t pidFils = fork();
	
	if(pidFils == -1){
		printf("erreur lors de la création du fils");
		exit(0);
	}
	
	if(pidFils != 0 ){
	    printf("Debut du pere\n");
		kill(pidFils,SIGUSR1); 
		kill(pidFils,SIGUSR1); 
      	wait(NULL);//Attente de la fin d'un fils
      	printf("Fin du pere\n");
	}else{
      	printf("Debut du fils\n");
      	sigsuspend(&mask_anc);	
      	printf("Fin du fils\n");
      	exit(0);
	}
	
	return 0;
}
