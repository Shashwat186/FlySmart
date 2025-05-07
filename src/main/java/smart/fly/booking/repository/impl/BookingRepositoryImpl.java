package smart.fly.booking.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import smart.fly.user.model.*;
import smart.fly.airline.model.Airline;
import smart.fly.airport.model.Airport;
import smart.fly.booking.model.Booking;
import smart.fly.booking.repository.BookingRepository;
import smart.fly.flight.model.Flight;

import smart.fly.seatclass.model.SeatClass;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public class BookingRepositoryImpl implements BookingRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public BookingRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Booking findById(int bookingId) {
		String sql = "SELECT * FROM Booking WHERE booking_id = ?";
		return jdbcTemplate.queryForObject(sql, new BookingRowMapper(), bookingId);
	}

	@Override
	public List<Booking> findByPassenger(int passengerId) {
		String sql = "SELECT * FROM Booking WHERE passenger_id = ? ORDER BY booking_date_time DESC";
		return jdbcTemplate.query(sql, new BookingRowMapper(), passengerId);
	}

	@Override
	public List<Booking> findByFlight(int flightId) {
		String sql = "SELECT * FROM Booking WHERE flight_id = ? ORDER BY booking_date_time DESC";
		return jdbcTemplate.query(sql, new BookingRowMapper(), flightId);
	}

	@Override
	public void save(Booking booking) {
		String sql = "INSERT INTO Booking (passenger_id, flight_id, seat_class_id, "
				+ "booking_date_time, number_of_seats, total_price) " + "VALUES (?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, booking.getPassenger().getPassengerId(), booking.getFlight().getFlightId(),
				booking.getSeatClass().getSeatClassId(), booking.getBookingDateTime(), booking.getNumberOfSeats(),
				booking.getTotalPrice());
	}

	@Override
	public void cancel(int bookingId) {
		String sql = "DELETE FROM Booking WHERE booking_id = ?";
		jdbcTemplate.update(sql, bookingId);
	}

	@Override
	public void updateSeats(int bookingId, int newSeatCount) {
		String sql = "UPDATE Booking SET number_of_seats = ? WHERE booking_id = ?";
		jdbcTemplate.update(sql, newSeatCount, bookingId);
	}

	private static class BookingRowMapper implements RowMapper<Booking> {
		@Override
		public Booking mapRow(ResultSet rs, int rowNum) throws SQLException {
			Booking booking = new Booking();
			booking.setBookingId(rs.getInt("booking_id"));

			User user = new User();
			booking.setUserId(rs.getInt("User_ID"));

			Flight flight = new Flight();
			flight.setFlightId(rs.getInt("flight_id"));
			booking.setFlight(flight);

			SeatClass seatClass = new SeatClass();
			seatClass.setSeatClassId(rs.getInt("seat_class_id"));
			booking.setSeatClass(seatClass);

			booking.setBookingDateTime(rs.getTimestamp("booking_date_time"));
			booking.setNumberOfSeats(rs.getInt("number_of_seats"));
			booking.setTotalPrice(rs.getDouble("total_price"));

			return booking;
		}
	}

	// New RowMapper for fetching booking details
	private static class BookingWithDetailsRowMapper implements RowMapper<Booking> {
		@Override
		public Booking mapRow(ResultSet rs, int rowNum) throws SQLException {
			Booking booking = new Booking();
			booking.setBookingId(rs.getInt("Booking_ID"));
			booking.setUserId(rs.getInt("User_ID"));
			booking.setBookingDateTime(rs.getTimestamp("Booking_Date_Time"));
			booking.setNumberOfSeats(rs.getInt("Number_of_Seats"));
			booking.setTotalPrice(rs.getDouble("total_price"));
			booking.setStatus(rs.getString("status"));
			// Handle potentially null values
			if (rs.getObject("number_of_adults") != null) {
				booking.setNumberOfAdults(rs.getInt("number_of_adults"));
			}
			if (rs.getObject("number_of_children") != null) {
				booking.setNumberOfChildren(rs.getInt("number_of_children"));
			}

			String statusValue = rs.getString("status");
			// Handle status if needed

			Flight flight = new Flight();
			flight.setFlightId(rs.getInt("Flight_ID"));
			flight.setFlightNumber(rs.getString("flight_number"));
			flight.setDepartureDateTime(rs.getTimestamp("Departure_Date_Time"));
			flight.setArrivalDateTime(rs.getTimestamp("Arrival_Date_Time"));
			flight.setStatus(rs.getString("status")); 
			flight.setFmId(rs.getInt("FM_ID"));

			
			Airport departureAirport = new Airport();
			departureAirport.setAirportId(rs.getInt("departure_airport_id"));
			departureAirport.setCode(rs.getString("departure_code"));
			departureAirport.setName(rs.getString("departure_airport_name"));
			departureAirport.setLocation(rs.getString("departure_location"));
			flight.setDepartureAirport(departureAirport);

			
			Airport arrivalAirport = new Airport();
			arrivalAirport.setAirportId(rs.getInt("arrival_airport_id"));
			arrivalAirport.setCode(rs.getString("arrival_code"));
			arrivalAirport.setName(rs.getString("arrival_airport_name"));
			arrivalAirport.setLocation(rs.getString("arrival_location"));
			flight.setArrivalAirport(arrivalAirport);

			// Set airline 
			Airline airline = new Airline();
			airline.setAirlineId(rs.getInt("airline_id"));
			airline.setCode(rs.getString("airline_code"));
			airline.setName(rs.getString("airline_name"));
			flight.setAirline(airline);

			booking.setFlight(flight); 

			// Set seat class
			SeatClass seatClass = new SeatClass();
			seatClass.setSeatClassId(rs.getInt("seat_class_id"));
			seatClass.setName(rs.getString("seat_class_name"));
			seatClass.setPrice(rs.getDouble("seat_class_price"));
			booking.setSeatClass(seatClass);

			return booking;
		}
	}

	@Override
	public List<Booking> findBookingByUserId(int User_ID) {
		String sql = "SELECT * FROM booking WHERE User_ID = ?";
		return jdbcTemplate.query(sql, new BookingRowMapper(), User_ID);
	}

	@Override
	public Optional<Booking> findBookingDetailsById(int bookingId) {
		String sql = "SELECT b.Booking_ID, b.User_ID, b.Flight_ID, b.Seat_Class_ID, "
				+ "b.Booking_Date_Time, b.Number_of_Seats, b.total_price, b.number_of_adults, b.number_of_children, b.status, "
				+ "f.flight_number, f.Departure_Airport_ID, f.Arrival_Airport_ID, f.Departure_Date_Time, f.Arrival_Date_Time, f.Airline_ID, f.FM_ID, "
				+ "dep_apt.Airport_ID AS departure_airport_id, dep_apt.code AS departure_code, dep_apt.name AS departure_airport_name, dep_apt.Location AS departure_location, "
				+ "arr_apt.Airport_ID AS arrival_airport_id, arr_apt.code AS arrival_code, arr_apt.name AS arrival_airport_name, arr_apt.Location AS arrival_location, "
				+ "al.Airline_ID AS airline_id, al.code AS airline_code, al.name AS airline_name, "
				+ "sc.Seat_Class_ID AS seat_class_id, sc.Class_Name AS seat_class_name, sc.price AS seat_class_price "
				+ "FROM booking b " + "JOIN flight f ON b.Flight_ID = f.flight_Id "
				+ "JOIN airport dep_apt ON f.Departure_Airport_ID = dep_apt.Airport_ID "
				+ "JOIN airport arr_apt ON f.Arrival_Airport_ID = arr_apt.Airport_ID "
				+ "JOIN airline al ON f.Airline_ID = al.Airline_ID "
				+ "JOIN seat_class sc ON b.Seat_Class_ID = sc.Seat_Class_ID " + "WHERE b.Booking_ID = ?";

		List<Booking> bookings = jdbcTemplate.query(sql, new BookingWithDetailsRowMapper(), bookingId);
		return bookings.isEmpty() ? Optional.empty() : Optional.of(bookings.get(0));
	}

	public List<Booking> findBookingDetailsByUserId(int userId) {
		String sql = "SELECT b.Booking_ID, b.User_ID, b.Flight_ID, b.Seat_Class_ID, "
				+ "b.Booking_Date_Time,b.status, b.Number_of_Seats, b.total_price, b.number_of_adults, b.number_of_children, b.status, "
				+ "f.flight_number, f.Departure_Date_Time, f.Arrival_Date_Time, f.Status, f.FM_ID, "
				+ "dep_apt.Airport_ID AS departure_airport_id, dep_apt.code AS departure_code, dep_apt.name AS departure_airport_name, dep_apt.Location AS departure_location, "
				+ "arr_apt.Airport_ID AS arrival_airport_id, arr_apt.code AS arrival_code, arr_apt.name AS arrival_airport_name, arr_apt.Location AS arrival_location, "
				+ "al.Airline_ID AS airline_id, al.code AS airline_code, al.name AS airline_name, "
				+ "sc.Seat_Class_ID AS seat_class_id, sc.Class_Name AS seat_class_name, sc.price AS seat_class_price "
				+ "FROM booking b " + "JOIN flight f ON b.Flight_ID = f.flight_Id "
				+ "JOIN airport dep_apt ON f.Departure_Airport_ID = dep_apt.Airport_ID "
				+ "JOIN airport arr_apt ON f.Arrival_Airport_ID = arr_apt.Airport_ID "
				+ "JOIN airline al ON f.Airline_ID = al.Airline_ID "
				+ "JOIN seat_class sc ON b.Seat_Class_ID = sc.Seat_Class_ID " + "WHERE b.User_ID = ?";
		return jdbcTemplate.query(sql, new BookingWithDetailsRowMapper(), userId);
	}

	@Override
	public List<Booking> findUpcomingBookingsByUserId(int userId, LocalDateTime todayStart) {
		String sql = "SELECT b.Booking_ID, b.User_ID, b.Flight_ID, b.Seat_Class_ID, "
				+ "b.Booking_Date_Time, b.status, b.Number_of_Seats, b.total_price, b.number_of_adults, b.number_of_children, "
				+ "f.flight_number, f.Departure_Airport_ID, f.Arrival_Airport_ID, f.Departure_Date_Time, f.Arrival_Date_Time, f.Status, f.FM_ID, "
				+ "dep_apt.Airport_ID AS departure_airport_id, dep_apt.code AS departure_code, dep_apt.name AS departure_airport_name, dep_apt.Location AS departure_location, "
				+ "arr_apt.Airport_ID AS arrival_airport_id, arr_apt.code AS arrival_code, arr_apt.name AS arrival_airport_name, arr_apt.Location AS arrival_location, "
				+ "al.Airline_ID AS airline_id, al.code AS airline_code, al.name AS airline_name, "
				+ "sc.Seat_Class_ID AS seat_class_id, sc.Class_Name AS seat_class_name, sc.price AS seat_class_price "
				+ "FROM booking b " + "JOIN flight f ON b.Flight_ID = f.flight_Id "
				+ "JOIN airport dep_apt ON f.Departure_Airport_ID = dep_apt.Airport_ID "
				+ "JOIN airport arr_apt ON f.Arrival_Airport_ID = arr_apt.Airport_ID "
				+ "JOIN airline al ON f.Airline_ID = al.Airline_ID "
				+ "JOIN seat_class sc ON b.Seat_Class_ID = sc.Seat_Class_ID "
				+ "WHERE b.User_ID = ? AND f.Departure_Date_Time >= ? " + "ORDER BY f.Departure_Date_Time";
		return jdbcTemplate.query(sql, new Object[] { userId, Timestamp.valueOf(todayStart) },
				new BookingWithDetailsRowMapper());
	}

	@Override
	public List<Booking> findPreviousBookingsByUserId(int userId, LocalDateTime todayStart) {
		String sql = "SELECT b.Booking_ID, b.User_ID, b.Flight_ID, b.Seat_Class_ID, "
				+ "b.Booking_Date_Time, b.status, b.Number_of_Seats, b.total_price, b.number_of_adults, b.number_of_children, "
				+ "f.flight_number, f.Departure_Airport_ID, f.Arrival_Airport_ID, f.Departure_Date_Time, f.Arrival_Date_Time, f.Status, f.FM_ID, "
				+ "dep_apt.Airport_ID AS departure_airport_id, dep_apt.code AS departure_code, dep_apt.name AS departure_airport_name, dep_apt.Location AS departure_location, "
				+ "arr_apt.Airport_ID AS arrival_airport_id, arr_apt.code AS arrival_code, arr_apt.name AS arrival_airport_name, arr_apt.Location AS arrival_location, "
				+ "al.Airline_ID AS airline_id, al.code AS airline_code, al.name AS airline_name, "
				+ "sc.Seat_Class_ID AS seat_class_id, sc.Class_Name AS seat_class_name, sc.price AS seat_class_price "
				+ "FROM booking b " + "JOIN flight f ON b.Flight_ID = f.flight_Id "
				+ "JOIN airport dep_apt ON f.Departure_Airport_ID = dep_apt.Airport_ID "
				+ "JOIN airport arr_apt ON f.Arrival_Airport_ID = arr_apt.Airport_ID "
				+ "JOIN airline al ON f.Airline_ID = al.Airline_ID "
				+ "JOIN seat_class sc ON b.Seat_Class_ID = sc.Seat_Class_ID "
				+ "WHERE b.User_ID = ? AND f.Departure_Date_Time < ? " + "ORDER BY f.Departure_Date_Time DESC";
		return jdbcTemplate.query(sql, new Object[] { userId, Timestamp.valueOf(todayStart) },
				new BookingWithDetailsRowMapper());
	}

	@Override
	public int updateBookingStatus(int bookingId, String status) {
		String sql = "UPDATE booking SET Status = ? WHERE Booking_ID = ?";
		return jdbcTemplate.update(sql, status, bookingId);
	}
}