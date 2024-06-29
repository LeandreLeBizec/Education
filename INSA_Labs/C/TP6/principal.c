#include <stdio.h>
#include "fichier.h"

int affichage();

int main(){
  FILE * pFile=NULL;  /* Descripteur du fichier */

  pFile = ouvrirFichier("../fichier.h","r",ARRET);
  traiterLignesFichier(pFile, NULL);
  fermerFichier(pFile);



  return 0;
}


int affichage(char *tampon){
    printf("%s", tampon);
    return 1;
}