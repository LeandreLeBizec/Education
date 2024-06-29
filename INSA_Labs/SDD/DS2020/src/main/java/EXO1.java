public class EXO1 {

/*
Q1
Ce sont des théorèmes

Q2
TAD Booléen

SORTE booléen
FONCTIONS
    vrai :  -> Booleen
    faux :  -> Booleen
    non : Booleen -> Booleen
    et : Booleen x Booleen -> Booleen
    ou : Booleen x Booleen -> Booleen

AXIOMES
    non(vrai())=faux()
    non(non(x)) = x
    et(x,vrai()) = x
    et(x,faux()) = faux()
    et(x,y) = et(y,x)
    ou(x, vrai())=vrai()
    ou(faux(),faux())=faux()
    ou(x,y)=ou(y,x)

PRECONDITIONS
/

Q3
DEMONSTRATION
1)non(et(x,y))=ou(non(x),non(y))
2)non(ou(x,y))=et(non(x),non(y))

public boolean preuve(boolean x, boolean y){
    if (non(et(x,y))==ou(non(x),non(y)) && non(ou(x,y))==et(non(x),non(y))){
        return true;
    }
    return false;
}

*/
}
