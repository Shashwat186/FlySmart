package smart.fly.flight.repository;

import smart.fly.dto.FlightSearchDTO;
import smart.fly.flight.model.Flight;
import smart.fly.flightmanager.model.FlightManager;

import java.sql.Date;
import java.util.List;

public interface FlightRepository {
	List<Flight> findAll();

	Flight findById(int flightId);

	Flight findByNumber(String flightNumber);

	List<Flight> findByManagerId(int managerId);

	void save(Flight flight);

	int getTotalFlightsByUserId(int userId);

	void update(Flight flight);

	void delete(int flightId);

	void updateStatus(int flightId, String status);

	List<FlightSearchDTO> searchFlights(int departureAirportId, int arrivalAirportId, Date departureDate,
			Integer seatClassId);

	List<Flight> findAllForCustomers();

	List<FlightManager> findAllFlightManagersWithUsers();

	List<Flight> getTotalFlightsByFlightManagerId(int flightManagerId);

	int countTotalFlight();

	int scheduledFlights();

	int delayedFlights();

	int completedFlights();
int getScheduledFlightsByUserId(int userId);
	
	int getDelayedFlightsByUserId(int userId);

}