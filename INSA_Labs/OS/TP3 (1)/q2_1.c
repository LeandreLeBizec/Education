#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/sem.h>
#include <unistd.h>

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


int main(){
  int semaA = initSemaphore(1);
  int semaB = initSemaphore(0);

  if(!fork()){
    while(1){
      P(semaA); //semaA,0
      printf("A \n");
      fflush(stdout);
      V(semaB); //semaB,1
    }
  } else{
    while(1){
      P(semaB);//semaB,0
      printf("B \n");
      fflush(stdout);
      V(semaA);//semaA,1
    }
  }

  deleteSemaphore(semaA);
  deleteSemaphore(semaB);


  return 0;
}
