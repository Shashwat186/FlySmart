package smart.fly.user.repository;

import java.util.List;

import smart.fly.user.model.User;

public interface UserRepository {
	User findByEmail(String email);

	User findById(int userId);

	User save(User user);

	void update(User user);

	void delete(int userId);

	void changePassword(int userId, String newPasswordHash, String newSalt);

	boolean emailExists(String email);

	List<User> findAllByRole(String role);

	int countByRole(String role);

	void updateProfilePhoto(int userId, byte[] profilePhoto);

}