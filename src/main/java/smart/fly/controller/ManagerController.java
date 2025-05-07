package smart.fly.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import smart.fly.action.log.ActionLog;
import smart.fly.airline.model.Airline;
import smart.fly.airline.repository.AirlineRepository;
import smart.fly.airport.model.Airport;
import smart.fly.airport.repository.AirportRepository;
import smart.fly.flight.model.Flight;
import smart.fly.flight.repository.FlightRepository;
import smart.fly.flightmanager.model.FlightManager;
import smart.fly.flightmanager.repository.FlightManagerRepository;

import smart.fly.service.*;
import smart.fly.user.model.User;
import jakarta.servlet.http.HttpSession;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	private final FlightManagementService flightService;

	private final FlightManagerRepository flightManagerRepository;
	private final AirlineRepository airlineRepository;
	private final AirportRepository airportRepository;
	private final FlightRepository flightRepository;
	private final LoggingService loggingService;

	public ManagerController(FlightManagementService flightService, FlightManagerRepository flightManagerRepository,
			AirlineRepository airlineRepository, AirportRepository airportRepository, FlightRepository flightRepository,
			LoggingService loggingService) {
		super();
		this.flightService = flightService;

		this.flightManagerRepository = flightManagerRepository;
		this.airlineRepository = airlineRepository;
		this.airportRepository = airportRepository;
		this.flightRepository = flightRepository;
		this.loggingService = loggingService;
	}

	@GetMapping("/dashboard")
	public String showManagerDashboard(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");

		if (user == null) {
			System.out.println("ERROR: User is NULL in /owner/dashboard!");

			return "redirect:/auth/login";
		}
		int userId = user.getUserId();
		System.out.println("Dashboard - User ID from session: " + userId); // DEBUG
		List<ActionLog> actionLog = loggingService.getActionLogForOwner(userId);
		System.out.println("Action log from database: " + actionLog);
		model.addAttribute("actionLog", actionLog);
		int totalFlights = flightRepository.getTotalFlightsByUserId(userId);
		model.addAttribute("totalFlights", totalFlights);
		int scheduledFlights = flightRepository.getScheduledFlightsByUserId(userId);
		model.addAttribute("scheduledCount", scheduledFlights);
		int delayedFlights = flightRepository.getDelayedFlightsByUserId(userId);
		model.addAttribute("delayedCount", delayedFlights);
		return "manager/dashboard";
	}

	@GetMapping("/airports")
	public String listManagerAirports(Model model) {
		List<Airport> airports = airportRepository.findAll();
		model.addAttribute("airports", airports);
		return "manager/airports/list";
	}

	@GetMapping("/airlines")
	public String listManagerAirlines(Model model) {
		List<Airline> airlines = airlineRepository.findAll();
		model.addAttribute("airlines", airlines);
		return "manager/airlines/list";
	}

	

