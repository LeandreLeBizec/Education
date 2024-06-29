#include <stdio.h>
#include <math.h>
int norme(float x, float y){
    return sqrt(x*x+y*y);
}
int main() {
    float x,y;
    float res;
    printf("Entrez la valeur de x:\n");
    scanf("%f",&x);
    printf("Entrez la valeur de y:\n");
    scanf("%f",&y);
    res = norme(x, y);
    printf("La norme du vecteur est %f",res);
    return 0;
}
