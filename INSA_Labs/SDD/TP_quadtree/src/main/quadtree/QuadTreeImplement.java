package quadtree;

import javax.swing.*;

public class QuadTreeImplement implements QuadTree{
    private Node racine;
    private Node courant;

    public QuadTreeImplement(Node v){
        this.racine = v;
    }

    @Override
    public boolean emptyTree() {
        return racine == null;
    }

    @Override
    public boolean outOfTree() {
        return this.courant == null;
    }

    @Override
    public void goToRoot() {
        this.courant=this.racine;
    }

    @Override
    public void goToParent() {
        this.courant = this.courant.getPere();
    }

    @Override
    public void goToChild(int i) {
        this.courant = this.courant.getFils()[i];
    }

    @Override
    public boolean onRoot() {
        return this.courant==this.racine;
    }

    @Override
    public boolean surFeuille() {
        return (this.courant.getFils() == null && this.courant.getValeur() != null);
    }

    @Override
    public boolean hasChild(int i) {
        return this.courant.getFils()[i] != null;
    }

    @Override
    public Color getValue() {
        return this.courant.getValeur();
    }

    @Override
    public void setValue(Color c) {
        this.courant.setColor(c);
    }

    @Override
    public void addChildren(Color[] c) {
        if (this.surFeuille()){
            Node f0 = new Node(c[0], this.courant);
            Node f1 = new Node(c[1], this.courant);
            Node f2 = new Node(c[2], this.courant);
            Node f3 = new Node(c[3], this.courant);
            this.courant.setFils(f0, f1, f2, f3);
        }
    }

    @Override
    public void createRoot(Color c) {
        this.racine = new Node(c);
    }

    @Override
    public void delete() {
        if(!this.outOfTree() && !this.onRoot()){
            this.courant.setFils(null,null,null,null); //faire une fonction qui supprime recursivement tous les fils
            this.goToParent();
        }
    }

    @Override
    public String toString() {
        return null;
    }

    public Image recreate(){
        return null;
    }

    public void recreateRec(int i, int j, int width, Image Im){

    }
}
