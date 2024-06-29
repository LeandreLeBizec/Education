package defaut;

import java.util.Arrays;

public class TableCouple {

    private TableListeCouple[] lists;
    private int size;

    public TableCouple(){
        this.size=0;
        this.lists= new TableListeCouple[this.size];
    }

    public TableCouple(int s){
        this.size=s;
        this.lists= new TableListeCouple[this.size];
    }

    @Override
    public String toString() {
        String s = "";
        for (TableListeCouple l: lists){
            for(Couple c: l) {
                s += c.getMot() + " : " + c.getTrad() + "\n";
            }
        }
        return s;
    }

    public boolean ajouter(Mot m, Mot t){
        int code = m.hashCode() % size;
        if(this.couples[code]==null){
            this.couples[code]=new Couple(m,t);
            return true;
        }
        return false;
    }


    public Mot traduire(Mot m){
        for (Couple c: couples){
            if(c.getMot()==m){
                return c.getTrad();
            }
        }
        return null;
    }
}
