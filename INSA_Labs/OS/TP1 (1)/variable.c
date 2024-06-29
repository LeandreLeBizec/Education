#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>

// montre que chaque processus a bien une copie des variables

pid_t pidFils;  

int main(){
  int i = 1;
  pidFils = fork();
  if (pidFils!=0){
    /* ------------ code du p�re ----------------- */
    while (i<10){
    printf("je suis le pere, la valeur de i est %d\n",i);
    i=i+1;
    sleep(1);
    }
    printf("je suis le pere, la valeur de i est %d\n",i);
  }
  else{
    /* ------------ code du fils ----------------- */
    while (i>-10){
      printf("             je suis le fils, la valeur de i est %d\n",i);
      i=i-1;
      sleep(1);
    }
    printf("               je suis le fils, la valeur de i est %d\n",i);
  }
  return 0;
}
