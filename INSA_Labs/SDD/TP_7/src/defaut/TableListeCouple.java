package defaut;

import java.util.*;

public class TableListeCouple {
    private List<Couple>[] ListeCouples;
    private int size ;

    public TableListeCouple(int taille) {
        this.size = taille;
        this.ListeCouples = new LinkedList[this.size];
    }


    public void ajouter(Mot m, Mot t) {
        int code = m.hashCode() % this.size;
        if (this.ListeCouples[code] == null) {
            this.ListeCouples[code] = new LinkedList();
        }
        this.ListeCouples[code].add(new Couple(m,t));
    }

    public Mot traduire(Mot m){
        int code = m.hashCode() ;
        for (Couple c : ListeCouples[code]){
            if (c.getMot()==m) {
                return c.getMot();
            }
        }
        return null;
    }

    public String toString() {
        String s = "";
        for(List<Couple> l : ListeCouples) {
            for(Couple c: l) {
                s += c.getMot() + " : " + c.getTrad() + "\n";
            }
        }
        return s;
    }

}
