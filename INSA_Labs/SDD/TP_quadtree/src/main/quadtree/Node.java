package quadtree;

public class Node {

    private Color valeur;
    private Node pere;
    private Node[] fils;

    public Node(Color v){
        this.valeur = v;
        this.pere=null;
        this.fils= null;
    }

    public Node(Color v, Node p){
        this.valeur = v;
        this.pere=p;
        this.fils= null;
    }

    public Color getValeur(){
        return this.valeur;
    }

    public void setColor(Color v){
        this.valeur = v;
    }

    public Node getPere(){
        return this.pere;
    }

    public void setPere(Node p){
        this.pere = p;
    }


    public Node[] getFils(){
        return this.fils;
    }

    public void setFils(Node f1, Node f2, Node f3, Node f4){
        this.fils = new Node[]{f1,f2,f3,f4};
    }


}
