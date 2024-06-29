package defaut;

public class Couple {

    private Mot mot;
    private Mot trad;

    public Couple(){
        this.mot= new Mot();
        this.trad= new Mot();
    }

    public Couple(Mot m, Mot t){
        this.mot= m;
        this.trad=t;
    }

    public Mot getMot(){
        return this.mot;
    }

    public Mot getTrad(){
        return this.trad;
    }

    @Override
    public String toString(){
        return (this.mot + " : " + this.trad);
    }

    public Mot compCoupleMot(Mot m){
        if (this.mot.equals(m)){
            return this.trad;
        }
        return null;

    }
}
