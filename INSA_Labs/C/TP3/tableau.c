//
// Created by vule on 01/10/2021.
//
#include <stdio.h>
#include <stdlib.h>
#include "tableau.h"
#include <time.h>

void init_alea_tab(int tab[], int taille){
    int i;
    srand(time(NULL));
    for(i=0;i<taille;i++){
        tab[i]= rand()%VAL_MAX;
    }
}

void affiche_tab(int tab[], int taille){
    int i;
    for(i=0;i<taille;i++){
        printf("%d ",tab[i]);
    }
    printf("\n");
}

void histo(int tab1[], int tab2[], int t1, int t2){
    int i;
    for(i=0;i<t2;i++){
        tab2[i]=0;
    }
    for (i=0;i<t1;i++){
        tab2[tab1[i]]++;
    }

}

void affiche_histo(int tab1[], int tab2[], int t1, int t2, int afficher){
    int i,j,k;
    printf("Affichage du tableau \n");
    affiche_tab(tab1,t1);
    printf("Affichage de l'histogramme \n");
    for(i=0; i<t2;i++){
        if (afficher == 0){
            int compt=0;
            for(j=0;j<tab2[i];j++){
                compt++;
            }
            if (compt!=0) {
                printf("%d :", i);
                for (k=0;k<compt;k++) printf("-");
                printf("\n");
            }
        }
        else {
            printf("%d :", i);
            for(j=0;j<tab2[i];j++){
                printf("-");
            }
            printf("\n");
        }
    }
}

