import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class ServeurPlusMoins {
    int port;
    ServerSocket ss;
    Socket s;
    PrintStream ps;
    int nbConnexion = 0;


    public ServeurPlusMoins(int p){
        this.port = p;
        attenteConnexion();
    }

    public void attenteConnexion(){
        int n = (int)(Math.random()*100);
        try{
            ss = new ServerSocket(this.port); // ServerSocket ouvert sur le port choisi
            System.out.println("Adresse du serveur : " + ss.getInetAddress() + "\nNuméro de port du Serveur : " + ss.getLocalPort());

            while(nbConnexion<3){
                s = ss.accept();
                nbConnexion++;
                ps = new PrintStream(s.getOutputStream()); //OutputStream : permet d'afficher texte
                ps.println("Connexion etablie \n" +
                        "choisissez un nombre\n" +
                        "trouvez le nombre pour mettre fin à la connexion");
                BufferedReader br = new BufferedReader(new InputStreamReader(s.getInputStream()));

                int msg = Integer.parseInt(br.readLine());
                int cpt = 1;
                while(msg != n){
                    if(msg < n){
                        ps.print("C'est plus \n");
                    }else{
                        ps.print("C'est moins \n");
                    }
                    msg = Integer.parseInt(br.readLine());
                    cpt++;
                }
                ps.print("Vous avez trouver le bon nombre en " + cpt +" coup, fin de la connexion");
                s.close();
            }
            ps.println("Connexion serveur fermé");
            ss.close();


        }catch (IOException e){
            e.printStackTrace();
        }
    }

    public static void main(String[] args){
        ServeurPlusMoins SM = new ServeurPlusMoins(8888);
    }
}
