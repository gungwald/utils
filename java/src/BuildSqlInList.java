import java.io.BufferedReader;
import java.io.FileReader;

public class BuildSqlInList {
    public static void main(String[] args) {
        try {
            StringBuffer sql = new StringBuffer();
            int lineCount = 0;
            String lineSeparator = System.getProperty("line.separator");
            for (int i = 0; i < args.length; i++) {
                String arg = args[i];
                BufferedReader in = new BufferedReader(new FileReader(arg));
                String line;
                while ((line = in.readLine()) != null) {
                    if (sql.length() != 0) {
                        sql.append(",");
                        if (lineCount % 4 == 0) {
                            sql.append(lineSeparator);
                        }
                    }
                    sql.append("'");
                    sql.append(line);
                    sql.append("'");
                    lineCount++;
                }
            }
            System.out.println(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}