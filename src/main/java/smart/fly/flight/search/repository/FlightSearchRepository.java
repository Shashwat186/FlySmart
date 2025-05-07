package smart.fly.flight.search.repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.airline.model.Airline;
import smart.fly.airport.model.Airport;
import smart.fly.dto.FlightSearchDTO;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class FlightSearchRepository {

	private final JdbcTemplate jdbcTemplate;
	private static final Logger logger = LoggerFactory.getLogger(FlightSearchRepository.class);

	public FlightSearchRepository(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<FlightSearchDTO> searchFlights(Integer departureAirportId, Integer arrivalAirportId, Date searchDate,
			Integer seatClassId, Integer totalPassengers) {

		logger.info("Searching flights with params - From: {}, To: {}, Date: {}, SeatClass: {}, Passengers: {}",
				departureAirportId, arrivalAirportId, searchDate, seatClassId, totalPassengers);

		StringBuilder sqlBuilder = new StringBuilder(
				"SELECT " + "f.flight_Id, f.flight_number, " + "f.Departure_Date_Time, f.Arrival_Date_Time, f.Status, "
						+ "a.Airline_ID, a.name AS airline_name, a.code AS airline_code, "
						+ "dep.Airport_ID AS dep_id, dep.name AS departure_airport_name, dep.code AS departure_code, "
						+ "arr.Airport_ID AS arr_id, arr.name AS arrival_airport_name, arr.code AS arrival_code, "
						+ "fs.price " + "FROM flight f " + "JOIN airline a ON f.Airline_ID = a.Airline_ID "
						+ "JOIN airport dep ON f.Departure_Airport_ID = dep.Airport_ID "
						+ "JOIN airport arr ON f.Arrival_Airport_ID = arr.Airport_ID "
						+ "JOIN flight_seats fs ON f.flight_Id = fs.Flight_ID " + "WHERE f.Departure_Airport_ID = ? "
						+ "AND f.Arrival_Airport_ID = ? " + "AND f.Status IN ('Scheduled', 'Delayed', 'Completed')");

		List<Object> params = new ArrayList<>();
		params.add(departureAirportId);
		params.add(arrivalAirportId);

		
		if (searchDate != null) {
			sqlBuilder.append(" AND f.Departure_Date_Time >= ?");
			params.add(searchDate);
		}

		
		if (seatClassId != null) {
			sqlBuilder.append(" AND fs.Seat_Class_ID = ?");
			params.add(seatClassId);
		}

		// Add seats availability check for the total number of passengers
		sqlBuilder.append(" AND fs.Available_Seats >= ?");
		params.add(totalPassengers);
		sqlBuilder.append(" ORDER BY f.Departure_Date_Time");

		
		return jdbcTemplate.query(sqlBuilder.toString(), params.toArray(), new FlightSearchRowMapper());
	}

	
	private static class FlightSearchRowMapper implements RowMapper<FlightSearchDTO> {
		@Override
		public FlightSearchDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			FlightSearchDTO flight = new FlightSearchDTO();
			flight.setFlightId(rs.getInt("flight_Id"));
			flight.setFlightNumber(rs.getString("flight_number"));
			flight.setDepartureDate(rs.getTimestamp("Departure_Date_Time"));
			flight.setArrivalDate(rs.getTimestamp("Arrival_Date_Time"));
			flight.setPrice(rs.getDouble("price"));

			// Calculate duration in minutes
			long departureTime = flight.getDepartureDate().getTime();
			long arrivalTime = flight.getArrivalDate().getTime();
			int durationMinutes = (int) ((arrivalTime - departureTime) / (60 * 1000));
			flight.setDuration(durationMinutes);

			// Set departure airport info
			Airport depAirport = new Airport();
			depAirport.setAirportId(rs.getInt("dep_id"));
			depAirport.setCode(rs.getString("departure_code"));
			depAirport.setName(rs.getString("departure_airport_name"));
			depAirport.setLocation(rs.getString("departure_airport_name"));
			flight.setDepartureAirport(depAirport);

			// Set arrival airport info
			Airport arrAirport = new Airport();
			arrAirport.setAirportId(rs.getInt("arr_id"));
			arrAirport.setCode(rs.getString("arrival_code"));
			arrAirport.setName(rs.getString("arrival_airport_name"));
			arrAirport.setLocation(rs.getString("arrival_airport_name"));
			flight.setArrivalAirport(arrAirport);

			// Set airline info
			Airline airline = new Airline();
			airline.setAirlineId(rs.getInt("Airline_ID"));
			airline.setName(rs.getString("airline_name"));
			airline.setCode(rs.getString("airline_code"));
			flight.setAirline(airline);

			return flight;
		}
	}
}