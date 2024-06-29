import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class ServeurMajuscule {
    int port;
    ServerSocket ss;
    Socket s;
    PrintStream ps;
    int nbConnexion = 0;


    public ServeurMajuscule(int p){
        this.port = p;
        attenteConnexion();
    }

    public void attenteConnexion(){
        try{
            ss = new ServerSocket(this.port); // ServerSocket ouvert sur le port choisi
            System.out.println("Adresse du serveur : " + ss.getInetAddress() + "\nNuméro de port du Serveur : " + ss.getLocalPort());

            while(nbConnexion<3){
                s = ss.accept();
                nbConnexion++;
                ps = new PrintStream(s.getOutputStream()); //OutputStream : permet d'afficher texte
                ps.println("Connexion etablie \nenvoyez une ligne à la fois \n'.' pour mettre fin à la connexion");
                BufferedReader br = new BufferedReader(new InputStreamReader(s.getInputStream()));

                String msg = br.readLine();
                while(!msg.equals(".")){
                    msg = msg.toUpperCase();
                    ps.println(msg);
                    msg = br.readLine();
                }
                ps.println("Connexion client fermé, Au revoir");
                s.close();
            }
            ps.println("Connexion serveur fermé");
            ss.close();


        }catch (IOException e){
            e.printStackTrace();
        }
    }

    public static void main(String[] args){
        ServeurMajuscule SM = new ServeurMajuscule(8888);
    }
}
