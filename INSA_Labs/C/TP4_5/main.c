#include <stdio.h>
#include "tache.h"

int main() {
    /* def du type tache
     *
    Tache t;
    saisieTache(&t);
    afficheTache(&t);*/




    /* Lecture d'un fichier
     *
    FILE *f=fopen("taches.txt","r");
    if(f==NULL){
        fprintf(stderr, "echec à l'ouverture du fichier \n");
        return -1;
    }
    int n=300;
    char s[n];
    while(!feof(f)){
        if(fgets(s, n, f) != NULL){
            printf("%s",s);
        }
    }
    fclose(f);*/


    /*
    Tache tabTache[MAXTACHES];
    char monFichier[] = "taches.txt";
    lireTachesFichier(monFichier, tabTache);
    afficheTabTaches(tabTache, lireTachesFichier(monFichier, tabTache)-1);
    sommeTotalDuree(tabTache,lireTachesFichier(monFichier, tabTache)-1 );
    printf("La durée totale est de : %d", sommeTotalDuree(tabTache,lireTachesFichier(monFichier, tabTache)-1 ) );
    ecrireTachesFichier("tachesB.txt",tabTache,lireTachesFichier(monFichier, tabTache)-1);
    */

    /*
    int nbTaches;
    char monFichier[] = "tachesDyn.txt";
    Tache *tabTacheDyn = lireTachesFichierDyn(monFichier, &nbTaches);
    afficheTabTaches(tabTacheDyn, lireTachesFichier(monFichier, tabTacheDyn)-1);
    free(tabTacheDyn);
    */

    /*
    FILE *f=fopen("taches.txt","r");
    if(f==NULL){
        fprintf(stderr, "echec à l'ouverture du fichier \n");
        return -1;
    }
    Liste l=NULL;
    while(!feof(f)){
        Tache t;
        saisieTacheFichier(f, &t);
        //ajoutdeb(&l, t);
        ajouttrield(&l, t);
    }
    fclose(f);

    int i = nbelement(l);
    printf("%d \n", i);

    afficheListe(l);
    */

    /*
    Liste l=NULL;
    Tache t1;
    Tache t2;
    Tache t3;
    saisieTache(&t1);
    saisieTache(&t2);
    saisieTache(&t3);
    ajouttrield(&l,t1);
    ajouttrield(&l,t2);
    ajouttrield(&l,t3);
    printf("\n");
    printf("il y a %d elements dans la liste \n", nbelement(l));
    afficheListe(l);
    */



    return 0;
}
