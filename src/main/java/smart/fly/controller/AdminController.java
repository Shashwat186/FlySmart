package smart.fly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import smart.fly.airline.model.Airline;
import smart.fly.airline.repository.AirlineRepository;
import smart.fly.airport.model.Airport;
import smart.fly.airport.repository.AirportRepository;
import smart.fly.flight.add.repository.AddFlightRepository;
import smart.fly.flight.model.Flight;
import smart.fly.flight.repository.FlightRepository;
import smart.fly.flightmanager.model.FlightManager;
import smart.fly.flightmanager.repository.FlightManagerRepository;

import smart.fly.passenger.model.Passenger;
import smart.fly.service.*;
import smart.fly.user.model.User;
import jakarta.servlet.http.HttpSession;

import java.sql.Timestamp;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private final FlightManagementService flightService;
	private final FlightManagerRepository flightManagerRepository;
	private final PassengerService passengerService;
	private final AirlineRepository airlineRepository;
	private final AirportRepository airportRepository;
	private final FlightRepository flightRepository;
	private final LoggingService loggingService;
	private final AddFlightRepository addFlightRepository;

	public AdminController(FlightManagementService flightService, FlightManagerRepository flightManagerRepository,
			PassengerService passengerService, AirlineRepository airlineRepository, AirportRepository airportRepository,
			FlightRepository flightRepository, LoggingService loggingService, AddFlightRepository addFlightRepository) {
		super();
		this.flightService = flightService;
		this.flightManagerRepository = flightManagerRepository;
		this.passengerService = passengerService;
		this.airlineRepository = airlineRepository;
		this.airportRepository = airportRepository;
		this.flightRepository = flightRepository;
		this.loggingService = loggingService;

		this.addFlightRepository = addFlightRepository;
	}

	@GetMapping("/dashboard")
	public String showAdminDashboard(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if ("OWNER".equalsIgnoreCase(user.getRole())) {
			return "redirect:/owner/dashboard";
		}
		return "redirect:/auth/login";
	}

	@GetMapping("/flights")
	public String listFlights(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		System.out.println(user);
		List<Flight> flights;

		flights = flightService.getAllFlights();

		model.addAttribute("flights", flights);
		return "admin/flights/list";
	}

	@GetMapping("/flights/add")
	public String showAddFlightForm(Model model, @RequestParam(required = false) Boolean error) {
		model.addAttribute("airlines", airlineRepository.findAll());
		model.addAttribute("airports", airportRepository.findAll());
		model.addAttribute("managers", flightRepository.findAllFlightManagersWithUsers());

		if (error != null && error) {
			model.addAttribute("error", "Failed to add flight. Please check your inputs.");
		}

		return "admin/flights/add";
	}

	private Timestamp convertToTimestamp(String dateTimeStr) throws DateTimeParseException {
		// Assuming dateTimeStr is in format like "2025-04-10T14:30"
		LocalDateTime dateTime = LocalDateTime.parse(dateTimeStr, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
		return Timestamp.valueOf(dateTime);
	}

	@PostMapping("/flights/add")
	public String addFlight(@RequestParam("flightNumber") String flightNumber,
			@RequestParam("airlineId") Integer airlineId,
			@RequestParam("departureAirportId") Integer departureAirportId,
			@RequestParam("arrivalAirportId") Integer arrivalAirportId,
			@RequestParam("departureDateTime") String departureDateTimeStr,
			@RequestParam("arrivalDateTime") String arrivalDateTimeStr, @RequestParam("managerId") Integer managerId,
			@RequestParam("economyTotalSeats") int economyTotalSeats,
			@RequestParam("businessTotalSeats") int businessTotalSeats,
			@RequestParam("firstClassTotalSeats") int firstClassTotalSeats, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {

		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/add!");
			return "redirect:/auth/login";
		}
		int userId = user.getUserId();

		try {
			// Convert date strings to Timestamp
			Timestamp departureDateTime = convertToTimestamp(departureDateTimeStr);
			Timestamp arrivalDateTime = convertToTimestamp(arrivalDateTimeStr);

			Airline airline = airlineRepository.findById(airlineId);
			Airport departureAirport = airportRepository.findById(departureAirportId);
			Airport arrivalAirport = airportRepository.findById(arrivalAirportId);
			FlightManager flightManager = flightManagerRepository.findById(managerId);

			Flight flight = new Flight();
			flight.setFlightNumber(flightNumber);
			flight.setDepartureDateTime(departureDateTime);
			flight.setArrivalDateTime(arrivalDateTime);
			flight.setStatus("SCHEDULED");
			flight.setAirline(airline);
			flight.setDepartureAirport(departureAirport);
			flight.setArrivalAirport(arrivalAirport);

			// Insert flight using repository
			int flightId = addFlightRepository.addFlight(flightNumber, airline.getAirlineId(),
					departureAirport.getAirportId(), arrivalAirport.getAirportId(), departureDateTime, arrivalDateTime,
					flightManager.getFmId());

			System.out.println("Flight ID generated: " + flightId);

			// Insert flight seats using repository

			int economyInsert = addFlightRepository.addFlightSeats(flightId, 1, economyTotalSeats, 5000.0);
			System.out.println("Economy seats insert: " + economyInsert + " rows affected");

			int businessInsert = addFlightRepository.addFlightSeats(flightId, 2, businessTotalSeats, 12000.0);
			System.out.println("Business seats insert: " + businessInsert + " rows affected");

			int firstClassInsert = addFlightRepository.addFlightSeats(flightId, 3, firstClassTotalSeats, 25000.0);
			System.out.println("First Class seats insert: " + firstClassInsert + " rows affected");

			loggingService.logAction(userId, "Added flight", "AdminController");
			redirectAttributes.addFlashAttribute("success", "Flight added successfully");
			return "redirect:/admin/flights";

		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate flight number error
			loggingService.logAction(userId, "Failed to add flight - Duplicate flight number: " + flightNumber,
					"AdminController");

			// Populate the model for the form
			populateModelForAddFlight(model);

			// Add the user inputs back to the model so they don't have to re-enter
			// everything
			model.addAttribute("flightNumber", flightNumber);
			model.addAttribute("airlineId", airlineId);
			model.addAttribute("departureAirportId", departureAirportId);
			model.addAttribute("arrivalAirportId", arrivalAirportId);
			model.addAttribute("departureDateTime", departureDateTimeStr);
			model.addAttribute("arrivalDateTime", arrivalDateTimeStr);
			model.addAttribute("managerId", managerId);
			model.addAttribute("economyTotalSeats", economyTotalSeats);
			model.addAttribute("businessTotalSeats", businessTotalSeats);
			model.addAttribute("firstClassTotalSeats", firstClassTotalSeats);
			model.addAttribute("error",
					"Flight number '" + flightNumber + "' already exists. Please use a different flight number.");

			// Return to the add page instead of redirecting
			return "admin/flights/add";

		} catch (DateTimeParseException e) {
			System.err.println("Date parsing error: " + e.getMessage());

			// Populate the model for the form
			populateModelForAddFlight(model);

			// Add the user inputs back to the model
			model.addAttribute("flightNumber", flightNumber);
			model.addAttribute("airlineId", airlineId);
			model.addAttribute("departureAirportId", departureAirportId);
			model.addAttribute("arrivalAirportId", arrivalAirportId);
			model.addAttribute("managerId", managerId);
			model.addAttribute("economyTotalSeats", economyTotalSeats);
			model.addAttribute("businessTotalSeats", businessTotalSeats);
			model.addAttribute("firstClassTotalSeats", firstClassTotalSeats);
			model.addAttribute("error", "Invalid date format. Please ensure dates are in the correct format.");
			return "admin/flights/add";

		} catch (Exception e) {
			System.err.println("Error adding flight: " + e.getMessage());
			e.printStackTrace();

			// Populate the model for the form
			populateModelForAddFlight(model);

			model.addAttribute("flightNumber", flightNumber);
			model.addAttribute("airlineId", airlineId);
			model.addAttribute("departureAirportId", departureAirportId);
			model.addAttribute("arrivalAirportId", arrivalAirportId);
			model.addAttribute("departureDateTime", departureDateTimeStr);
			model.addAttribute("arrivalDateTime", arrivalDateTimeStr);
			model.addAttribute("managerId", managerId);
			model.addAttribute("economyTotalSeats", economyTotalSeats);
			model.addAttribute("businessTotalSeats", businessTotalSeats);
			model.addAttribute("firstClassTotalSeats", firstClassTotalSeats);
			model.addAttribute("error", "Failed to add flight: " + e.getMessage());
			return "admin/flights/add";
		}
	}

	// Helper method to populate the model for the add flight page
	private void populateModelForAddFlight(Model model) {
		try {
			model.addAttribute("airlines", airlineRepository.findAll());
		} catch (Exception e) {
			model.addAttribute("error", "Failed to load airlines: " + e.getMessage());
		}

		try {
			model.addAttribute("airports", airportRepository.findAll());
		} catch (Exception e) {
			model.addAttribute("error", "Failed to load airports: " + e.getMessage());
		}
		try {
			model.addAttribute("managers", flightManagerRepository.findAll());
		} catch (Exception e) {
			model.addAttribute("error", "Failed to load flight managers: " + e.getMessage());
		}

	}

	@GetMapping("/flights/edit/{id}")
	public String showEditFlightForm(@PathVariable int id, Model model) {
		Flight flight = flightService.getFlightById(id);
		model.addAttribute("flight", flight);
		model.addAttribute("airlines", airlineRepository.findAll());
		model.addAttribute("airports", airportRepository.findAll());
		model.addAttribute("managers", flightManagerRepository.findAll());
		model.addAttribute("statuses", Arrays.asList("Scheduled", "Delayed", "Cancelled", "Completed"));
		model.addAttribute("managerId", flight.getFlightManager() != null ? flight.getFlightManager().getFmId() : null);
		System.out.println("Flight ID: " + flight.getFlightId());
		System.out.println("Manager ID: " + flight.getFmId()); // Should print non-zero if exists
		System.out.println("Manager Object: " + flight.getFlightManager());
		return "admin/flights/edit";
	}

//   
	@PostMapping("/flights/edit/{id}")
	public String updateFlight(@PathVariable int id, @RequestParam String flightNumber, @RequestParam Integer airlineId,
			@RequestParam Integer departureAirportId, @RequestParam Integer arrivalAirportId,
			@RequestParam String departureDateTime, @RequestParam String arrivalDateTime,
			@RequestParam Integer managerId, @RequestParam String status, Model model,
			RedirectAttributes redirectAttributes, HttpSession session) {

		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/edit/{id}!");
			return "redirect:/auth/login";
		}

		int userId = user.getUserId();

		try {
			// Prepare the model first
			populateModelForEdit(model, id);

			// Convert string dates to Timestamp
			Timestamp departureTimestamp = Timestamp.valueOf(departureDateTime.replace("T", " ") + ":00");
			Timestamp arrivalTimestamp = Timestamp.valueOf(arrivalDateTime.replace("T", " ") + ":00");

			flightService.updateFlight(id, flightNumber, airlineId, departureAirportId, arrivalAirportId,
					departureTimestamp, arrivalTimestamp, managerId, status);

			redirectAttributes.addFlashAttribute("success", "Flight updated successfully");
			loggingService.logAction(userId, "Updated flight " + flightNumber, "AdminController");
			return "redirect:/admin/flights";

		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate flight number error
			loggingService.logAction(userId, "Failed to update flight - Duplicate flight number: " + flightNumber,
					"AdminController");

			// The model is already populated by the method at the beginning of try block
			model.addAttribute("error",
					"Flight number '" + flightNumber + "' already exists. Please use a different flight number.");

			// Return to the edit page instead of redirecting
			return "admin/flights/edit";

		} catch (Exception e) {
			loggingService.logAction(userId, "Failed to update flight: " + e.getMessage(), "AdminController");

			// The model is already populated by the method at the beginning of try block
			model.addAttribute("error", "Failed to update flight: " + e.getMessage());

			// Return to the edit page with error
			return "admin/flights/edit";
		}
	}

	// Helper method to populate the model for the edit page
	private void populateModelForEdit(Model model, int flightId) {
		try {
			model.addAttribute("flight", flightService.getFlightById(flightId));
		} catch (Exception e) {
			model.addAttribute("error", "Failed to load flight data: " + e.getMessage());
		}

		try {
			model.addAttribute("airlines", airlineRepository.findAll());
		} catch (Exception e) {
			model.addAttribute("error", "Failed to load airlines: " + e.getMessage());
		}

		try {
			model.addAttribute("airports", airportRepository.findAll());
		} catch (Exception e) {
			model.addAttribute("error", "Failed to load airports: " + e.getMessage());
		}
		try {
			model.addAttribute("managers", flightManagerRepository.findAll());
		} catch (Exception e) {
			model.addAttribute("error", "Failed to load flight managers: " + e.getMessage());
		}

	}

	private Timestamp parseDateTime(String dateTimeStr) throws DateTimeParseException {
		// Handle both "yyyy-MM-dd HH:mm" and "yyyy-MM-dd'T'HH:mm" formats
		String normalized = dateTimeStr.replace("T", " ");
		LocalDateTime localDateTime = LocalDateTime.parse(normalized, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		return Timestamp.valueOf(localDateTime);
	}

	@PostMapping("/flights/delete/{id}")
	public String deleteFlight(@PathVariable int id, HttpSession session) {

		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/delete/{id}!");
			return "redirect:/auth/login";
		}
		int userId = user.getUserId();
		flightService.deleteFlight(id);
		loggingService.logAction(userId, "Deleted flight", "AdminController");
		return "redirect:/admin/flights";
	}

	@GetMapping("/airports")
	public String listAirports(Model model) {
		List<Airport> airports = airportRepository.findAll();
		model.addAttribute("airports", airports);
		return "admin/airports/list";
	}

	@GetMapping("/airports/add")
	public String showAddAirportForm(Model model) {
		model.addAttribute("airport", new Airport());
		return "admin/airports/add";
	}

	@PostMapping("/airports/add")
	public String addAirport(@ModelAttribute Airport airport, RedirectAttributes redirectAttributes,
	                          HttpSession session, Model model) {
	    User user = (User) session.getAttribute("user");
	    if (user == null) {
	        System.out.println("ERROR: User is NULL in /admin/flights/delete/{id}!");
	        return "redirect:/auth/login"; // Handle appropriately
	    }
	    
	    try {
	        airportRepository.save(airport);
	        redirectAttributes.addFlashAttribute("success", "Airport added successfully");
	        int userId = user.getUserId();
	        loggingService.logAction(userId, "Added Airport ", "AdminController");
	        return "redirect:/admin/airports";
	    } catch (org.springframework.dao.DuplicateKeyException ex) {
	        // Handle duplicate code error
	        model.addAttribute("airport", airport); // Keep form data
	        model.addAttribute("error", "Duplicate entries exist");
	        int userId = user.getUserId();
	        System.out.println(userId);
	        return "admin/airports/add"; // Return to the add page with error
	    } catch (Exception ex) {
	        // Handle other potential errors
	        model.addAttribute("airport", airport); // Fixed this to be "airport" instead of "airline"
	        model.addAttribute("error", "An error occurred while updating the airport. Please try again.");
	        return "admin/airports/add";
	    }
	}

	@GetMapping("/airports/edit/{id}")
	public String showEditAirportForm(@PathVariable int id, Model model) {
		Airport airport = airportRepository.findById(id);
		model.addAttribute("airport", airport);
		return "admin/airports/edit";
	}

	@PostMapping("/airports/edit/{id}")
	public String updateAirport(@PathVariable int id, @ModelAttribute Airport airport,
			RedirectAttributes redirectAttributes, HttpSession session, Model model) {

		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/delete/{id}!");
			return "redirect:/auth/login"; // Handle appropriately
		}
		try {
			redirectAttributes.addFlashAttribute("success", "Airport added successfully");
			int userId = user.getUserId();
			airport.setAirportId(id);
			airportRepository.update(airport);
			loggingService.logAction(userId, "Edited Airport ", "AdminController");
			redirectAttributes.addFlashAttribute("success", "Airport updated successfully");
			return "redirect:/admin/airports";
		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate code error
			model.addAttribute("airport", airport); // Keep form data
			model.addAttribute("error", "Duplicate entries exist"); // Log the error attempt
			int userId = user.getUserId();
			System.out.println(userId);
			return "admin/airports/edit"; // Return to the edit page with error
		} catch (Exception ex) {
			// Handle other potential errors
			model.addAttribute("airport", airport); // Consider changing this to "airport" for consistency
			model.addAttribute("error", "An error occurred while updating the airport. Please try again.");
			return "admin/airports/edit";
		}
	}

	@PostMapping("/airports/delete/{id}")
	public String deleteAirport(@PathVariable int id, RedirectAttributes redirectAttributes, HttpSession session) {
		airportRepository.delete(id);
		redirectAttributes.addFlashAttribute("success", "Airport deleted successfully");
		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/delete/{id}!");
			return "redirect:/auth/login"; // Handle appropriately
		}
		int userId = user.getUserId();

		loggingService.logAction(userId, "Deleted Airport ", "AdminController");
		return "redirect:/admin/airports";
	}

	@GetMapping("/airlines")
	public String listAirlines(Model model) {
		List<Airline> airlines = airlineRepository.findAll();
		model.addAttribute("airlines", airlines);
		return "admin/airlines/list";
	}

	@GetMapping("/passengers")
	public String listPassengers(Model model) {
		List<Passenger> passengers = passengerService.getAllPassengers();
		model.addAttribute("passengers", passengers);
		return "admin/passengers/list";
	}

	@GetMapping("/airlines/add")
	public String showAddAirlineForm(Model model) {
		model.addAttribute("airline", new Airline());
		return "admin/airlines/add";
	}

	@PostMapping("/airlines/add")
	public String addAirline(@ModelAttribute Airline airline, RedirectAttributes redirectAttributes,
			HttpSession session, Model model) {

		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/delete/{id}!");
			return "redirect:/auth/login"; // Handle appropriately
		}
		try {
			int userId = user.getUserId();
			loggingService.logAction(userId, "Added Airline ", "AdminController");
			airlineRepository.save(airline);
			redirectAttributes.addFlashAttribute("success", "Airline added successfully");
			return "redirect:/admin/airlines";
		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate code error
			model.addAttribute("airline", airline); // Keep form data
			model.addAttribute("error",
					"The airline code '" + airline.getCode() + "' already exists. Please use a different code.");

			// Log the error attempt
			int userId = user.getUserId();
			System.out.println(userId);

			return "admin/airlines/add"; // Return to the edit page with error
		} catch (Exception ex) {
			// Handle other potential errors
			model.addAttribute("airline", airline);
			model.addAttribute("error", "An error occurred while updating the airline. Please try again.");

			return "admin/airlines/add";
		}

	}

	@GetMapping("/airlines/edit/{id}")
	public String showEditAirlineForm(@PathVariable int id, Model model, HttpSession session) {
		Airline airline = airlineRepository.findById(id);
		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/delete/{id}!");
			return "redirect:/auth/login"; // Handle appropriately
		}

		int userId = user.getUserId();
		loggingService.logAction(userId, "Added Airline ", "AdminController");
		model.addAttribute("airline", airline);

		return "admin/airlines/edit";
	}

	@PostMapping("/airlines/edit/{id}")
	public String updateAirline(@PathVariable int id, @ModelAttribute Airline airline, Model model,
			RedirectAttributes redirectAttributes, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/auth/login";
		}

		try {
			airline.setAirlineId(id);
			airlineRepository.update(airline);

			int userId = user.getUserId();
			loggingService.logAction(userId, "Updated Airline", "AdminController");

			redirectAttributes.addFlashAttribute("success", "Airline updated successfully");
			return "redirect:/admin/airlines";
		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate code error
			model.addAttribute("airline", airline); // Keep form data
			model.addAttribute("error",
					"The airline code '" + airline.getCode() + "' already exists. Please use a different code.");

			// Log the error attempt
			int userId = user.getUserId();
			System.out.println(userId);

			return "admin/airlines/edit"; // Return to the edit page with error
		} catch (Exception ex) {
			// Handle other potential errors
			model.addAttribute("airline", airline);
			model.addAttribute("error", "An error occurred while updating the airline. Please try again.");

			return "admin/ailines/edit";
		}
	}

	@PostMapping("/airlines/delete/{id}")
	public String deleteAirline(@PathVariable int id, RedirectAttributes redirectAttributes, HttpSession session) {
		airlineRepository.delete(id);
		redirectAttributes.addFlashAttribute("success", "Airline deleted successfully");
		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("ERROR: User is NULL in /admin/flights/delete/{id}!");
			return "redirect:/auth/login"; // Handle appropriately
		}
		redirectAttributes.addFlashAttribute("success", "Airport added successfully");
		int userId = user.getUserId();
		loggingService.logAction(userId, "Deleted Airline ", "AdminController");
		return "redirect:/admin/airlines";
	}

}