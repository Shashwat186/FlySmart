package smart.fly.util;
 
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
 
public class PasswordUtilDemo {
 
    public static void main(String[] args) {
        PasswordUtil passwordUtil = new PasswordUtil();
        String password = "owner123"; // The password you want to hash
 
        // Step 1: Generate a random salt
        String salt = passwordUtil.generateSalt();
        
        // Step 2: Hash the password with the salt
        String hashedPassword = passwordUtil.hashPassword(password, salt);
 
        // Step 3: Print results (for database seeding)
        System.out.println("=== Password Hashing Demo ===");
        System.out.println("Password: " + password);
        System.out.println("Salt: " + salt);
        System.out.println("Hashed Password: " + hashedPassword);
 
        // Step 4: Verify the password (for testing)
        boolean isCorrect = passwordUtil.verifyPassword(password, hashedPassword, salt);
        System.out.println("Verification Result: " + isCorrect); // Should print "true"
    }
 
    static class PasswordUtil {
        public String generateSalt() {
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);
            return Base64.getEncoder().encodeToString(salt);
        }
 
        public String hashPassword(String password, String salt) {
            try {
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(Base64.getDecoder().decode(salt));
                byte[] hashedPassword = md.digest(password.getBytes());
                return Base64.getEncoder().encodeToString(hashedPassword);
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException("Error hashing password", e);
            }
        }
 
        public boolean verifyPassword(String inputPassword, String storedHash, String storedSalt) {
            String hashedInput = hashPassword(inputPassword, storedSalt);
            return hashedInput.equals(storedHash);
        }
    }
}