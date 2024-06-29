import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;

public class ClientMajuscule {
    int port;
    Socket s;
    PrintStream ps;
    String[] msg = {"un", "deux", "trois", "."};

    public ClientMajuscule(int p) {
        this.port = p;
        try {
            s = new Socket("localhost", p);
            ps = new PrintStream(s.getOutputStream());
            BufferedReader br = new BufferedReader(new InputStreamReader(s.getInputStream()));
            System.out.println(br.readLine());
            System.out.println(br.readLine());
            System.out.println(br.readLine());
            for(String s : msg){
                ps.println(s);
                System.out.println(br.readLine());
            }
            s.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        ClientMajuscule CM = new ClientMajuscule(8888);
    }

}
