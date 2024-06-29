#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>

pid_t pidFils;

int main(){

	for(int i=0;i<10;i++){
		pidFils = fork();
		
		if (pidFils==0){
    	/* ------------ code du fils ----------------- */
    		printf("je suis le fils et mon numéro est %d \n", getpid());
    		return 0;
    	}	
	}

 	

  return 0;

}
