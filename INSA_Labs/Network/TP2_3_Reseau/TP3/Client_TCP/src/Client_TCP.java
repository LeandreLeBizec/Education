import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Client_TCP {
    public static void main(String argv[]) {
        int port = 8888;
        String IP = "localhost";
        Socket Socket_Comm_TCP = null;

        try{
            Socket_Comm_TCP = new Socket(IP,port);
            PrintStream ps = new PrintStream(Socket_Comm_TCP.getOutputStream());
            BufferedReader br = new BufferedReader(new InputStreamReader(Socket_Comm_TCP.getInputStream()));

            System.out.println(br.readLine());
            ps.println("je suis en majuscule");
            System.out.println(br.readLine());

            System.out.println("Je demande la fermeture du socket");
            ps.println(".");

            Socket_Comm_TCP.close();

        }catch(IOException e){
            System.out.println("marche pas");
        }

    }
}
