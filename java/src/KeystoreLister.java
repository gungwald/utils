import java.io.File;
import java.util.Properties;

// TODO - Possibly create a Keystore class with methods like "list" and "addCert".

public class KeystoreLister {
	
	public static final int EXIT_SUCCESS = 0;
	public static final int EXIT_FAILURE = 1;

	public static final Properties PROPS = System.getProperties();
	public static final File JAVA_HOME = new File(PROPS.getProperty("java.home"));
	public static final File JAVA_BIN_DIR = new File(JAVA_HOME, "bin");
	public static final String EXEC_EXT;
	public static final File JRE_HOME;
	public static final File KEYSTORE;
	public static final File KEYTOOL;

	static {
		File javaExe  = new File(JAVA_BIN_DIR, "java.exe");
		EXEC_EXT = javaExe.exists() ? ".exe" : "";
		File jreHome = new File(JAVA_HOME, "jre");
		JRE_HOME = jreHome.exists() ? jreHome : JAVA_HOME;
		KEYSTORE = new File(JRE_HOME, "lib/security/cacerts");
		KEYTOOL = new File(JAVA_BIN_DIR, "keytool" + EXEC_EXT);
	}
	
	public static String[] buildKeystoreListCommand(File keystore) {
		return new String[] {
					KEYTOOL.getAbsolutePath(), 
					"-list",
					"-keystore", keystore.getAbsolutePath(),
					"-storepass", "changeit"					
			};
	}
	
	public static void main(String[] args) {
		int exitCode;
		try {
			File keystore = (args.length > 0) ? new File(args[0]) : KEYSTORE;
			exitCode = Executor.exec(buildKeystoreListCommand(keystore));
		}
		catch (Exception e) {
			e.printStackTrace();
			exitCode = EXIT_FAILURE;
		}
		System.exit(exitCode);
	}

}
