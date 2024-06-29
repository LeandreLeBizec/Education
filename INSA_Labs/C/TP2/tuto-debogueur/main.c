#include <stdio.h>
#include <stdlib.h>
#include <math.h>

float monCarre (float n)
{
    float ncar;

    ncar = pow(n,2);
    return ncar;
}

int main()
{
    int i,n,v,cpt,som,somcar;
    float moy,ec;

    printf("-----Calcul de la somme et de la moyenne des entiers de 1 a N -----\n\n");
    printf("Entrez la valeur N :  \n");
    scanf("%d",&n);

    som=0;
    somcar=0;
    cpt=0;

    for(i=0;i<n;i++){
        v=i+1;
        som += v;
        somcar += monCarre(v);
        cpt++;

    }
    moy = (float)som/cpt;
    ec = sqrt((float)somcar/cpt - monCarre(moy));


    printf("La somme des valeurs est : %d , N(N+1)/2 = %d\n", som, n*(n+1)/2);
    printf("La moyenne des valeurs est : %f\n", moy);
    printf("L'ecart type des valeurs est : %f\n", ec);

    printf("\n-----fin du programme-----\n");

    return 0;
}

