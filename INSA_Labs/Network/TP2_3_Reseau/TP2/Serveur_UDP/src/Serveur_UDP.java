import java.io.IOException;
import java.net.*;
import java.nio.charset.StandardCharsets;

public class Serveur_UDP {

    public static void main(String argv[]) {
        int port = 8888;
        int port_UDP = 8888;
        DatagramPacket Message;
        byte[] sendBuf = new byte[256];
        byte[] data = new byte[256];
        DatagramSocket Socket_UDP;
        InetAddress Adresse_IP = null;

        // Ouvrir un socket UDP
        try
        {
            Socket_UDP = new DatagramSocket(port);
        }
        catch  (IOException e)
        {
            System.out.println("Erreur sur DatagramSocket");
            return;
        }

        // Attendre la reponse emise par le serveur
        Message = new DatagramPacket(sendBuf, 256);
        try
        {
            Socket_UDP.receive(Message);
            Adresse_IP = Message.getAddress();
            port_UDP = Message.getPort();
            data = Message.getData();
        }
        catch  (IOException e)
        {
            System.out.println("Erreur Socket_UDP.receive :");
            e.printStackTrace();
            return;
        }

        // Envoyer un message sur ce port
        String donnee = " ça marche";
        Message = new DatagramPacket(donnee.getBytes(), donnee.getBytes().length, Adresse_IP, port_UDP);
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
                        + " : Emission vers " + Adresse_IP
                        + ", port " + port_UDP);


    }
}

