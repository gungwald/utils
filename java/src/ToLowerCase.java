import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.IOException;

public class ToLowerCase {
    public static void main(String[] args) {
        try {
            if (args.length == 0) {
                toLowerCase(new BufferedReader(new InputStreamReader(System.in)));
            } else {
                for (int i = 0; i < args.length; i++) {
                    toLowerCase(new BufferedReader(new InputStreamReader(new FileInputStream(args[i]))));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void toLowerCase(BufferedReader in) throws IOException {
        String line;
        while ((line = in.readLine()) != null) {
            System.out.println(line.toLowerCase());
        }
    }
}