package liste;

/** Définie une liste */
public interface Liste<T> {

    /** créer une nouvelle liste */
    // Constructeur de la classe qui implémente l'interface Liste
    /** positionne l'élément courant sur la tête de liste */
    void entete();
    /** positionne l'élément courant sur la queue de liste */
    void enqueue();
    /** positionne l'élément courant sur l'élément suivant */
    void succ() throws EstSortieException;
    /** positionne l'élément courant sur l'élément précedant */
    void pred() throws EstSortieException;
    /** ajoute l'objet o à droite de l'élément courant */
    void ajouterD(final T o) throws EstSortieException, EstVideException;
    /** enlève l'élément courant de la liste */
    void oterec() throws EstSortieException;
    /** renvoie l'élément courant */
    T valec() throws EstSortieException;
    /** renvoie True si l'élément courant est sortie de la liste */
    Boolean estSortie();
    /** renvoie True si la liste est vide */
    Boolean estVide();
}
