package defaut;

public class main {

    public static void main(String args[]){
        NoeudBinaire r1 = new NoeudBinaire("+");
        NoeudBinaire r21 = new NoeudBinaire("*");
        NoeudBinaire r22 = new NoeudBinaire("/");

        NoeudFeuille f211 = new NoeudFeuille("4");
        NoeudFeuille f212 = new NoeudFeuille("pi");
        NoeudFeuille f221= new NoeudFeuille("5");
        NoeudFeuille f222 = new NoeudFeuille("2");

        r21.setFilsG(f211);
        r21.setFilsD(f212);
        r22.setFilsG(f221);
        r22.setFilsD(f222);

        Arbre a = new ArbreImplement(r1);

    }
}
