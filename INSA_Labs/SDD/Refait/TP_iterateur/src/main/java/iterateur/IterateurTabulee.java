package iterateur;

public class IterateurTabulee<T> implements Iterateur{

    int ec;
    ListeTabulee lt;

    public IterateurTabulee(ListeTabulee l){
        this.lt = l;
        this.entete();
    }

    /**
     * positionne l'élément courant sur la tête de liste
     */
    @Override
    public void entete() {
        ec = 0;
    }

    /**
     * positionne l'élément courant sur la queue de liste
     */
    @Override
    public void enqueue() {
        ec=lt.getNbElement();
    }

    /**
     * positionne l'élément courant sur l'élément suivant
     */
    @Override
    public void succ() throws EstSortieException {
        if(this.estSortie()){
            throw new EstSortieException();
        }else{
            ec++;
        }
    }

    /**
     * positionne l'élément courant sur l'élément précedant
     */
    @Override
    public void pred() throws EstSortieException {
        if(this.estSortie()){
            throw new EstSortieException();
        }else{
            ec--;
        }
    }

    /**
     * ajoute l'objet o à droite de l'élément courant et l'ec devient l'ajouté
     *
     * @param o
     */
    @Override
    public void ajouterD(Object o) throws EstSortieException, EstVideException {
        if(this.estSortie()){
            throw new EstSortieException();
        } else if(lt.estVide()){
            lt.setNbElement(lt.getNbElement()+1);
            lt.setElement(0,o);
            ec++;
        } else {
            lt.setNbElement(lt.getNbElement()+1);
            for (int i= lt.getNbElement()-1; i>=ec;i--){
                lt.setElement(i, lt.getElement(i-1));
            }
            lt.setElement(ec, o);
            ec++;
        }
    }

    /**
     * ajoute l'objet o à gauche de l'élément courant et l'ec devient l'ajouté
     *
     * @param o
     */
    @Override
    public void ajouterG(Object o) throws EstSortieException, EstVideException {
        if(this.estSortie()){
            throw new EstSortieException();
        } else if(lt.estVide()){
            throw new EstVideException();
        } else {
            lt.setNbElement(lt.getNbElement()+1);
            for (int i= lt.getNbElement()-1; i>=ec;i--){
                lt.setElement(i, lt.getElement(i-1));
            }
            lt.setElement(ec-1, o);
            ec--;
        }
    }

    /**
     * enlève l'élément courant de la liste
     */
    @Override
    public void oterec() throws EstSortieException {
        if(ec== lt.getNbElement()){
            lt.setNbElement(lt.getNbElement()-1);
            ec--;
        }else {
            for (int i = ec; i < lt.getNbElement()-1; i++) {
                lt.setElement(i, lt.getElement(i + 1));
            }
            lt.setNbElement(lt.getNbElement() - 1);
        }
    }

    /**
     * renvoie l'élément courant
     */
    @Override
    public Object valec() throws EstSortieException {
        return lt.getElement(ec);
    }

    /**
     * modifie l'élement courant par l'objet o
     *
     * @param o
     */
    @Override
    public void modifec(Object o) throws EstSortieException{
        if (this.estSortie()){
            throw new EstSortieException();
        }
        lt.setElement(ec, o);
    }

    /**
     * renvoie True si l'élément courant est sortie de la liste
     */
    @Override
    public Boolean estSortie() {
        return (ec < 0 || ec > lt.getNbElement());
    }



    public static void main (String[] args) throws EstVideException, EstSortieException {
        ListeTabulee maListe = new ListeTabulee();
        System.out.println(maListe.estVide());
        IterateurTabulee monIterateur = new IterateurTabulee(maListe);
        monIterateur.ajouterD(1);
        System.out.println(maListe.estVide());
        monIterateur.ajouterD(3);
        System.out.println(maListe.toString());
        monIterateur.ajouterG(2);
        System.out.println(maListe.toString());
        monIterateur.oterec();
        System.out.println(maListe.toString());
    }
}
