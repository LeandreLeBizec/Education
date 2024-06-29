import java.awt.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.*;
import java.nio.charset.StandardCharsets;

public class ServeurPlusOuMoins {
    public static void main(String argv[]) {
        int port = 8888;
        ServerSocket Socket_TCP = null;
        Socket Socket_Comm_TCP = null;
        int compteur = 0;
        int nbTours = 0;
        int nb = 0;

        // ouvrir socket tcp
        try {
            Socket_TCP = new ServerSocket(port);
            System.out.println("port : "+port +"     IP : "+Socket_TCP.getInetAddress());

            while(compteur <3) {

                Socket_Comm_TCP = Socket_TCP.accept();
                nb = (int)(Math.random()*100);
                nbTours =0;
                compteur ++;
                PrintStream ps = new PrintStream(Socket_Comm_TCP.getOutputStream());
                BufferedReader br = new BufferedReader(new InputStreamReader(Socket_Comm_TCP.getInputStream()));

                //envoie du message de consigne

                ps.println("Trouve le nombre entre 0 et 100");

                String message = br.readLine();
                while (nbTours < 10) {

                    try {
                        nbTours ++;
                        if (Integer.parseInt(message) > nb) {
                            ps.println("C'est moins");
                        }
                        if (Integer.parseInt(message) < nb) {
                            ps.println("C'est plus");
                        }
                        if (Integer.parseInt(message) == nb) {
                            ps.println("C'est gagné en " + nbTours);
                            break;
                        }
                        if (nbTours > 9) {
                            ps.println("C'est perdu");
                            break;
                        }
                    }catch(NumberFormatException e) {
                        //e.printStackTrace();
                        //System.out.println(message);
                        if (message == null) {
                            ps.println("interruption brutale");
                            break;
                        }
                        ps.println("mauvais format");

                    }
                    message = br.readLine();
                }
                Socket_Comm_TCP.close();
                System.out.println("On ferme la connection avec le client");
            }
            Socket_TCP.close();
            System.out.println("On ferme le serveur apres 3 clients");

        } catch (IOException e) {
            System.out.println("Erreur sur DatagramSocket");
            //return;
        }

    }
}