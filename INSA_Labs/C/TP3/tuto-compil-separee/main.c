#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mesFoncyionsMaths.h"


/*!\func int main()
 * Calcul de la somme, la moyenne et de l'écart type de la suite des n premiers entiers
 * @return 0 si tout s'est bien passé
 */
int main()
{
    int i,n,som,somcar;
    float moy,ec;

    printf("-----Calcul de la somme, la moyenne et de l'écart type de la suite des entiers de 1 a N -----\n\n");
    printf("Entrez la valeur N :  \n");
    scanf("%d",&n);

    som=0;
    somcar=0;

    /* boucle sur les N premeirs entiers */
    for(i=1;i<=n;i++){
        som += i; /* somme des N premiers entiers*/
        somcar += monCarre(i); /* somme des carrés des N premiers entiers*/
    }
    /* Calcul de la moyenne et de l'écart type*/
    moy = (float)som/n;
    ec = sqrt((float)somcar/n - monCarre(moy));

    printf("La somme des valeurs est : %d , N(N+1)/2 = %d \n", som, n*(n+1)/2);
    printf("La moyenne des valeurs est : %f\n", moy);
    printf("L'ecart type des valeurs est : %f\n", ec);

    printf("\n-----fin du programme-----\n");

    return 0;
}

