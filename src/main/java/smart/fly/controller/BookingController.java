package smart.fly.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import smart.fly.seatclass.model.SeatClass;
import smart.fly.seatclass.repository.SeatClassRepository;
import smart.fly.service.*;
import smart.fly.user.model.User;
import smart.fly.adult.model.Adult;
import smart.fly.airport.model.Airport;
import smart.fly.airport.repository.AirportRepository;
import smart.fly.child.model.Child;
import smart.fly.dto.BookingRequestDTO;
import smart.fly.dto.FlightSearchDTO;
import smart.fly.flight.model.Flight;
import smart.fly.flight.repository.FlightRepository;
import smart.fly.flight.search.repository.FlightSearchRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

@Controller
@RequestMapping("/booking")
public class BookingController {
	private final BookingService bookingService;
	private final AirportRepository airportRepository;
	private final FlightRepository flightRepository;
	private static final Logger logger = LoggerFactory.getLogger(BookingController.class);
	private final SeatClassRepository seatClassRepository;
	private final UserService userService;
	private DataSource dataSource;
	private final FlightSearchRepository flightSearchRepository;

	public BookingController(BookingService bookingService, FlightManagementService flightService,
			PassengerService passengerService, AirportRepository airportRepository, FlightRepository flightRepository,
			SeatClassRepository seatClassRepository, UserService userService, DataSource dataSource,
			JdbcTemplate jdbcTemplate, FlightSearchRepository flightSearchRepository) {
		super();
		this.bookingService = bookingService;
		this.airportRepository = airportRepository;
		this.flightRepository = flightRepository;
		this.seatClassRepository = seatClassRepository;
		this.userService = userService;
		this.dataSource = dataSource;
		this.flightSearchRepository = flightSearchRepository;
	}
	@GetMapping("/search")
	public String searchFlights(@RequestParam(required = false) Integer from,
			@RequestParam(required = false) Integer to, @RequestParam(required = false) Integer seatClass,
			@RequestParam(defaultValue = "1") Integer adults, @RequestParam(defaultValue = "0") Integer children,
			HttpServletRequest request, Model model) {

		String dateStr = request.getParameter("date");
		logger.info("Search initiated - From: {}, To: {}, Date: {}, Seat Class: {}, Adults: {}, Children: {}", from, to,
				dateStr, seatClass, adults, children);

		try {

			List<Airport> airports = airportRepository.findAllForSearch();

			logger.info("Loaded {} airports directly", airports.size());
			model.addAttribute("airports", airports);

			List<SeatClass> seatClasses = seatClassRepository.findAll();
			logger.info("Loaded {} seat classes directly", seatClasses.size());
			model.addAttribute("seatClasses", seatClasses);

			// Add current date for datepicker
			model.addAttribute("currentDate", LocalDate.now().toString());

			if (from != null && to != null) {
				// Parse date
				LocalDate parsedDate = (dateStr == null || dateStr.isEmpty()) ? LocalDate.now()
						: LocalDate.parse(dateStr, DateTimeFormatter.ISO_DATE);
				java.sql.Date searchDate = java.sql.Date.valueOf(parsedDate);

				List<FlightSearchDTO> allFlights = flightSearchRepository.searchFlights(from, to, searchDate, seatClass,
						adults + children);
				logger.info("Found {} flights matching search criteria", allFlights.size());
				model.addAttribute("flights", allFlights);

				// Add search parameters to model for form persistence
				Map<String, Object> searchParams = new HashMap<>();
				searchParams.put("from", from);
				searchParams.put("to", to);
				searchParams.put("date", dateStr);
				searchParams.put("seatClass", seatClass);
				searchParams.put("adults", adults);
				searchParams.put("children", children);
				model.addAttribute("searchParams", searchParams);
			}

		} catch (DateTimeParseException e) {
			String error = "Invalid date format. Please use YYYY-MM-DD format.";
			
			model.addAttribute("error", error);
		} catch (IllegalArgumentException e) {
			
			model.addAttribute("error", e.getMessage());
		} catch (Exception e) {
			String rootCause = (e.getCause() != null) ? e.getCause().getMessage() : e.getMessage();
			String error = "Search failed: " + rootCause;
			
			model.addAttribute("error", error);
		}

		return "booking/search";
	}

