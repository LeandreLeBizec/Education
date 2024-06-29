#include <stdio.h>
#include <math.h>
double suite( double x, int n){
    int i =1;
    double res=x/2;
    for(i; i<=n; i++){
        res = (res + x/res) / 2;
    }
    return res;
}

double racine(double x, double precision){
    double res=x/2;
    while (fabs(res - (res + x/res) / 2) > precision){
        res = (res + x/res) / 2;
    }
    return res;
}

int main() {
    printf( "%f\n", racine(25, 0.00001));
    printf( "%f\n", suite(5, 2));
    printf( "%f\n", suite(5, 3));
    printf( "%f\n", suite(5, 4));
    printf( "%f\n", suite(5, 5));
    printf( "%f\n", suite(5, 6));
    printf( "%f\n", suite(5, 100));
    return 0;
}
