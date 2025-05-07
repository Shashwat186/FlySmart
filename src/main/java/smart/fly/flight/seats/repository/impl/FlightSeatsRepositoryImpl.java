package smart.fly.flight.seats.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.flight.model.Flight;
import smart.fly.flight.seats.model.FlightSeats;
import smart.fly.flight.seats.repository.FlightSeatsRepository;
import smart.fly.seatclass.model.SeatClass;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class FlightSeatsRepositoryImpl implements FlightSeatsRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public FlightSeatsRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public FlightSeats findByFlightAndClass(int flightId, int seatClassId) {
		String sql = "SELECT * FROM Flight_Seats WHERE flight_id = ? AND seat_class_id = ?";
		return jdbcTemplate.queryForObject(sql, new FlightSeatsRowMapper(), flightId, seatClassId);
	}

	@Override
	public List<FlightSeats> findByFlight(int flightId) {
		String sql = "SELECT * FROM Flight_Seats WHERE flight_id = ?";
		return jdbcTemplate.query(sql, new FlightSeatsRowMapper(), flightId);
	}

	@Override
	public void updateAvailableSeats(int flightSeatId, int newAvailableSeats) {
		String sql = "UPDATE Flight_Seats SET available_seats = ? WHERE flight_seat_id = ?";
		jdbcTemplate.update(sql, newAvailableSeats, flightSeatId);
	}

	@Override
	public void save(FlightSeats flightSeats) {
		String sql = "INSERT INTO flight_Seats (Flight_id, Seat_Class_id, Available_seats, Total_seats, Price) "
				+ "VALUES (?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, flightSeats.getFlight().getFlightId(), flightSeats.getSeatClass().getSeatClassId(),
				flightSeats.getAvailableSeats(), flightSeats.getTotalSeats(), flightSeats.getPrice());
	}

	private static class FlightSeatsRowMapper implements RowMapper<FlightSeats> {
		@Override
		public FlightSeats mapRow(ResultSet rs, int rowNum) throws SQLException {
			FlightSeats flightSeats = new FlightSeats();
			flightSeats.setFlightSeatId(rs.getInt("flight_seat_id"));

			Flight flight = new Flight();
			flight.setFlightId(rs.getInt("flight_id"));
			flightSeats.setFlight(flight);

			SeatClass seatClass = new SeatClass();
			seatClass.setSeatClassId(rs.getInt("seat_class_id"));
			flightSeats.setSeatClass(seatClass);

			flightSeats.setAvailableSeats(rs.getInt("available_seats"));
			flightSeats.setTotalSeats(rs.getInt("total_seats"));
			flightSeats.setPrice(rs.getDouble("price"));

			return flightSeats;
		}
	}

	@Override
	public FlightSeats findByid(int id) {
		String sql = "SELECT * FROM flight_Seats WHERE flight_seat_id = ?";
		return jdbcTemplate.queryForObject(sql, new FlightSeatsRowMapper(), id);
	}

	@Override
	public List<FlightSeatAvailability> findFlightSeatAvailability() {
		String sql = "SELECT " + "f.flight_number, " + "ap_dep.name AS departure_airport, "
				+ "ap_arr.name AS arrival_airport, " + "f.Departure_Date_Time, " + "f.Arrival_Date_Time, "
				+ "f.Status, " + "al.name AS airline_name, " + "sc.Class_Name AS seat_class_name, "
				+ "fs.Available_Seats, " + "fs.Total_Seats, " + "fs.price AS seat_price " + "FROM flight_seats fs "
				+ "JOIN flight f ON fs.Flight_ID = f.flight_Id "
				+ "JOIN airport ap_dep ON f.Departure_Airport_ID = ap_dep.Airport_ID "
				+ "JOIN airport ap_arr ON f.Arrival_Airport_ID = ap_arr.Airport_ID "
				+ "JOIN airline al ON f.Airline_ID = al.Airline_ID "
				+ "JOIN seat_class sc ON fs.Seat_Class_ID = sc.Seat_Class_ID";

		return jdbcTemplate.query(sql, new FlightSeatAvailabilityRowMapper());
	}

	private static class FlightSeatAvailabilityRowMapper implements RowMapper<FlightSeatAvailability> {
		@Override
		public FlightSeatAvailability mapRow(ResultSet rs, int rowNum) throws SQLException {
			return new FlightSeatAvailability(rs.getString("flight_number"), rs.getString("departure_airport"),
					rs.getString("arrival_airport"), rs.getObject("Departure_Date_Time", LocalDateTime.class),
					rs.getObject("Arrival_Date_Time", LocalDateTime.class), rs.getString("Status"),
					rs.getString("airline_name"), rs.getString("seat_class_name"), rs.getInt("Available_Seats"),
					rs.getInt("Total_Seats"), rs.getDouble("seat_price"));
		}
	}

	public static class FlightSeatAvailability {
		private final String flightNumber;
		private final String departureAirport;
		private final String arrivalAirport;
		private final LocalDateTime departureDateTime;
		private final LocalDateTime arrivalDateTime;
		private final String status;
		private final String airlineName;
		private final String seatClassName;
		private final Integer availableSeats;
		private final Integer totalSeats;
		private final Double seatPrice;

		public FlightSeatAvailability(String flightNumber, String departureAirport, String arrivalAirport,
				LocalDateTime departureDateTime, LocalDateTime arrivalDateTime, String status, String airlineName,
				String seatClassName, Integer availableSeats, Integer totalSeats, Double seatPrice) {
			this.flightNumber = flightNumber;
			this.departureAirport = departureAirport;
			this.arrivalAirport = arrivalAirport;
			this.departureDateTime = departureDateTime;
			this.arrivalDateTime = arrivalDateTime;
			this.status = status;
			this.airlineName = airlineName;
			this.seatClassName = seatClassName;
			this.availableSeats = availableSeats;
			this.totalSeats = totalSeats;
			this.seatPrice = seatPrice;
		}

		public String getFlightNumber() {
			return flightNumber;
		}

		public String getDepartureAirport() {
			return departureAirport;
		}

		public String getArrivalAirport() {
			return arrivalAirport;
		}

		public LocalDateTime getDepartureDateTime() {
			return departureDateTime;
		}

		public LocalDateTime getArrivalDateTime() {
			return arrivalDateTime;
		}

		public String getStatus() {
			return status;
		}

		public String getAirlineName() {
			return airlineName;
		}

		public String getSeatClassName() {
			return seatClassName;
		}

		public Integer getAvailableSeats() {
			return availableSeats;
		}

		public Integer getTotalSeats() {
			return totalSeats;
		}

		public Double getSeatPrice() {
			return seatPrice;
		}
	}
}
