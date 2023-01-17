import java.io.BufferedReader;
import java.io.InputStreamReader;

public class ToLowerCase {
    public static void main(String[] args) {
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
            String line;
            while ((line = in.readLine()) != null) {
                System.out.println(line.toLowerCase());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}