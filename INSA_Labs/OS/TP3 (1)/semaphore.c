#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/sem.h>
#include <unistd.h>

int initSemaphore(int init_value){
  int mysem = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
  // semget renvoie l'id de l'ensemble (int > 0) sinon -1 et errno contient le code d'erreur
  if(mysem < 0) perror("Error: semget");
  // perror affiche sur stderr le messge associé à la variable errno précédé du message voulu

  int retval;

  union semun
  {
    int val; 
    struct semid_ds *buf; 
    ushort *array; 
  } arg;
  arg.val = init_value;
  // on construit un semun qu'on nomme arg pour la fonction semctl

  retval = semctl(mysem, 0, SETVAL, arg);
  //semctl(int semid, int semno, int cmd, optionnal union semun)
  //effectue l'opération de contrôle cmd sur le jeu de sémaphore semid
  //setval -> placer la valeur arg.val dans le champ semval
  if(retval < 0) perror("Error: semctl");

  return mysem;
}


void P(int semid){
  int retval;
  struct sembuf op;
  op.sem_num = 0;
  op.sem_op = -1; //operation sur le semaphore : -1
  op.sem_flg = 0;
  //on construit la structure sembuf nommé op pour la fonciton semop
  retval = semop(semid, &op, 1);
  //semop(int semid, struct sembuf *sops, unsigned nsops)
  if(retval != 0) perror("Error: semop");
}

void V(int semid){
  int retval;
  struct sembuf op;
  op.sem_num = 0;
  op.sem_op = 1; //operation sur le semaphore : +1
  op.sem_flg = 0;
  retval = semop(semid, &op, 1);
  if(retval != 0) perror("Error: semop");
}

void deleteSemaphore(int semid){
  int retval;
  retval = semctl(semid, 0, IPC_RMID, 0);
  //IPC_RMID -> supprime le jeu de sémaphore en réveillant tous les processis bloqués dans l'appel semop
  if(retval != 0) perror("error: semctl");
}


int main(){
  int semaPere = initSemaphore(1);
  int semaFils = initSemaphore(0);

  if(!fork()){
    while(1){
      P(semaPere); //semaPere,0
      printf("Debut sec critique père\n");
      sleep(2);
      printf("  Fin sec critique père\n");
      V(semaFils); //semaFils,1
      sleep(1);
    }
  } else{
    while(1){
      P(semaFils); //semaFils,0
      printf("Debut sec critique fils\n");
      sleep(1);
      printf("  Fin sec critique fils\n");
      V(semaPere); //semaFils,1
      sleep(2);
    }
  }

  deleteSemaphore(semaPere);
  deleteSemaphore(semaFils);

  return 0;
}
