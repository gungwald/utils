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
                System.out.println(keyLen + " (unlimited)");
            } else {
                System.out.println(keyLen);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
