package smart.fly.flight.seats.repository;

import java.util.List;

import smart.fly.flight.seats.model.FlightSeats;
import smart.fly.flight.seats.repository.impl.FlightSeatsRepositoryImpl.FlightSeatAvailability;

public interface FlightSeatsRepository {
	FlightSeats findByFlightAndClass(int flightId, int seatClassId);

	List<FlightSeats> findByFlight(int flightId);

	void updateAvailableSeats(int flightSeatId, int newAvailableSeats);

	void save(FlightSeats flightSeats);

	FlightSeats findByid(int id);

	List<FlightSeatAvailability> findFlightSeatAvailability();

}