#include <stdio.h>
#include <stdlib.h>

#define TAILLE_TAB 5
#define R1 ((char) 'R')
#define TAILLMAX 6



int main() {
    /*
    const char R2 = 'S';
    const char carac[5]={'A','B','C','D','E'};
    const int table[5] = {81,82,3,4,5};
    int a=3,b=2,c=1;

    printf("Q1 : %c %c %d %d \n", R1,R2,table[1],carac[table[4]]);

    if((a=b)||(a=c++)){
        a = a+b++;
    }
    printf("Q3: %d %d %d \n",a,b,c);
    c=a*5 + ((a<<2)&b);
    printf("Q5: %d %d %d \n",a,b,c);


    int table[]={5, 2};
    int *ptrcour, *ptri;
    int i;
    ptrcour = table + TAILLMAX;
    printf("%d %d %d", ptrcour-table, *table, *(ptrcour-1));

    ptrcour=ptri=(int *) calloc(TAILLMAX, sizeof(int));
    for(i=0;i<TAILLMAX;i++){
        *(ptrcour++) = TAILLMAX-i-1;
        printf("%d ",ptri[i]);
    }
    */

    int tab[]={1,2,3,4};
    printf("%d %d %d %d",tab,tab[0],*tab);

    /*
    FILE *fichier = fopen("monfichier.txt", "mode_ouverture");

    if(fichier == NULL)
        exit(1);

    fclose(fichier);

    signed char texte[256];
    int age = 0;
    int taille = 0;
    fscanf(fichier, "%s %d %d", texte, &age, &taille);

    int n = 0;

    scanf("%d", &n);

    int *monTableauDynamique = (int *) malloc(sizeof(int) * n);

    free(monTableauDynamique);



    if(monTableauDynamique == NULL)
        exit(1);


    char mot[]="leandre";
    printf("%s", mot);

    scanf("%s",mot);
    printf("%s", mot);
    */



    return 0;

}
