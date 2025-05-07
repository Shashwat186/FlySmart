package smart.fly.service;

import org.springframework.jdbc.support.KeyHolder;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.sql.DataSource;
import smart.fly.airline.model.Airline;
import smart.fly.airline.repository.AirlineRepository;
import smart.fly.airport.model.Airport;
import smart.fly.airport.repository.AirportRepository;
import smart.fly.businness.owner.model.BusinessOwner;
import smart.fly.dto.FlightFormDTO;
import smart.fly.exception.FlightManagementException;
import smart.fly.flight.model.Flight;
import smart.fly.flight.repository.FlightRepository;
import smart.fly.flight.seats.model.FlightSeats;
import smart.fly.flight.seats.repository.FlightSeatsRepository;
import smart.fly.flightmanager.model.FlightManager;
import smart.fly.flightmanager.repository.FlightManagerRepository;

import smart.fly.seatclass.repository.SeatClassRepository;
import smart.fly.user.model.User;
import smart.fly.user.repository.UserRepository;
import smart.fly.util.PasswordUtil;

import java.sql.PreparedStatement;

import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import java.util.List;

@Service
public class FlightManagementService {
	private final FlightRepository flightRepository;
	private final FlightManagerRepository flightManagerRepository;
	private final ApplicationEventPublisher eventPublisher;
	private final AirlineRepository airlineRepository;
	private final AirportRepository airportRepository;
	private final JdbcTemplate jdbcTemplate;
	private final UserRepository userRepository;
	private final PasswordUtil passwordUtil;
	private final FlightSeatsRepository flightSeatRepository;
	private final SeatClassRepository seatClassRepository;
	private final DataSource dataSource;

	public FlightManagementService(FlightRepository flightRepository, FlightManagerRepository flightManagerRepository,
			ApplicationEventPublisher eventPublisher, AirlineRepository airlineRepository,
			AirportRepository airportRepository, JdbcTemplate jdbcTemplate, UserRepository userRepository,
			PasswordUtil passwordUtil, FlightSeatsRepository flightSeatRepository,
			SeatClassRepository seatClassRepository, DataSource dataSource) {
		super();
		this.flightRepository = flightRepository;
		this.flightManagerRepository = flightManagerRepository;
		this.eventPublisher = eventPublisher;
		this.airlineRepository = airlineRepository;
		this.airportRepository = airportRepository;
		this.jdbcTemplate = jdbcTemplate;
		this.userRepository = userRepository;
		this.passwordUtil = passwordUtil;
		this.flightSeatRepository = flightSeatRepository;
		this.seatClassRepository = seatClassRepository;
		this.dataSource = dataSource;
	}

	// Get all flights
	public List<Flight> getAllFlights() {
		return flightRepository.findAll();
	}

	// get flights by manager ID
	public List<Flight> getFlightsByManager(int managerId) {
		return flightRepository.findByManagerId(managerId);
	}

	// get flight by ID
	public Flight getFlightById(int flightId) {
		return flightRepository.findById(flightId);
	}

	// add a new flight
	@Transactional
	public void addFlight(Flight flight, Integer airlineId, Integer departureAirportId, Integer arrivalAirportId,
			Integer managerId, Integer userId) {

		// validate IDs
		if (airlineId == null || departureAirportId == null || arrivalAirportId == null || managerId == null) {
			throw new FlightManagementException("All required IDs must be provided");
		}

		
		Airline airline = airlineRepository.findById(airlineId);
		Airport departureAirport = airportRepository.findById(departureAirportId);
		Airport arrivalAirport = airportRepository.findById(arrivalAirportId);
		FlightManager manager = flightManagerRepository.findById(managerId);

		if (airline == null || departureAirport == null || arrivalAirport == null || manager == null) {
			throw new FlightManagementException("Invalid reference data provided");
		}

		
		if (flight.getArrivalDateTime().before(flight.getDepartureDateTime())) {
			throw new FlightManagementException("Arrival time must be after departure time");
		}

		// Set relationships
		flight.setAirline(airline);
		flight.setDepartureAirport(departureAirport);
		flight.setArrivalAirport(arrivalAirport);
		flight.setFlightManager(manager);

		// Save the flight
		flightRepository.save(flight);
	}

