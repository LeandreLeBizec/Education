#include <stdio.h>
#include <math.h>

double puissance(double x,int n){
    int i;
    double res=1;
    for( i = 0; i<n;i++){
        res *= x;
    }
    return res;
}


int myfact(int n) {
    int  fact=1;
    int i;
    for (i=1;i<=n;i++){
        fact *= i;
    }
    return fact;
}

int myfactrec(int n){
    if(n==0 | n==1){
        return 1;
    }
    return n* myfactrec(n-1);

}

double term (double x, int n){
    return puissance(x,n)/ myfact(n);
}


double sinus(double x, int n){
    int i;
    double res=0;
    for (i=0;i<n;i++){
        res += puissance(-1, i) * term (x, 2*i+1);
    }
    return res;
}

double suiv(double t, double x, int n){
    return t* (x*x)/(n*(n-1));
}


double suivrec(double x, int n){
    if(n==0){
        return 1;
    }else if(n == 1){
        return x;
    }
    return (x*x)/(n*(n-1)) * suivrec(x,n-2);
}

double sinus2rec(double x,int n){
    int i;
    double res=0;
    for (i=0;i<n;i++){
        res += puissance(-1, i) * suivrec(x, 2*i+1);
    }
    return res;
}


int main() {
    int n; double x;
    /*printf("Entrez la valeur de n :\n");
    scanf("%d",&n);
    printf("%d ! = %d\n",n, myfact(n));
    printf("%d ! = %d\n",n, myfactrec(n));*/
    printf("Entrez la valeur de x et la puissance n :\n");
    scanf("%lf %d",&x,&n);
    printf("%lf^%d = %lf\n",x,n, puissance(x,n));
    printf("%lf\n",term(x,n));
    printf("%lf\n",suivrec(x,n));
    printf("%lf\n",sinus(x,n));
    printf("%lf\n",sinus2rec(x,n));


    return 0;
}

