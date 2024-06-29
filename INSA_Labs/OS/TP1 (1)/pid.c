#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>

// pour compiler ce programme : cc pid.c -o pid
// pour executer ce programme ./pid
  

int main(){

  pid_t pidFils= fork();
  if (pidFils!=0){
    /* ------------ code du p�re ----------------- */
    printf("je suis le pere, mon numero est %d",getpid()); 
    printf(", celui de mon fils est %d",pidFils);
    printf(", celui de mon pere est %d", getppid());
    printf(", pidFils vaut %d \n", pidFils);
    sleep(15);
  }
  else{
    /* ------------ code du fils ----------------- */
    sleep(1);
    printf("je suis le fils, mon numero est %d",getpid());
    printf(", celui de mon pere est %d", getppid());
    printf(", pidFils vaut %d \n", pidFils);
    sleep(15);
  }
  
  return 0;
}
  
