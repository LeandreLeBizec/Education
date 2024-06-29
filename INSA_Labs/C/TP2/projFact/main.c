/*!
* \file main.c
* \brief Test du calcul de la factorielle
* \author
* \date
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

/*! \func int myfact(int n)
 *
 * @param n l'entier dont on veut calculer la factorielle
 * @return la factorielle de n
 */
int myfact(int n) {
    int  fact=1;
    int i=1;
    for (i;i<=n;i++){
        fact=fact*i;
    }

    return fact;
}

int display_fact(){
    int i=1;
    for (i;i<=20;i++){
        printf("Factorielle de %d : %d \n",i,myfact(i));
    }
    return 0;
}

int rang(){
    int i=0;
    while ( myfact(i) < INT_MAX/(i+1) ){
        i++;
    }
    printf("La plus grande valeure est de rang : %d",i);
    return 0;
}

int main()
{
  int n;
  /*printf("Entrez la valeur n :\n");
  scanf("%d",&n);
  printf("Factorielle de %d : %d ",n,myfact(n));*/
  display_fact();
  rang();
  return EXIT_SUCCESS;
}
