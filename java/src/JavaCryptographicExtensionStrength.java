import javax.crypto.Cipher;

public class JavaCryptographicExtensionStrength {

    public static final int JCE_UNLIMITED_STRENGTH = 2147483647;
    
    /**
     * Executions start here
     * 
     * @param args
     */
    public static void main(String[] args) {
        try {
            int keyLen = Cipher.getMaxAllowedKeyLength("AES");
            if (keyLen == JCE_UNLIMITED_STRENGTH) {
                System.out.printf("%d (unlimited)%n", keyLen);
            } else {
                System.out.printf("%d%n", keyLen);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
