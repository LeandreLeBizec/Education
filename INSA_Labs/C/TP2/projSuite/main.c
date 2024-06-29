#include <stdio.h>
#include <math.h>
#define e M_E

double suite(int n, int verbose) {
    int i;
    double i1 = 1;
    double in;
    if(verbose == 1) {
        printf("1 : 1\n");
        for (i=2;i<=n;i++) {
            in = M_E - i * i1;
            i1 = in;
            printf("%d : %lf\n", i, in);
        }
    }
    return in;
}

int main() {
    printf("%lf",suite(20,1));
    return 0;
}
