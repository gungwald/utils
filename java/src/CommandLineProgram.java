
public interface CommandLineProgram {
	/**
	 * Main should look like this:
	 * <pre>
	 * public static void main(String[] args) {
	 *     int exitCode;
	 *     try {
	 *         exitCode = new MyClass().run(args);
	 *     } catch (Exception e) {
	 *         e.printStackTrace();
	 *         exitCode = 1;
	 *     }
	 *     System.exit(exitCode);
	 * }
	 * </pre>
	 * 
	 * @param args
	 * @return
	 */
	public int run(String[] args);
}
