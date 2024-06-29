public class EXO2 {

/*
Q4----------------------------------------------------------------------------------------------------------------------
               7
            3     10
         1    6      14
             4  7

Q5----------------------------------------------------------------------------------------------------------------------
public void placer(int i){
    this.positRacine();
    Boolean Done = false;
    while(Done==false){
        if(i<this.valec()){
            if(this.aFilsG()){
                this.positFilsG();
            }else{
                this.modifFilsG(i);
                Done = true;
            }
        }else{
            if(this.aFilsD()){
                this.positFilsD();
            }else{
                this.modifFilsD(i);
                Done = true;
            }
        }
    }
}


Q6----------------------------------------------------------------------------------------------------------------------
a)
Car filsG <= ec et filsD > ec...
b)
le fils le plus à droite du sous arbre gauche


Q7----------------------------------------------------------------------------------------------------------------------


public int oterPlusGrandInf(){
    int k = 0;
    while(this.aFilsD()){
        this.positFilsD();
        k = k+1;
    }
    int a = (int)this.valec();
    this.oterEc();
    for(int i=0;i<k;i++){
        if(this.aPere()){
            this.posiPere();
        }
    }
    return(a);
}

ou faire un backUp de la position puis repositionner l'ec au backUp mais ici pb quant à la nature de l'objet Ec...
arbre binaire ou object ?

Q8----------------------------------------------------------------------------------------------------------------------

public void supprimeEc(){
    if((this.aFilsF() && !this.aFilsD()) || ((!this.aFilsF() && this.aFilsD())){
        this.oterEc();
    }else{
        this.oterPlusGrandInf();
    }
}
*/

}
