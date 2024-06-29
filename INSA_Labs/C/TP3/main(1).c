
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "tableau.h"

int main()
{
    int tab1[DIM_TAB];
    int tab2[VAL_MAX];
    init_alea_tab(tab1,DIM_TAB);
    histo(tab1,tab2,DIM_TAB,VAL_MAX);
    affiche_histo(tab1,tab2,DIM_TAB,VAL_MAX, 1);

}
