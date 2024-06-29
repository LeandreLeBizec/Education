import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.InputStream;
import java.io.BufferedReader;
import java.net.Socket;

public class Client_Http {
    public static void main(String[] argv){
        Client_Http Mon_Client_HTTP = new Client_Http();
        try{
            for(int i =0;i<50;i++) {
                Socket s = new Socket("localhost", 8888);
                PrintStream ps = new PrintStream(s.getOutputStream());
                BufferedReader br = new BufferedReader(new InputStreamReader(s.getInputStream()));

                ps.println("GET / HTTP/1.1\r\n");
                System.out.println(br.readLine());
/*
            String msg = br.readLine();
            while(msg!=null){
                System.out.println(msg);
                 msg = br.readLine();
            };
*/

                ps.close();
                br.close();
                s.close();
            }
        }catch(Exception e){
            System.out.println("aie");
        }

    }


}
