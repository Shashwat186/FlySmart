package smart.fly.service;

import org.springframework.stereotype.Service;
import smart.fly.exception.AuthenticationException;
import smart.fly.user.model.User;
import smart.fly.user.repository.UserRepository;
import smart.fly.util.PasswordUtil;

import java.util.List;

@Service
public class UserService {
	private final UserRepository userRepository;

	public UserService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	public User getUserById(int userId) {
		return userRepository.findById(userId);
	}

	public List<User> getUsersByRole(String role) {
		return userRepository.findAllByRole(role);
	}

	public void deleteUser(int userId) {
		userRepository.delete(userId);
	}

}