	@Transactional
	public void updateFlightFromDTO(int flightId, FlightFormDTO flightForm) {
		// Fetch the existing flight
		Flight existingFlight = flightRepository.findById(flightId);
		if (existingFlight == null) {
			throw new RuntimeException("Flight not found");
		}

		// Convert String dates to Timestamp
		LocalDateTime departureDateTime = LocalDateTime.parse(flightForm.getDepartureDateTime());
		LocalDateTime arrivalDateTime = LocalDateTime.parse(flightForm.getArrivalDateTime());

		// Update basic fields
		existingFlight.setFlightNumber(flightForm.getFlightNumber());
		existingFlight.setDepartureDateTime(Timestamp.valueOf(departureDateTime));
		existingFlight.setArrivalDateTime(Timestamp.valueOf(arrivalDateTime));

		
		Airline airline = airlineRepository.findById(flightForm.getAirlineId());
		if (airline == null) {
			throw new RuntimeException("Airline not found");
		}

		Airport departureAirport = airportRepository.findById(flightForm.getDepartureAirportId());
		if (departureAirport == null) {
			throw new RuntimeException("Departure airport not found");
		}

		Airport arrivalAirport = airportRepository.findById(flightForm.getArrivalAirportId());
		if (arrivalAirport == null) {
			throw new RuntimeException("Arrival airport not found");
		}

		FlightManager manager = flightManagerRepository.findById(flightForm.getManagerId());
		if (manager == null) {
			throw new RuntimeException("Manager not found");
		}

		
		existingFlight.setAirline(airline);
		existingFlight.setDepartureAirport(departureAirport);
		existingFlight.setArrivalAirport(arrivalAirport);
		existingFlight.setFlightManager(manager);

		// Save updated flight
		flightRepository.update(existingFlight);
	}

	// Update an existing flight
	@Transactional
	public void updateFlight(int flightId, String flightNumber, Integer airlineId, Integer departureAirportId,
			Integer arrivalAirportId, Timestamp departureDateTime, Timestamp arrivalDateTime, Integer managerId,
			String status) {

		String sql = "UPDATE flight SET " + "flight_number = ?, " + "airline_id = ?, " + "departure_airport_id = ?, "
				+ "arrival_airport_id = ?, " + "departure_date_time = ?, " + "arrival_date_time = ?, " + "fm_id = ?, "
				+ "status = ? " + "WHERE flight_id = ?";

		jdbcTemplate.update(sql, flightNumber, airlineId, departureAirportId, arrivalAirportId, departureDateTime,
				arrivalDateTime, managerId, status, flightId);
	}

	// Delete a flight
	@Transactional
	public void deleteFlight(int flightId) throws FlightManagementException {
		try {
			Flight flight = flightRepository.findById(flightId);
			if (flight == null) {
				throw new FlightManagementException("Flight not found");
			}

			flightRepository.delete(flightId);
		} catch (Exception e) {
			throw new FlightManagementException("Failed to delete flight: " + e.getMessage());
		}
	}

	// Update flight status (existing method)
	@Transactional
	public void updateFlightStatus(int flightId, String newStatus) {
		Flight flight = flightRepository.findById(flightId);
		String oldStatus = flight.getStatus();
		flight.setStatus(newStatus);
		flightRepository.update(flight);


	}

	

	public FlightManager createFlightManager(User user, String password, BusinessOwner owner) {
		// Validate email
		if (userRepository.emailExists(user.getEmail())) {
			throw new RuntimeException("Email already exists");
		}

		// Hash password
		String salt = passwordUtil.generateSalt();
		String hashedPassword = passwordUtil.hashPassword(password, salt);
		user.setPasswordHash(hashedPassword);
		user.setPasswordSalt(salt);
		user.setRole("Manager");

		// Save user
		User savedUser = userRepository.save(user);

		// Create flight manager record
		FlightManager flightManager = new FlightManager();
		flightManager.setUser(savedUser);
		flightManager.setBusinessOwner(owner);
		return flightManagerRepository.save(flightManager);
	}

