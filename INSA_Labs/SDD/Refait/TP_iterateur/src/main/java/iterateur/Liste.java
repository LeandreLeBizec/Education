package iterateur;

/** Gestion du stockage de la liste */
public interface Liste<T> {

    /** renvoie True si la liste est vide */
    Boolean estVide();
    /** vide la liste */
    void vider();
    /** */
    Iterateur<T> iterateur();




}
