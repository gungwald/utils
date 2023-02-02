import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
public class SetDiff {
    public static Collection readElements(String fileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(fileName));
        String line;
        ArrayList elements = new ArrayList();
        while ((line = in.readLine()) != null) {
            elements.add(line);
        }
        return elements;
    }
    public static void main(String[] args) {
        try {
            if (args.length == 2) {
                Collection setA = readElements(args[0]);
                Collection setB = readElements(args[1]);
                setA.removeAll(setB);
                Iterator i = setA.iterator();
                while (i.hasNext()) {
                    System.out.println(i.next());
                }
            } else {
                System.err.println("Bad user");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}