import java.io.File;
import java.io.FileFilter;

public class SearchPath {
    public static void main(String[] args) {
        String[] path = System.getenv("PATH").split(System.getProperty("path.separator"));
        for (String searchString : args) {
            NameContains searchFilter = new NameContains(searchString);
            for (String dir : path) {
                File[] matches = new File(dir).listFiles(searchFilter);
                if (matches != null) {
                    for (File match : matches) {
                        System.out.println(match.getAbsolutePath());
                    }
                }
            }
        }
    }

    static class NameContains implements FileFilter {
        private final String searchText;
        public NameContains(String searchText) {
            this.searchText = searchText;
        }
        public boolean accept(File f) {
            return f.getName().contains(searchText);
        }
    }
}
