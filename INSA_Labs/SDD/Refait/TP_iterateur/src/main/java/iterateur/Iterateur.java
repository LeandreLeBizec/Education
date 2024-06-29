package iterateur;

/** Gestion de l'énumération de la liste : tout ce qui concerne l'ec */
public interface Iterateur<T> {

    /** positionne l'élément courant sur la tête de liste */
    void entete();
    /** positionne l'élément courant sur la queue de liste */
    void enqueue();
    /** positionne l'élément courant sur l'élément suivant */
    void succ() throws EstSortieException;
    /** positionne l'élément courant sur l'élément précedant */
    void pred() throws EstSortieException;
    /** ajoute l'objet o à droite de l'élément courant et l'ec devient l'ajouté */
    void ajouterD(final T o) throws EstSortieException, EstVideException;
    /** ajoute l'objet o à gauche de l'élément courant et l'ec devient l'ajouté */
    void ajouterG(final T o) throws EstSortieException, EstVideException;
    /** enlève l'élément courant de la liste */
    void oterec() throws EstSortieException;
    /** renvoie l'élément courant */
    T valec() throws EstSortieException;
    /** modifie l'élement courant par l'objet o*/
    void modifec(T o) throws EstSortieException;
    /** renvoie True si l'élément courant est sortie de la liste */
    Boolean estSortie();

}
