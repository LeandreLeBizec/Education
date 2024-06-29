import java.util.ArrayList;
import java.util.HashMap;

public class EmploiDuTemps {

    private ArrayList<Enseignant> edt;


    public EmploiDuTemps(ArrayList<Enseignant> ListeEnseignant){
        edt = new ArrayList<Enseignant>();
        for (Enseignant e : ListeEnseignant){
            e.setTableEnseignant(new HashMap<>());
            edt.add(e);
        }
    }

    public void ajouterCoursEnseigant(Enseignant e,Horaire h, Cours c) throws HoraireException {
        e.ajouterCours(h,c);
    }

    public int totalCours(Horaire h){
        int i=0;
        for (Enseignant e : this.edt ){
            if(e.getTableEnseignant().containsKey(h)){
                i++;
            }
        }
        return i;
    }







}