	@Transactional
	public void addFlightWithSeats(Flight flight, int airlineId, int departureAirportId, int arrivalAirportId,
			int managerId, int userId, int economyTotalSeats, int businessTotalSeats, int firstClassTotalSeats) {

		try {
			
			Airline airline = airlineRepository.findById(airlineId);
			Airport departureAirport = airportRepository.findById(departureAirportId);
			Airport arrivalAirport = airportRepository.findById(arrivalAirportId);
			FlightManager flightManager = flightManagerRepository.findById(managerId);

			// Set flight properties
			flight.setAirline(airline);
			flight.setDepartureAirport(departureAirport);
			flight.setArrivalAirport(arrivalAirport);

			// Insert flight and get generated ID
			KeyHolder keyHolder = new GeneratedKeyHolder();
			int flightInsertResult = jdbcTemplate.update(connection -> {
				PreparedStatement ps = connection.prepareStatement(
						"INSERT INTO Flight (flight_number, Airline_Id, Departure_Airport_Id, Arrival_Airport_Id, "
								+ "Departure_Date_Time, Arrival_Date_Time, Status, fm_id) "
								+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
						Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, flight.getFlightNumber());
				ps.setInt(2, airline.getAirlineId());
				ps.setInt(3, departureAirport.getAirportId());
				ps.setInt(4, arrivalAirport.getAirportId());
				ps.setTimestamp(5, flight.getDepartureDateTime());
				ps.setTimestamp(6, flight.getArrivalDateTime());
				ps.setString(7, flight.getStatus());
				ps.setInt(8, flightManager.getFmId());
				return ps;
			}, keyHolder);

			System.out.println("Flight insert result: " + flightInsertResult);

			Number generatedFlightId = keyHolder.getKey();
			if (generatedFlightId == null) {
				throw new RuntimeException("Failed to retrieve generated Flight ID.");
			}

			int flightId = generatedFlightId.intValue();
			flight.setFlightId(flightId);

			System.out.println("Flight ID generated: " + flightId);

			// Try both capitalized and lowercase table names
			String tableName = "flight_seats"; // Try "Flight_Seats" if this doesn't work

			// Add Economy Class seats with explicit error checking
			int economyInsertResult = jdbcTemplate.update(
					"INSERT INTO " + tableName
							+ " (Flight_ID, Seat_Class_ID, Available_Seats, Total_Seats, price) VALUES (?, ?, ?, ?, ?)",
					flightId, 1, economyTotalSeats, economyTotalSeats, 0.0);
			System.out.println("Economy seats insert result: " + economyInsertResult);
			if (economyInsertResult <= 0) {
				throw new RuntimeException("Failed to insert Economy class seats");
			}

			// Add Business Class seats with explicit error checking
			int businessInsertResult = jdbcTemplate.update(
					"INSERT INTO " + tableName
							+ " (Flight_ID, Seat_Class_ID, Available_Seats, Total_Seats, price) VALUES (?, ?, ?, ?, ?)",
					flightId, 2, businessTotalSeats, businessTotalSeats, 0.0);
			System.out.println("Business seats insert result: " + businessInsertResult);
			if (businessInsertResult <= 0) {
				throw new RuntimeException("Failed to insert Business class seats");
			}

			// Add First Class seats with explicit error checking
			int firstClassInsertResult = jdbcTemplate.update(
					"INSERT INTO " + tableName
							+ " (Flight_ID, Seat_Class_ID, Available_Seats, Total_Seats, price) VALUES (?, ?, ?, ?, ?)",
					flightId, 3, firstClassTotalSeats, firstClassTotalSeats, 0.0);
			System.out.println("First Class seats insert result: " + firstClassInsertResult);
			if (firstClassInsertResult <= 0) {
				throw new RuntimeException("Failed to insert First Class seats");
			}

		} catch (Exception e) {
			System.err.println("ERROR in addFlightWithSeats: " + e.getMessage());
			e.printStackTrace();
			throw e; 
		}
	}

}
