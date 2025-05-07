
package smart.fly.util;

public class ValidationUtil {
	public static void validateEmail(String email) {
		if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
			throw new IllegalArgumentException("Invalid email format");
		}
	}

	public static void validatePhone(String phone) {
		if (phone == null || !phone.matches("^\\+?[0-9]{10,15}$")) {
			throw new IllegalArgumentException("Invalid phone number");
		}
	}
}
