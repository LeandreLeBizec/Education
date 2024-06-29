import java.util.ArrayList;
import java.util.HashMap;

public class Enseignant {

    private String  nom;
    private HashMap<Horaire, Cours> tableEnseignant;

    public Enseignant(String n){
        this.nom = n;
        this.tableEnseignant = null;
    }

    public String getNom(){
        return this.nom;
    }

    public void setNom(String n){
        this.nom = n;
    }

    public HashMap<Horaire, Cours> getTableEnseignant(){
        return this.tableEnseignant;
    }

    public void setTableEnseignant(HashMap<Horaire, Cours> te){
        this.tableEnseignant = te;
    }

    public void ajouterCours(Horaire h, Cours c) throws HoraireException {
        if(this.tableEnseignant.containsKey(h)){
            throw new HoraireException("Horraire déjà occupé");
        }else{
            this.tableEnseignant.put(h,c);
        }

    }

}
