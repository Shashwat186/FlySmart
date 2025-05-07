package smart.fly.airline.repository;

import java.util.List;

import smart.fly.airline.model.Airline;

public interface AirlineRepository {
	Airline findById(int airlineId);

	Airline findByCode(String code);

	List<Airline> findAll();

	void save(Airline airline);

	void update(Airline airline);

	void delete(int airlineId);

	int countAirline();
}
