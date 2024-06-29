package defaut;

import java.util.Locale;

public class Mot {

    private String mot;

    public Mot(){
        this.mot="";
    }

    public Mot(String s){
        this.mot=s.toLowerCase();
    }

    @Override
    public String toString(){
        return this.mot;
    }

    @Override
    public boolean equals(Object o){
        Mot m = (Mot)o;
        return (this.mot.equals(m.mot));
    }

    @Override
    public int hashCode(){
        char[] tab = this.mot.toCharArray();
        int hash = tab[0]*26 + tab[1];
        return hash;
    }

}
