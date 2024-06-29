#include "tache.h"

void saisieTache(Tache *t){
    int i;
    printf("Saisir l'identifiant de la Tâche :");
    scanf("%d", &(t->no));
    printf("Saisir la durée de la Tâche :");
    scanf("%d", &(t->duree));
    printf("Saisir le nombre de prédecesseurs de la Tâche :");
    scanf("%d", &(t->nbPred));
    for(i=0; i<(t->nbPred); i++){
        printf("Saisir le %d eme prédecesseur de la Tâche :",i+1);
        scanf("%d", &(t->pred[i]));
    }
    printf("Saisir le titre de la Tâche :");
    scanf("%s", (t->titre));
}

void saisieTacheFichier(FILE *f,Tache *t){
    int i;
    fscanf(f,"%d", &(t->no));
    fscanf(f,"%d", &(t->duree));
    fscanf(f,"%d", &(t->nbPred));
    for(i=0;i<t->nbPred;i++){
        fscanf(f,"%d", &(t->pred[i]));
    }
    fscanf(f,"%[^\n]", (t->titre));
}

void afficheTache(Tache *t){
    int i;
    printf("L'identifiant de la Tâche est : %d \n", t->no);
    printf("La durée de la Tâche est : %d \n", t->duree);
    printf("Le nombre de prédecesseurs de la Tâche est : %d \n", t->nbPred);
    for(i=0; i<(t->nbPred); i++){
        printf("Le %d eme prédecesseur de la Tâche : %d \n",i+1,t->pred[i]);
    }
    printf("Le titre de la Tâche est : %s\n", t->titre);
    printf("\n");
}


int lireTachesFichier(char *nomFichier, Tache *tab_t){
    FILE *f=fopen(nomFichier,"r");
    if(f==NULL){
        fprintf(stderr, "echec à l'ouverture du fichier \n");
        return -1;
    }
    int nbTachesLues=0;
    while(!feof(f)){
        int i;
        fscanf(f,"%d", &(tab_t[nbTachesLues].no));
        fscanf(f,"%d", &(tab_t[nbTachesLues].duree));
        fscanf(f,"%d", &(tab_t[nbTachesLues].nbPred));
        for(i=0;i<tab_t[nbTachesLues].nbPred;i++){
            fscanf(f,"%d", &(tab_t[nbTachesLues].pred[i]));
        }
        fscanf(f,"%[^\n]", (tab_t[nbTachesLues].titre));
        nbTachesLues++;
    }
    fclose(f);
    return nbTachesLues;
}


void afficheTabTaches(Tache *tab_t, int nbTaches){
    int i;
    for(i=0; i<nbTaches;i++){
        afficheTache(&tab_t[i]);
        printf("\n");
    }
}

int sommeTotalDuree(Tache *tab_t, int nbTaches){
    int i=0;
    int res=0;
    for(i; i<nbTaches; i++){
        res += tab_t[i].duree;
    }
    return res;
}

int ecrireTachesFichier(char *nomFichier, Tache *tab_t, int nbTaches){
    FILE *f=fopen(nomFichier, "w");
    if(f==NULL){
        fprintf(stderr, "echec à l'ouverture du fichier \n");
        return 0;
    }

    int i=0;
    int j=0;
    for(i;i<nbTaches;i++){
        fprintf(f,"%d ", (tab_t[i].no));
        fprintf(f,"%d ", (tab_t[i].duree));
        fprintf(f,"%d ", (tab_t[i].nbPred));
        for(j=0;j<tab_t[i].nbPred;j++){
            fprintf(f,"%d ", (tab_t[i].pred[j]));
        }
        fprintf(f,"%s \n", (tab_t[i].titre));
    }

    fclose(f);
    return 1;
}

Tache *lireTachesFichierDyn(char *nomFichier, int *nbTaches){

    FILE *f=fopen(nomFichier,"r");
    if(f==NULL){
        fprintf(stderr, "echec à l'ouverture du fichier \n");
        exit (0);
    }

    fscanf(f, "%d", nbTaches);
    Tache *tabDyn = (Tache *) malloc(sizeof(Tache) * *nbTaches);
    if(tabDyn == NULL){
        fprintf(stderr, "Erreur lors de l'allocation de mémoire");
    }


    int i=0;
    int j=0;
    for(j=0;j<*nbTaches;j++) {
        fscanf(f, "%d", &(tabDyn[j].no)); // ou (tab_t+i)->no)
        fscanf(f, "%d", &(tabDyn[j].duree));
        fscanf(f, "%d", &(tabDyn[j].nbPred));
        for (i = 0; i < tabDyn[j].nbPred; i++) {
            fscanf(f, "%d", &(tabDyn[j].pred[i]));
        }
        fscanf(f, "%[^\n]s", (tabDyn[j].titre));
    }

    fclose(f);
    return tabDyn;
}

void ajoutdeb(Liste *l, Tache t){
    Element *e = (Element *) malloc(sizeof(Element));
    if(*l==NULL){
        e->t = t;
        e->suivant = NULL;
        *l=e;
    }else{
        e->t = t; //(*e).t = t;
        e->suivant = *l; //(*e).suivant = l;
        *l=e;
    }
}

int nbelement(Liste l){
    int taille=0;
    while(l!=NULL){
        l=l->suivant;
        taille++;
    }
    return taille;
}

void afficheListe(Liste l){
    if(l==NULL){
        printf("la liste est vide");
    }else {
        int i=0;
        int nb = nbelement(l);
        for(i=0; i<nb; i++){
            afficheTache(&(l->t));
            l=l->suivant;
        }
    }

}

void ajouttrield(Liste *l, Tache t){
    Element *e = (Element *) malloc(sizeof(Element));
    e->t = t;
    e->suivant=NULL;
    Element *courant = *l;

    if(*l==NULL){
        ajoutdeb(l,t);
    }else{
        if(t.no < (courant->t).no ){
            ajoutdeb(l,t);
        }else if(t.no == (courant->t).no ){
            printf("il y à déjà une tâche ayant pour identfaint %d", t.no);
        }else{
            while(courant->suivant != NULL){
                if(t.no < courant->suivant->t.no ){
                    e->suivant = courant->suivant;
                    courant->suivant = e;
                    return;
                }
                courant = courant->suivant;
            }
            if(courant->suivant == NULL){
                e->suivant=NULL;
                courant->suivant=e;
            }
        }
    }
}

void ajouttrie(Liste *l, Tache t, int(*ptrfonc)(Tache, Tache)){
    Element * e = (Element *) malloc(sizeof (Element));
    Element *courant = *l;
    e->t =t;
    e->suivant = NULL;

    if(*l==NULL){
        ajoutdeb(l,t);
    }else{
        if((*ptrfonc)(courant->t,t)<0){
            ajoutdeb(l,t);
        }else if((*ptrfonc)(courant->t,t)<0){
            printf("il y à déjà une tâche ayant pour identfaint %d", t.no);
        }else{
            while(courant->suivant != NULL){
                if(t.no < courant->suivant->t.no ){
                    e->suivant = courant->suivant;
                    courant->suivant = e;
                    return;
                }
                courant = courant->suivant;
            }
            if(courant->suivant == NULL){
                e->suivant=NULL;
                courant->suivant=e;
            }
        }
    }
}

int triInt(Tache t1,Tache t2){
    return (t2.no-t1.no);
}
int triNom(Tache t1,Tache t2){
    return strcmp(t2.titre,t1.titre);
}

