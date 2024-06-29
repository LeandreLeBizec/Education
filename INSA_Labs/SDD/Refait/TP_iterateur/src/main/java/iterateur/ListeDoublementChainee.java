package iterateur;

public class ListeDoublementChainee<T> implements Liste{

    private final Maillon<T> tete;
    private Maillon<T> ec;
    private final Maillon<T> queue;

    public ListeDoublementChainee(){
        this.tete = new Maillon<>();
        this.queue = new Maillon<>();
        tete.setSucc(queue);
        queue.setPred(tete);
    }

    /**
     * renvoie True si la liste est vide
     */
    @Override
    public Boolean estVide() {
        return (tete.getSucc()==queue || queue.getPred()==tete);
    }

    /**
     * vide la liste
     */
    @Override
    public void vider() {
        tete.setSucc(queue);
        queue.setPred(tete);
    }

    /**
     *
     */
    @Override
    public Iterateur iterateur() {
        return null;
    }



    public static void main (String[] args){
        ListeTabulee maListe = new ListeTabulee();
        System.out.println(maListe.estVide());

    }
}
