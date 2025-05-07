package smart.fly.airport.repository;

import java.util.List;

import smart.fly.airport.model.Airport;

public interface AirportRepository {
	Airport findById(int airportId);

	Airport findByCode(String code);

	List<Airport> findAll();

	List<Airport> findByLocation(String location);

	void save(Airport airport);

	void update(Airport airport);

	void delete(int airportId);

	int countAirport();

	List<Airport> findAllForSearch();
}
