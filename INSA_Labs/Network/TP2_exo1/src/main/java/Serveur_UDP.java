import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;


public class Serveur_UDP {

    public static void main(String argv[]) {
        int port_ec = 9999;
        int port_rep = 0;
        String hote;
        Client_UDP client;
        DatagramPacket Message;
        byte[] sendBuf = new byte[256];
        byte[] data = new byte[256];
        DatagramSocket Socket_UDP;
        InetAddress Adresse_IP = null;

        // Ouvrir un socket UDP
        try
        {
            Socket_UDP = new DatagramSocket(port_ec); // ecoute sur le port_ec
        }
        catch  (IOException e)
        {
            System.out.println("Erreur sur DatagramSocket");
            return;
        }

        // Attendre la reponse emise par le client
        Message = new DatagramPacket(sendBuf, 256);
        try
        {
            Socket_UDP.receive(Message);
            Adresse_IP = Message.getAddress();
            port_rep = Message.getPort(); // pour repondre sur ce port
            data = Message.getData();
        }
        catch  (IOException e)
        {
            System.out.println("Erreur Socket_UDP.receive :");
            e.printStackTrace();
            return;
        }

        // Envoyer un message sur ce port
        String donnee = "msg";
        Message = new DatagramPacket(donnee.getBytes(), donnee.getBytes().length, Adresse_IP, port_rep);
        try
        {
            Socket_UDP.send(Message);
        }
        catch  (IOException e)
        {
            System.out.println("Emission ratee ...");
            e.printStackTrace();
            return;
        }

        System.out.println
                (Thread.currentThread().getName()
                        +" Emission vers : " + Adresse_IP
                        + " sur le port : " + port_rep);

    }


}

