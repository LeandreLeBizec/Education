# -*- coding: utf-8 -*-
# ...
from random import randint

def initialiserAleatoire(t, vmin, vmax):
    tab=[]
    for i in range(t):
        val=randint(vmin, vmax)
        tab.append(val)
    return tab
    
tab = initialiserAleatoire(10, 2, 7)
print(t)
    
def tri_selection(tab, n):
    for i in range(n):
        m = i
        for j in range(i+1, n, 1): #range(depart, arrive(non inclus), valeur d'incrementation)
            if tab[j]<tab[m]:
                m=j
        if m != i:
            tmp = tab[i]
            tab[i]=tab[m]
            tab[m]=tmp        
    return tab
            
tri_selection(tab, len(tab))
print(tab)