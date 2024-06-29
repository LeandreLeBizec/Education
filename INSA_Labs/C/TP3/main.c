#include <stdio.h>
#define MAX_NOM 255
#define MAX_ID 8

int main() {
    char nom[MAX_NOM];
    char prenom[MAX_NOM];
    printf("Saisir votre nom et prenom:\n");
    scanf("%s %s",&nom,&prenom);
    printf("Tu t'appelles %s %s\n",nom,prenom);
    char id[MAX_ID]; int i;
    id[0]=prenom[0];
    for(i=1;i<MAX_ID;i++){
        id[i]=nom[i-1];
        printf("%s \n",id);
    }
    printf("Ton id est %s \n",id);
    return 0;
}
