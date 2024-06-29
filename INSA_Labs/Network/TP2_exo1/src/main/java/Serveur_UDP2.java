import java.io.IOException;
import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetAddress;

public class Serveur_UDP2 {
    DatagramPacket message;
    DatagramPacket reponse;
    DatagramSocket socket_UDP;
    InetAddress Adress_IP = null;
    byte[] sendBuf = new byte[256];
    byte [] recBuf = new byte[256];
    int port = 0;

    public Serveur_UDP2(int p){
        try{
            socket_UDP = new DatagramSocket(p);
        }catch (IOException e){
            System.out.println(("Erreur sur DatagramSocket"));
        }
        this.port = p;
    }

    //Serveur en attente
    public void attente() {
        message = new DatagramPacket(recBuf, 256);
        try{
            socket_UDP.receive(message);
            repondre();
        }catch (IOException e){
            System.out.println("Erreur Socket_UDP.receive :");
            e.printStackTrace();
        }
    }

    //envoyer une réponse
    public void repondre(){
        String rep = "salut";
        reponse = new DatagramPacket(rep.getBytes(),rep.getBytes().length, message.getAddress(), message.getPort());
        try{
            socket_UDP.send(reponse);
            attente();
        }catch (IOException e){
            System.out.println("Erreur Socket_UDP.send :");
            e.printStackTrace();
        }
    }

    public static void main(String argv[]) {
        Serveur_UDP2 s = new Serveur_UDP2(8888);
        s.attente();
    }



}
