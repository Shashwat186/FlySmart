package smart.fly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import smart.fly.booking.model.Booking;
import smart.fly.booking.repository.BookingRepository;

import smart.fly.passenger.model.Passenger;
import smart.fly.service.BookingService;
import smart.fly.service.FeedbackService;
import smart.fly.service.PassengerService;
import smart.fly.service.UserService;
import smart.fly.user.model.User;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;

import java.util.List;

@Controller
@RequestMapping("/passenger")
public class PassengerController {
	private final PassengerService passengerService;
	private final BookingService bookingService;
	private final UserService userService;
	private final BookingRepository bookingRepository;
	private final FeedbackService feedbackService;

	public PassengerController(PassengerService passengerService, BookingService bookingService,
			UserService userService, BookingRepository bookingRepository, FeedbackService feedbackService) {
		super();
		this.passengerService = passengerService;
		this.bookingService = bookingService;
		this.userService = userService;
		this.bookingRepository = bookingRepository;
		this.feedbackService = feedbackService;
	}

	@GetMapping("/dashboard")
	public String showDashboard(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		User user1 = userService.getUserById(user.getUserId());
		model.addAttribute("passenger", user);
		return "passenger/dashboard";
	}

	@GetMapping("/bookings")
	public String showBookings(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/auth/login";
		}

		int userId = user.getUserId();
		ZoneId indiaZone = ZoneId.of("Asia/Kolkata");
		LocalDate todayIndia = LocalDate.now(indiaZone);
		LocalDateTime todayStart = LocalDateTime.of(todayIndia, LocalTime.MIN);
		List<Integer> bookingsWithFeedback = feedbackService.getBookingsWithFeedback(user.getUserId());
		List<Booking> upcomingBookings = bookingRepository.findUpcomingBookingsByUserId(userId, todayStart);
		List<Booking> previousBookings = bookingRepository.findPreviousBookingsByUserId(userId, todayStart);
		if (session.getAttribute("feedbackMessage") != null) {
			model.addAttribute("feedbackMessage", session.getAttribute("feedbackMessage"));
			session.removeAttribute("feedbackMessage");
		}

		if (session.getAttribute("feedbackError") != null) {
			model.addAttribute("feedbackError", session.getAttribute("feedbackError"));
			session.removeAttribute("feedbackError");
		}
		model.addAttribute("upcomingBookings", upcomingBookings);
		model.addAttribute("previousBookings", previousBookings);
		model.addAttribute("bookingsWithFeedback", bookingsWithFeedback);
		model.addAttribute("upcomingBookingsEmpty", upcomingBookings.isEmpty());
		model.addAttribute("previousBookingsEmpty", previousBookings.isEmpty());

		return "passenger/bookings";
	}

	@GetMapping("/bookings/{id}")
	public String viewBookingDetails(@PathVariable int id, Model model) {
		Booking booking = bookingService.getBookingById(id);
		model.addAttribute("booking", booking);
		return "passenger/booking-details";
	}

	@GetMapping("/cancel/{bookingId}")
	public String cancelBooking(@PathVariable("bookingId") int bookingId, HttpSession session,
			RedirectAttributes redirectAttributes) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/auth/login";
		}

		try {
			boolean cancellationSuccessful = bookingService.cancelBooking(bookingId, user.getUserId());
			if (cancellationSuccessful) {
				redirectAttributes.addFlashAttribute("message",
						"Booking ID " + bookingId + " has been cancelled successfully.");
			} else {
				redirectAttributes.addFlashAttribute("error",
						"Failed to cancel booking ID " + bookingId + ". Please try again.");
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error",
					"An error occurred while cancelling booking ID " + bookingId + ": " + e.getMessage());
			// Log the error for debugging
			e.printStackTrace();
		}

		return "redirect:/passenger/bookings";
	}

	@PostMapping("/submit-feedback")
	public String submitFeedback(@RequestParam int bookingId, @RequestParam int rating,
			@RequestParam String feedbackContent, HttpSession session) {

		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/auth/login";
		}

		boolean success = feedbackService.submitFeedback(user.getUserId(), bookingId, rating, feedbackContent);

		if (success) {
			session.setAttribute("feedbackMessage", "Feedback submitted successfully!");
		} else {
			session.setAttribute("feedbackError", "Failed to submit feedback.");
		}

		return "redirect:/passenger/bookings";
	}
}