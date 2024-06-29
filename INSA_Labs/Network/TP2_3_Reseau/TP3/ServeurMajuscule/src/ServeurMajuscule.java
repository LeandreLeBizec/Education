import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.*;
import java.nio.charset.StandardCharsets;

public class ServeurMajuscule {
    public static void main(String argv[]) {
        int port = 8888;
        ServerSocket Socket_TCP = null;
        Socket Socket_Comm_TCP = null;
        int compteur = 0;

        // ouvrir socket tcp
        try {
            Socket_TCP = new ServerSocket(port);
            System.out.println("port : "+port +"     IP : "+Socket_TCP.getInetAddress());

            while(compteur <3) {

                Socket_Comm_TCP = Socket_TCP.accept();
                compteur ++;
                PrintStream ps = new PrintStream(Socket_Comm_TCP.getOutputStream());
                BufferedReader br = new BufferedReader(new InputStreamReader(Socket_Comm_TCP.getInputStream()));

                //envoie du message de consigne/home/leandre/Info_3a/TP_Reseau/TP2_3_Reseau/TP3/ServeurMajuscule/src/ServeurMajuscule.java

                ps.println("Chaine de caractere courtes et '.' termine la connexion");

                String message = br.readLine();
                while (!message.equals(".")) {
                    message = message.toUpperCase();
                    ps.println(message);
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
