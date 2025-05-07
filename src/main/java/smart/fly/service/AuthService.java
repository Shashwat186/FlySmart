package smart.fly.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import smart.fly.exception.AuthenticationException;
import smart.fly.passenger.model.Passenger;
import smart.fly.user.model.User;
import smart.fly.user.repository.UserRepository;
import smart.fly.util.PasswordUtil;

@Service
@Transactional
public class AuthService {
	private final UserRepository userRepository;
	private final PasswordUtil passwordUtil;
	private final PassengerService passengerService;
	private final DataSource dataSource;

	public AuthService(UserRepository userRepository, PasswordUtil passwordUtil, PassengerService passengerService,
			DataSource dataSource) {
		super();
		this.userRepository = userRepository;
		this.passwordUtil = passwordUtil;
		this.passengerService = passengerService;
		this.dataSource = dataSource;
	}

	public void changePassword(User user, String currentPassword, String newPassword) throws AuthenticationException {
		// Verify current password
		boolean passwordValid = passwordUtil.verifyPassword(currentPassword, user.getPasswordHash(),
				user.getPasswordSalt());

		if (!passwordValid) {

			throw new AuthenticationException("Current password is incorrect");
		}

		// Generate new password hash
		String salt = passwordUtil.generateSalt();
		String passwordHash = passwordUtil.hashPassword(newPassword, salt);

		// Update user's password information in database using JDBC
		try (Connection conn = dataSource.getConnection();
				PreparedStatement stmt = conn
						.prepareStatement("UPDATE user SET password_hash = ?, password_salt = ? WHERE User_Id = ?")) {

			stmt.setString(1, passwordHash);
			stmt.setString(2, salt);
			stmt.setLong(3, user.getUserId());

			int rowsAffected = stmt.executeUpdate();
			if (rowsAffected == 0) {
				throw new AuthenticationException("Failed to update password");
			}

			// Update the user object as well
			user.setPasswordHash(passwordHash);
			user.setPasswordSalt(salt);

		} catch (SQLException e) {

			throw new AuthenticationException("System error occurred while changing password");
		}
	}

	public User registerUser(User user, String password) {
		// Hash the password before saving the user
		String salt = passwordUtil.generateSalt();
		String passwordHash = passwordUtil.hashPassword(password, salt);
		user.setPasswordHash(passwordHash);
		user.setPasswordSalt(salt);
		// Save the user in the database
		return userRepository.save(user);
	}

	public User authenticate(String email, String password) throws AuthenticationException {

		User user = userRepository.findByEmail(email.trim().toLowerCase());
		if (user == null) {

			throw new AuthenticationException("Invalid email or password");
		}

		boolean passwordValid = passwordUtil.verifyPassword(password, user.getPasswordHash(), user.getPasswordSalt());
		if (!passwordValid) {

			throw new AuthenticationException("Invalid email or password");
		}
		return user;
	}

	public User debugAuth() {
		User testUser = new User();
		testUser.setEmail("debug@example.com");
		testUser.setPasswordHash(passwordUtil.hashPassword("debug123", "staticSalt"));
		testUser.setPasswordSalt("staticSalt");
		testUser.setRole("PASSENGER");
		return testUser;
	}
	

}