//	

	@GetMapping("/flights")
	public String listManagerFlights(HttpSession session, Model model) {
		// Get current manager
		User user = (User) session.getAttribute("user");
		FlightManager manager = flightManagerRepository.findByUserId(user.getUserId());

		// Get assigned flights
		List<Flight> flights = flightService.getFlightsByManager(manager.getFmId());
		model.addAttribute("flights", flights);
		List<String> statuses = Arrays.asList("SCHEDULED", "DELAYED", "CANCELLED", "COMPLETED");
		model.addAttribute("statuses", statuses);

		return "manager/flights/list";

	}

	@GetMapping("/airlines/edit/{id}")
	public String showEditAirlineForm(@PathVariable int id, Model model) {
		Airline airline = airlineRepository.findById(id);
		model.addAttribute("airline", airline);
		return "manager/airlines/edit";
	}

	@PostMapping("/airlines/edit/{id}")
	public String updateAirline(@PathVariable int id, @ModelAttribute Airline airline,
			RedirectAttributes redirectAttributes, HttpSession session, Model model) {
		try {
			airline.setAirlineId(id);
			airlineRepository.update(airline);
			User currentUser = (User) session.getAttribute("user");
			int UserId = currentUser.getUserId();
			redirectAttributes.addFlashAttribute("success", "Airline updated successfully");
			loggingService.logAction(UserId, "Airline Updated", "ManagerController");
		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate code error
			model.addAttribute("airline", airline); // Keep form data
			model.addAttribute("error",
					"The airline code '" + airline.getCode() + "' already exists. Please use a different code.");

			return "manager/airlines/edit"; // Return to the edit page with error
		} catch (Exception ex) {
			// Handle other potential errors
			model.addAttribute("airline", airline);
			model.addAttribute("error", "An error occurred while updating the airline. Please try again.");

			return "manager/ailines/edit";
		}
		return "redirect:/manager/airlines";
	}

	@PostMapping("/airlines/delete/{id}")
	public String deleteAirline(@PathVariable int id, RedirectAttributes redirectAttributes, HttpSession session) {
		airlineRepository.delete(id);

		redirectAttributes.addFlashAttribute("success", "Airline deleted successfully");

		return "redirect:/manager/airlines";
	}

	@GetMapping("/flights/edit/{id}")
	public String showEditFlightForm(@PathVariable int id, Model model, HttpSession session) {
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
		User currentUser = (User) session.getAttribute("user");
		int UserId = currentUser.getUserId();
		System.out.println(UserId);
		return "manager/flights/edit";
	}

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
			// Convert string dates to Timestamp
			Timestamp departureTimestamp = Timestamp.valueOf(departureDateTime.replace("T", " ") + ":00");
			Timestamp arrivalTimestamp = Timestamp.valueOf(arrivalDateTime.replace("T", " ") + ":00");

			flightService.updateFlight(id, flightNumber, airlineId, departureAirportId, arrivalAirportId,
					departureTimestamp, arrivalTimestamp, managerId, status);

			redirectAttributes.addFlashAttribute("success", "Flight updated successfully");
			loggingService.logAction(userId, "Updated flight: " + flightNumber, "AdminController");
			return "redirect:/manager/flights";

		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate flight number error
			loggingService.logAction(userId, "Failed to update flight - Duplicate flight number: " + flightNumber,
					"AdminController");

			// Populate the model for the form
			populateModelForEdit(model, id);

			// Add the user inputs back to the model
			model.addAttribute("flightNumber", flightNumber);
			model.addAttribute("airlineId", airlineId);
			model.addAttribute("departureAirportId", departureAirportId);
			model.addAttribute("arrivalAirportId", arrivalAirportId);
			model.addAttribute("departureDateTime", departureDateTime);
			model.addAttribute("arrivalDateTime", arrivalDateTime);
			model.addAttribute("managerId", managerId);
			model.addAttribute("status", status);

			model.addAttribute("error",
					"Flight number '" + flightNumber + "' already exists. Please use a different flight number.");

			// Return to the edit page instead of redirecting
			return "manager/flights/edit";

		} catch (Exception e) {
			loggingService.logAction(userId, "Failed to update flight: " + e.getMessage(), "AdminController");

			// Populate the model for the form
			populateModelForEdit(model, id);

			// Add the user inputs back to the model
			model.addAttribute("flightNumber", flightNumber);
			model.addAttribute("airlineId", airlineId);
			model.addAttribute("departureAirportId", departureAirportId);
			model.addAttribute("arrivalAirportId", arrivalAirportId);
			model.addAttribute("departureDateTime", departureDateTime);
			model.addAttribute("arrivalDateTime", arrivalDateTime);
			model.addAttribute("managerId", managerId);
			model.addAttribute("status", status);

			model.addAttribute("error", "Failed to update flight: " + e.getMessage());

			// Return to the edit page with error
			return "manager/flights/edi";
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

	// Airports management
	@GetMapping("/airports/edit/{id}")
	public String showEditAirportForm(@PathVariable int id, Model model, HttpSession session) {
		Airport airport = airportRepository.findById(id);
		model.addAttribute("airport", airport);

		return "manager/airports/edit";
	}

	@PostMapping("/airports/edit/{id}")
	public String updateAirport(@PathVariable int id, @ModelAttribute Airport airport,
			RedirectAttributes redirectAttributes, HttpSession session, Model model) {
		try {
			airport.setAirportId(id);
			airportRepository.update(airport);
			redirectAttributes.addFlashAttribute("success", "Airport updated successfully");
			User user = (User) session.getAttribute("user");
			int UserId = user.getUserId();
			loggingService.logAction(UserId, "Airport Updated", "ManagerController");
		} catch (org.springframework.dao.DuplicateKeyException ex) {
			// Handle duplicate code error
			model.addAttribute("airport", airport); // Keep form data
			model.addAttribute("error", "Duplicate Entries Exist");

			return "manager/airports/edit"; // Return to the edit page with error
		} catch (Exception ex) {
			// Handle other potential errors
			model.addAttribute("airline", airport);
			model.addAttribute("error", "An error occurred while updating the airline. Please try again.");

			return "manager/airports/edit";
		}
		return "redirect:/manager/airports";

	}

	@PostMapping("/airports/delete/{id}")
	public String deleteAirport(@PathVariable int id, RedirectAttributes redirectAttributes) {
		airportRepository.delete(id);
		redirectAttributes.addFlashAttribute("success", "Airport deleted successfully");
		return "redirect:/manager/airports";
	}

	@GetMapping("/flights/updateStatus/{flightId}")
	public String showUpdateStatusForm(@PathVariable int flightId, Model model) {
		Flight flight = flightRepository.findById(flightId);
		if (flight == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Flight not found");
		}
		model.addAttribute("flight", flight);
		List<String> statuses = Arrays.asList("SCHEDULED", "DELAYED", "CANCELLED", "ON_TIME", "COMPLETED");
		model.addAttribute("statuses", statuses); // Add statuses to the model
		return "manager/flights/updateStatus"; // Location of your JSP
	}

	@PostMapping("/flights/status/{flightId}")
	public ResponseEntity<String> updateFlightStatus(@PathVariable int flightId,
			@RequestParam("status") String status) {
		try {
			flightRepository.updateStatus(flightId, status);
			return ResponseEntity.ok("Status updated successfully.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update status.");
		}
	}
}