import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;

public class ClientPlusMoins {
    int port;
    Socket s;
    PrintStream ps;

    public ClientPlusMoins(int p) {
        this.port = p;
        try {
            s = new Socket("localhost", p);
            ps = new PrintStream(s.getOutputStream());
            BufferedReader brS = new BufferedReader(new InputStreamReader(s.getInputStream()));
            BufferedReader brC = new BufferedReader(new InputStreamReader(System.in));
            System.out.println(brS.readLine());
            System.out.println(brS.readLine());
            System.out.println(brS.readLine());

            String reponse = "";
            while(!reponse.contains("Vous avez trouver")){
                System.out.println(reponse);
                String line = brC.readLine();
                ps.println(line);
                reponse= brS.readLine();
            }
            System.out.println(reponse);
            s.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        ClientPlusMoins PM = new ClientPlusMoins(8888);
    }
}
