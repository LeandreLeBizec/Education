package iterateur;

public class ListeTabulee implements Liste{

    private final static int NB_MAX = 100;
    private Object[] listeTabulee;
    private int nbElement;


    public ListeTabulee(){
        nbElement=0;
        listeTabulee = new Object[NB_MAX];
    }

    public int getNbElement(){
        return this.nbElement;
    }

    public void setNbElement(int i){
        this.nbElement=i;
    }

    public Object getElement(int i){
        return listeTabulee[i];
    }

    public void setElement(int i, Object o){
        listeTabulee[i]=o;
    }

    /**
     * renvoie True si la liste est vide
     */
    @Override
    public Boolean estVide() {
        return this.nbElement == 0;
    }

    /**
     * vide la liste
     */
    @Override
    public void vider() {
        nbElement = 0;
    }

    /**
     *
     */
    @Override
    public Iterateur iterateur() {
        return null;
    }

    public String toString(){
        String s="ListeTabulee = [";
        for(int i=0; i< nbElement;i++){
            s+=listeTabulee[i] + ", ";
        }
        s+="]";
        return  s;
    }


    public static void main (String[] args){
        ListeTabulee maListe = new ListeTabulee();
        System.out.println(maListe.estVide());

    }
}
