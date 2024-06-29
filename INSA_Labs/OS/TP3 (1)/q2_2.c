#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/sem.h>
#include <unistd.h>
#include <stdlib.h>

int initSemaphore(int init_value){
	int mysem = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
  if(mysem < 0) perror("Error: semget");
  int retval;
  union semun
  {
    int val; 
    struct semid_ds *buf; 
    ushort *array; 
  } arg;
  arg.val = init_value;
  retval = semctl(mysem, 0, SETVAL, arg);
  if(retval < 0) perror("Error: semctl");
  return mysem;
}


void P(int semid){
	int retval;
  struct sembuf op;
  op.sem_num = 0;
  op.sem_op = -1; 
  op.sem_flg = 0;
  retval = semop(semid, &op, 1);
  if(retval != 0) perror("Error: semop");
}

void V(int semid){
  int retval;
  struct sembuf op;
  op.sem_num = 0;
  op.sem_op = 1; 
  op.sem_flg = 0;
  retval = semop(semid, &op, 1);
  if(retval != 0) perror("Error: semop");
}

void deleteSemaphore(int semid){
  int retval;
  retval = semctl(semid, 0, IPC_RMID, 0);
  if(retval != 0) perror("error: semctl");
}

/*
afficher ABC
int main(){
  int semaA = initSemaphore(1);
  int semaB = initSemaphore(0);
  int semaC = initSemaphore(0);

  if(!fork()){
	if(!fork()){ //p1
    while(1){
	  P(semaA); //semaA,0
	  printf("A \n");
	  V(semaB); //semaB,1
	  }
	}
	else{ //p2
	  while(1){
        P(semaB); //semaB,0
	    printf("B \n");
	    V(semaC); //semaC,1
	    }
	} 
  } else{ //p3
    while(1){
      P(semaC); //semaC,0
      printf("C \n");
      V(semaA); //semaC,1
    }
  }

  deleteSemaphore(semaA);
  deleteSemaphore(semaB);
  deleteSemaphore(semaC);

  return 0;
}
*/

/* Afficher A B|C A B|C A B|C 
int main(){
  int semaA = initSemaphore(1);
  int semaBC = initSemaphore(0);
  

  if(!fork()){
	if(!fork()){ //p1
    while(1){
	  P(semaA); //semaA,0
	  printf("A \n");
	  V(semaBC); //semaBC,1
	  }
	}
	else{ //p2
	  while(1){
        P(semaBC); //semaBC,0
	    printf("B \n");
	    V(semaA); //semaA,1
	    }
	} 
  } else{ //p3
    while(1){
      P(semaBC); //semaBC,0
      printf("C \n");
      V(semaA); //semaA,1
    }
  }

  deleteSemaphore(semaA);
  deleteSemaphore(semaBC);

  return 0;
}
*/

//Afficher A B|C B|C A B|C B|C A ...
int main(){
  int semaA = initSemaphore(0);
  int semaBC = initSemaphore(2);
  

  if(!fork()){
	if(!fork()){ //p1
    while(1){
	  P(semaA); //semaA,0
	  printf("A \n");
	  V(semaBC); //semaBC,1
	  }
	}
	else{ //p2
	  while(1){
        P(semaA); //semaA,0
	    printf("B \n");
	    V(semaBC); //semaBC,2
	    }
	} 
  } else{ //p3
    while(1){
      P(semaBC); //semaBC,1
      P(semaBC); //semaBC,0
      printf("C \n");
      V(semaA); //semaA,1
      V(semaA); //semaA,2
    }
  }

  deleteSemaphore(semaA);
  deleteSemaphore(semaBC);

  return 0;
}

