
package smart.fly.booking.search.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import smart.fly.flight.details.FlightDetails;

@Repository
public class BookingSearchRepository {

	@Autowired
	private DataSource dataSource;

	public int createBooking(Integer flightId, Integer seatClassId, Integer numberOfSeats, Double totalPrice,
			Integer loggedInUserId, Integer numberOfAdults, Integer numberOfChildren) throws SQLException {

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet generatedKeys = null;
		int bookingId = -1;

		try {
			connection = dataSource.getConnection();

			String sql = "INSERT INTO booking (Flight_ID, Seat_Class_ID, Booking_Date_Time, Number_of_Seats, "
					+ "total_price, User_ID, number_of_adults, number_of_children) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, flightId);
			pstmt.setInt(2, seatClassId);
			pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
			pstmt.setInt(4, numberOfSeats);
			pstmt.setDouble(5, totalPrice);
			pstmt.setInt(6, loggedInUserId);
			pstmt.setInt(7, numberOfAdults);
			pstmt.setInt(8, numberOfChildren);

			pstmt.executeUpdate();

			generatedKeys = pstmt.getGeneratedKeys();
			if (generatedKeys.next()) {
				bookingId = generatedKeys.getInt(1);
			} else {
				throw new SQLException("Creating booking failed, no ID obtained.");
			}

			return bookingId;
		} finally {
			if (generatedKeys != null)
				try {
					generatedKeys.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
				}
		}
	}

	public void verifyBookingExists(int bookingId) throws SQLException {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			connection = dataSource.getConnection();

			String sql = "SELECT Booking_ID FROM booking WHERE Booking_ID = ?";

			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, bookingId);

			rs = pstmt.executeQuery();
			
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
				}
		}
	}

	public void createPassenger(int bookingId, String name, String email, Integer age, boolean isRegistered,
			int linkRegId) throws SQLException {
		Connection connection = null;
		PreparedStatement pstmt = null;

		try {
			connection = dataSource.getConnection();

			String sql = "INSERT INTO passenger (Booking_ID, name, email, age, Is_Registered, Link_Reg_ID) "
					+ "VALUES (?, ?, ?, ?, ?, ?)";

			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, bookingId);
			pstmt.setString(2, name);

			if (email != null) {
				pstmt.setString(3, email);
			} else {
				pstmt.setNull(3, Types.VARCHAR);
			}

			if (age != null) {
				pstmt.setInt(4, age);
			} else {
				pstmt.setNull(4, Types.INTEGER);
			}

			pstmt.setBoolean(5, isRegistered);
			pstmt.setInt(6, linkRegId);

			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
				}
		}
	}

	public void createPayment(int bookingId, String paymentMode, String cardNumber, String cardHolderName,
			String expiryDate, String cardType, String transactionId, String upiId, String walletName, Double amount)
			throws SQLException {
		Connection connection = null;
		PreparedStatement pstmt = null;

		try {
			connection = dataSource.getConnection();

			String sql = "INSERT INTO payment (Booking_ID, Payment_Mode, card_number, card_holder_name, "
					+ "expiry_date, Card_Type, Transaction_ID, upi_id, Wallet_Name, Amount, Payment_Date_Time) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, bookingId);
			pstmt.setString(2, paymentMode);
			pstmt.setString(3, cardNumber);
			pstmt.setString(4, cardHolderName);
			pstmt.setString(5, expiryDate);
			pstmt.setString(6, cardType);
			pstmt.setString(7, transactionId);
			pstmt.setString(8, upiId);
			pstmt.setString(9, walletName);
			pstmt.setDouble(10, amount);
			pstmt.setTimestamp(11, Timestamp.valueOf(LocalDateTime.now()));

			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
				}
		}
	}

	public void updateFlightSeats(int flightId, int seatClassId, int numberOfSeats) throws SQLException {
		Connection connection = null;
		PreparedStatement pstmt = null;

		try {
			connection = dataSource.getConnection();

			String sql = "UPDATE flight_seats SET Available_Seats = Available_Seats - ? "
					+ "WHERE Flight_ID = ? AND Seat_Class_ID = ?";

			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, numberOfSeats);
			pstmt.setInt(2, flightId);
			pstmt.setInt(3, seatClassId);

			pstmt.executeUpdate();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
				}
		}
	}

	public FlightDetails getFlightDetails(int flightId) throws SQLException {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FlightDetails flightDetails = null;

		try {
			connection = dataSource.getConnection();

			String sql = "SELECT\n" + " f.flight_Id,\n" + " f.flight_number,\n" + " al.name AS airline_name,\n"
					+ " al.code AS airline_code,\n" + " da.name AS departure_airport_name,\n"
					+ " da.code AS departure_airport_code,\n" + " aa.name AS arrival_airport_name,\n"
					+ " aa.code AS arrival_airport_code,\n" + " f.Departure_Date_Time,\n" + " f.Arrival_Date_Time,\n"
					+ " f.Status\n" + "FROM\n" + " flight f\n" + "JOIN\n"
					+ " Airline al ON f.Airline_ID = al.Airline_ID\n" + "JOIN\n"
					+ " Airport da ON f.Departure_Airport_ID = da.Airport_ID\n" + "JOIN\n"
					+ " Airport aa ON f.Arrival_Airport_ID = aa.Airport_ID\n" + "WHERE Flight_ID = ?";

			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, flightId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				flightDetails = new FlightDetailsRowMapper().mapRow(rs, 0);
			}

			return flightDetails;
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
				}
		}
	}

	public class FlightDetailsRowMapper {

		public FlightDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
			FlightDetails flightDetails = new FlightDetails();

			flightDetails.setFlightNumber(rs.getString("flight_number"));
			flightDetails.setAirlineName(rs.getString("airline_name"));
			flightDetails.setAirlineCode(rs.getString("airline_code"));
			flightDetails.setDepartureAirportName(rs.getString("departure_airport_name"));
			flightDetails.setDepartureAirportCode(rs.getString("departure_airport_code"));
			flightDetails.setArrivalAirportName(rs.getString("arrival_airport_name"));
			flightDetails.setArrivalAirportCode(rs.getString("arrival_airport_code"));
			flightDetails.setDepartureDateTime(rs.getString("Departure_Date_Time"));
			flightDetails.setArrivalDateTime(rs.getString("Arrival_Date_Time"));
			flightDetails.setFlightStatus(rs.getString("Status"));

			return flightDetails;
		}
	}
}