	@GetMapping("/new")
	public String showBookingForm(@RequestParam int flightId, @RequestParam(required = false) Integer seatClassId,
			@RequestParam(defaultValue = "1") Integer adults, @RequestParam(defaultValue = "0") Integer children,
			Model model, HttpSession session) {
		logger.info("Displaying booking form for flight ID: {}", flightId);

		// Fetch the flight details
		Flight flight = flightRepository.findById(flightId);
		if (flight == null) {
			model.addAttribute("error", "Flight not found.");
			return "error";
		}
		model.addAttribute("flight", flight);

		// Get logged-in user (if any)
		User user = (User) session.getAttribute("user");
		User loggedInPassenger = null;
		if (user != null) {
			loggedInPassenger = userService.getUserById(user.getUserId());
			model.addAttribute("loggedInPassenger", loggedInPassenger);
		}

		// Create a new BookingRequestDTO
		BookingRequestDTO bookingRequest = new BookingRequestDTO();
		bookingRequest.setFlightId(flightId);
		bookingRequest.setNumberOfAdults(adults);
		bookingRequest.setNumberOfChildren(children);
		model.addAttribute("bookingRequest", bookingRequest);

		List<SeatClass> allSeatClasses = seatClassRepository.findAll();
		// Fetch all seat classes for the dropdown
		List<SeatClass> availableSeatClasses = seatClassRepository.findByFlightIdWithAvailableSeats(flightId);
		// In the flight form, The seat classes which have the available for that
		// particular seat class is greater than 0 will shown.
		Map<Integer, Integer> availableSeats = new HashMap<>();

		for (SeatClass seatClass : allSeatClasses) {
			// to get available seats for a flight and seat class
			Integer available = seatClassRepository.getAvailableSeatsForFlightSeatClass(flightId,
					seatClass.getSeatClassId());
			if (available != null) {
				availableSeats.put(seatClass.getSeatClassId(), available);
			} else {
				availableSeats.put(seatClass.getSeatClassId(), 0); // Default to 0 if no record
			}
		}
		model.addAttribute("seatClasses", availableSeatClasses);
		model.addAttribute("availableSeats", availableSeats);
		model.addAttribute("selectedSeatClassId", seatClassId); // Pass selected seat class ID if available

		System.out.println("Selected Seat Class ID: " + seatClassId);
		System.out.println("Number of Adults from Search: " + adults);
		System.out.println("Number of Children from Search: " + children);

		return "booking/form";
	}


	



	@PostMapping("/payment")
	public ModelAndView showPaymentPage(@RequestParam("flightId") int flightId,
			@RequestParam("seatClassId") int seatClassId, @RequestParam("numberOfAdults") int numberOfAdults,
			@RequestParam("numberOfChildren") int numberOfChildren, @RequestParam("price") String totalPriceStr, // Receive
																													// as
																													// String
			HttpServletRequest request, HttpSession session) {

		List<Adult> adults = new ArrayList<>();
		String leadAdultName = request.getParameter("adults[0].name");
		String leadAdultEmail = request.getParameter("adults[0].email");
		if (leadAdultName != null && !leadAdultName.isEmpty()) {
			adults.add(new Adult(leadAdultName, leadAdultEmail));
		}
		for (int i = 1; i < numberOfAdults; i++) {
			String name = request.getParameter("adults[" + i + "].name");
			String email = request.getParameter("adults[" + i + "].email");
			if (name != null && !name.isEmpty()) {
				adults.add(new Adult(name, email));
			}
		}
		session.setAttribute("adults", adults);

		List<Child> children = new ArrayList<>();
		for (int i = 0; i < numberOfChildren; i++) {
			String name = request.getParameter("children[" + i + "].name");
			String ageStr = request.getParameter("children[" + i + "].age");
			if (name != null && !name.isEmpty() && ageStr != null && !ageStr.isEmpty()) {
				children.add(new Child(name, Integer.parseInt(ageStr)));
			}
		}
		session.setAttribute("children", children);

		double totalPrice = 0.0;
		if (totalPriceStr != null && !totalPriceStr.isEmpty()) {
			try {
				totalPrice = Double.parseDouble(totalPriceStr);
			} catch (NumberFormatException e) {

				System.err.println("Error parsing totalPrice: " + totalPriceStr + " - " + e.getMessage());

			}
		}
		System.out.println("DEBUG: Adults in session:");
		for (int i = 0; i < adults.size(); i++) {
			System.out.println("DEBUG: Adult " + i + " - Name: " + adults.get(i).getName() + ", Email: "
					+ adults.get(i).getEmail());
		}

		System.out.println("DEBUG: Children in session:");
		for (int i = 0; i < children.size(); i++) {
			System.out.println("DEBUG: Child " + i + " - Name: " + children.get(i).getName() + ", Age: "
					+ children.get(i).getAge());
		}

		// Store data in session
		session.setAttribute("flightId", flightId);
		session.setAttribute("seatClassId", seatClassId);
		session.setAttribute("numberOfAdults", numberOfAdults);
		session.setAttribute("numberOfChildren", numberOfChildren);
		session.setAttribute("adults", adults);
		session.setAttribute("children", children);
		session.setAttribute("totalPrice", totalPrice); // Store the parsed double value

		return new ModelAndView("payment");
	}

	// Helper method to check if email is registered
	private boolean checkRegistrationStatus(String email) throws SQLException {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			connection = dataSource.getConnection();
			String sql = "SELECT User_ID FROM user WHERE email = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			return rs.next();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
				}
		}
	}

}
