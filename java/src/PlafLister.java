import javax.swing.UIManager;
import javax.swing.UIManager.LookAndFeelInfo;

public class PlafLister {

    public static void main(String[] args) {
        String systemLaf = UIManager.getSystemLookAndFeelClassName();
        LookAndFeelInfo[] lafInfos = UIManager.getInstalledLookAndFeels();
        for (int i = 0; i < lafInfos.length; i++) {
            LookAndFeelInfo info = lafInfos[i];
            String className = info.getClassName();
            String name = info.getName();
            System.out.print(name + "\t" + className);
            if (className.equals(systemLaf)) {
                System.out.println(" (System)");
            } else {
                System.out.println();
            }
        }
    }
}
