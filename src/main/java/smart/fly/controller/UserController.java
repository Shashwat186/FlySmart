package smart.fly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import smart.fly.service.UserService;
import smart.fly.user.model.User;

import java.util.Base64;

@Controller
@RequestMapping("/passenger")
public class UserController {

	private final UserService userService;

	@Autowired
	public UserController(UserService userService) {
		this.userService = userService;
	}

	@GetMapping("/profile/{userId}")
	public String showProfile(@PathVariable int userId, Model model) {
		User user = userService.getUserById(userId);
		if (user == null) {
			
			model.addAttribute("error", "User not found");
			return "error"; 
		}

		
		model.addAttribute("user", user);

		
		if (user.getProfilePhoto() != null && user.getProfilePhoto().length > 0) {
			String profilePhotoBase64 = Base64.getEncoder().encodeToString(user.getProfilePhoto());
			model.addAttribute("profilePhotoBase64", profilePhotoBase64);
		}

		return "passenger/profile"; // Maps to profile.jsp
	}
}