import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Client_TCP2 {
    public static void main(String argv[]) {
        int port = 8888;
        String IP = "localhost";
        Socket Socket_Comm_TCP = null;

        try{
            Socket_Comm_TCP = new Socket(IP,port);
            PrintStream ps = new PrintStream(Socket_Comm_TCP.getOutputStream());
            BufferedReader brSocket = new BufferedReader(new InputStreamReader(Socket_Comm_TCP.getInputStream()));
            BufferedReader brClavier = new BufferedReader(new InputStreamReader(System.in));

            String message = brSocket.readLine();

            while(!(message.contains("est gagn") && !(message.contains("perdu")))){
                System.out.println(message);
                String ligne = brClavier.readLine();
                ps.println(ligne);
                message = brSocket.readLine();
            }

            Socket_Comm_TCP.close();

        }catch(IOException e){
            System.out.println("marche pas");
        }

    }
}
