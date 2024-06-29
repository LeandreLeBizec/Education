package defaut;

public class ArbreImplement implements Arbre{

    private Noeud racine;

    public ArbreImplement(final Noeud r){
        this.racine = r;
    }

    @Override
    public Object racine() {
        return this.racine;
    }

    @Override
    public Arbre arbreG() {
        Arbre a = new ArbreImplement(this.racine.getFilsG());
        return a;
    }

    @Override
    public Arbre arbreD() {
        Arbre a = new ArbreImplement(this.racine.getFilsD());
        return a;
    }

    @Override
    public boolean estVide() {
        if (this.racine == null){
            return true;
        }
        return false;
    }

    @Override
    public void vider() throws EmptyTreeException {
        if (this.racine == null) {
            throw new EmptyTreeException(("L'arbre est déjà vide"));
        }
        this.racine = null;
    }

    @Override
    public String toString(){
        return "";
    }

    @Override
    public int hauteur() {
        return 0;
    }

}
