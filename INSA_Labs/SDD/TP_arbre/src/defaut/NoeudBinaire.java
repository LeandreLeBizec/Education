package defaut;

public class NoeudBinaire extends Noeud{

    private Noeud filsD;
    private Noeud filsG;

    public NoeudBinaire(String s){
        this.setValue(s);
    }

    public Noeud getFilsD(){
        return this.filsD;
    }


    public Noeud getFilsG(){
        return this.filsG;
    }


    public void setFilsG(Noeud n){
        if (n==null){
            this.filsG=null;
        }else {
            this.filsG = n;
        }
    }


    public void setFilsD(Noeud n){
        if (n==null){
            this.filsD=null;
        }else {
            this.filsD = n;
        }
    }

    @Override
    public String toString(){
        return (this.filsD.toString() + " " + this.filsG.toString() + " " + this.getValue());
    }

}
