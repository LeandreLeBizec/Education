package defaut;

public interface Arbre {

    public Object racine();
    public Arbre arbreG();
    public Arbre arbreD();
    public boolean estVide();
    public void vider() throws EmptyTreeException;
    //public void modifRacine(); optional
    //public void modifArbreG(); optional
    //public void modifArbreD(); optional
    public int hauteur();
    @Override
    public String toString();
    //public void dessiner();
}
