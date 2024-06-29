package liste;

public class ListeDoubleChainage<T> implements Liste<T>{

    private final Maillon<T> tete;
    private Maillon<T> ec;
    private final Maillon<T> queue;

    /**
     * créer une nouvelle liste
     */
    public ListeDoubleChainage(){
        this.tete = new Maillon<>( );
        this.queue = new Maillon<>( );
        tete.setSucc(queue);
        queue.setPred(tete);
        this.entete();
    }

    /**
     * positionne l'élément courant sur la tête de liste
     */
    @Override
    public void entete() {
        if (tete.getSucc() != queue){
            ec = tete.getSucc();
        }else{
            ec=tete;
        }

    }

    /**
     * positionne l'élément courant sur la queue de liste
     */
    @Override
    public void enqueue() {
        if (tete.getSucc() != queue){
            ec = queue.getPred();
        }else{
            ec=queue;
        }
    }

    /**
     * positionne l'élément courant sur l'élément suivant
     */
    @Override
    public void succ() throws EstSortieException {
        if (this.estSortie()){
            throw new EstSortieException();
        }else{
            ec = ec.getSucc();
        }
    }

    /**
     * positionne l'élément courant sur l'élément précedant
     */
    @Override
    public void pred() throws  EstSortieException{
        if (this.estSortie()){
            throw new EstSortieException();
        }else{
            ec = ec.getPred();
        }
    }

    /**
     * ajoute l'objet o à droite de l'élément courant
     *
     * @param o
     */
    @Override
    public void ajouterD(T o) throws EstSortieException, EstVideException{
        if (this.estVide()){
            throw new EstVideException();
        } else if (this.estSortie()){
            throw new EstSortieException();
        } else {
            Maillon<T> nv = new Maillon(o);
            Maillon<T> tmp = ec.getSucc();
            ec.setSucc(nv);
            tmp.setPred(nv);
            nv.setPred(ec);
            nv.setSucc(tmp);
        }
    }

    /**
     * enlève l'élément courant de la liste
     */
    @Override
    public void oterec() throws EstSortieException{
        if (this.estSortie()){
            throw new EstSortieException();
        }
        (ec.getPred()).setSucc(ec.getSucc());
        (ec.getSucc()).setPred(ec.getPred());
    }

    /**
     * renvoie l'élément courant
     */
    @Override
    public T valec() {
        return ec.getVal();
    }

    /**
     * renvoie True si l'élément courant est sortie de la liste
     */
    @Override
    public Boolean estSortie() {
        return (ec==queue);
    }

    /**
     * renvoie True si la liste est vide
     */
    @Override
    public Boolean estVide() {
        return (tete.getSucc()==null || queue.getPred()==null);
    }

    public static void main(String[] args) throws EstVideException, EstSortieException {
        ListeDoubleChainage<Integer> l = new ListeDoubleChainage<>();
        int i = 4;
        System.out.println(l.estVide());
        l.ajouterD(i);
        System.out.println(l.estVide());
    }
}
