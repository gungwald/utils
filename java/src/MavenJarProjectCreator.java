import java.io.*;

public class MavenJarProjectCreator {

	public static final int EXIT_SUCCESS = 0;
	public static final int EXIT_FAILURE = 1;

	public static void main(String[] args) {
		int exitCode = EXIT_SUCCESS;

		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

			System.out.print("Enter groupId (example: com.companyname.groupname): ");
			String group = in.readLine();

			if (group != null && group.length() > 0) {
				System.out.print("Enter artifactId (example: my-component-name): ");
				String artifact = in.readLine();

				if (artifact != null && artifact.length() > 0) {
					String[] cmd = new String[]{
							"mvn",
							"archetype:generate",
							"-DgroupId=" + group,
							"-DartifactId=" + artifact,
							"-DarchetypeArtifactId=maven-archetype-quickstart",
							"-DinteractiveMode=false"
					};
					exitCode = Executor.exec(cmd);
				}
			}
		} catch (Exception e) {
			System.err.println(e.getLocalizedMessage());
			exitCode = EXIT_FAILURE;
		}
		System.exit(exitCode);
	}

}

