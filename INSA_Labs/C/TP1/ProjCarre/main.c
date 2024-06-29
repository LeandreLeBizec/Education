#include <stdio.h>
int monCarre(int a){
    return a*a;
}
int main() {
    int n,p;
    printf("Donnez une valeur entier: \n");
    scanf("%d", &n);
    p=monCarre(n);
    printf("Le carre de %d est %d\n",n,p);
    return 0;
}
