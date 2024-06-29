package iterateur;

public class Maillon<T> {

    private T val;
    private Maillon<T> s;
    private Maillon<T> p;

    public Maillon(){
        this.val=null;
        this.s=null;
        this.p=null;
    }

    public Maillon(T v){
        this.val=v;
        this.s=null;
        this.p=null;
    }

    public Maillon(T v,final Maillon<T> suiv,final Maillon<T> pred){
        this.val=v;
        this.s=suiv;
        this.p=pred;
    }

    public T getVal(){
        return this.val;
    }

    public void setVal(T o){
        this.val = o;
    }

    public Maillon<T> getSucc(){
        return s;
    }

    public void setSucc(Maillon<T> succ){
        this.s = succ;
    }

    public Maillon<T> getPred(){
        return p;
    }

    public void setPred(Maillon<T> pred){
        this.p = pred;
    }

}
