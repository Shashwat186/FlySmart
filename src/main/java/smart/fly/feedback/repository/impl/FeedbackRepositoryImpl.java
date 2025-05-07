package smart.fly.feedback.repository.impl;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.dto.FeedbackDTO;
import smart.fly.feedback.model.Feedback;
import smart.fly.feedback.repository.FeedbackRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

@Repository
public class FeedbackRepositoryImpl implements FeedbackRepository {

	private final JdbcTemplate jdbcTemplate;
	private final DataSource dataSource;

	public FeedbackRepositoryImpl(JdbcTemplate jdbcTemplate, DataSource dataSource) {
		super();
		this.jdbcTemplate = jdbcTemplate;
		this.dataSource = dataSource;
	}

	@Override
	public boolean addFeedback(Feedback feedback) {
		String sql = "INSERT INTO Feedback (User_ID, Booking_ID, Feedback_Date_Time, Rating, Feedback_Content, status) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		int rowsAffected = jdbcTemplate.update(sql, feedback.getUserId(), feedback.getBookingId(),
				feedback.getFeedbackDateTime(), feedback.getRating(), feedback.getFeedbackContent(),
				feedback.getStatus());
		return rowsAffected > 0;
	}

	@Override
	public boolean checkFeedbackExists(int userId, int bookingId) {
		String sql = "SELECT COUNT(*) FROM Feedback WHERE User_ID = ? AND Booking_ID = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, bookingId);
		return count != null && count > 0;
	}

//    @Override
//    public List<Feedback> getFeedbacksByUser(int userId) {
//        String sql = "SELECT * FROM Feedback WHERE User_ID = ?";
//        return jdbcTemplate.query(sql, new FeedbackRowMapper(), userId);
//    }

	private static class FeedbackRowMapper implements RowMapper<Feedback> {
		@Override
		public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException {
			Feedback feedback = new Feedback();
			feedback.setFeedbackId(rs.getInt("Feedback_ID"));
			feedback.setUserId(rs.getInt("User_ID"));
			feedback.setBookingId(rs.getInt("Booking_ID"));
			feedback.setFeedbackDateTime(rs.getTimestamp("Feedback_Date_Time").toLocalDateTime());
			feedback.setRating(rs.getInt("Rating"));
			feedback.setFeedbackContent(rs.getString("Feedback_Content"));
			feedback.setStatus(rs.getString("status"));
			return feedback;
		}
	}

	@Override
	public List<Integer> getBookingsWithFeedback(int userId) {
		String sql = "SELECT Booking_ID FROM Feedback WHERE User_ID = ?";
		return jdbcTemplate.queryForList(sql, Integer.class, userId);
	}

	@Override
	public List<FeedbackDTO> getAllFeedbackWithFlightDetails() {
		List<FeedbackDTO> feedbackList = new ArrayList<>();

		String sql = "SELECT f.Feedback_ID, f.User_ID, u.name as user_name, f.Feedback_Date_Time, "
				+ "f.Rating, f.Feedback_Content, f.status, f.Booking_ID, "
				+ "b.Flight_ID, fl.flight_number, a.name as airline_name, "
				+ "dep.name as departure_airport_name, dep.code as departure_airport_code, "
				+ "arr.name as arrival_airport_name, arr.code as arrival_airport_code, "
				+ "fl.Departure_Date_Time, fl.Arrival_Date_Time " + "FROM feedback f "
				+ "JOIN booking b ON f.Booking_ID = b.Booking_ID " + "JOIN flight fl ON b.Flight_ID = fl.flight_Id "
				+ "JOIN user u ON f.User_ID = u.User_ID " + "JOIN airline a ON fl.Airline_ID = a.Airline_ID "
				+ "JOIN airport dep ON fl.Departure_Airport_ID = dep.Airport_ID "
				+ "JOIN airport arr ON fl.Arrival_Airport_ID = arr.Airport_ID " + "ORDER BY f.Feedback_Date_Time DESC";

		try (Connection conn = dataSource.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				FeedbackDTO feedback = new FeedbackDTO();
				feedback.setFeedbackId(rs.getInt("Feedback_ID"));
				feedback.setUserId(rs.getInt("User_ID"));
				feedback.setUserName(rs.getString("user_name"));
				feedback.setFeedbackDateTime(rs.getTimestamp("Feedback_Date_Time").toLocalDateTime());
				feedback.setRating(rs.getInt("Rating"));
				feedback.setFeedbackContent(rs.getString("Feedback_Content"));
				feedback.setStatus(rs.getString("status"));
				feedback.setBookingId(rs.getInt("Booking_ID"));
				feedback.setFlightId(rs.getInt("Flight_ID"));
				feedback.setFlightNumber(rs.getString("flight_number"));
				feedback.setAirlineName(rs.getString("airline_name"));
				feedback.setDepartureAirportName(rs.getString("departure_airport_name"));
				feedback.setDepartureAirportCode(rs.getString("departure_airport_code"));
				feedback.setArrivalAirportName(rs.getString("arrival_airport_name"));
				feedback.setArrivalAirportCode(rs.getString("arrival_airport_code"));
				feedback.setDepartureDateTime(rs.getTimestamp("Departure_Date_Time").toLocalDateTime());
				feedback.setArrivalDateTime(rs.getTimestamp("Arrival_Date_Time").toLocalDateTime());

				feedbackList.add(feedback);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Error fetching feedback data: " + e.getMessage());
		}

		return feedbackList;
	}

	@Override
	public void updateFeedbackStatus(int feedbackId, String status) {
		String sql = "UPDATE feedback SET status = ? WHERE Feedback_ID = ?";

		try (Connection conn = dataSource.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, status);
			stmt.setInt(2, feedbackId);

			int rowsAffected = stmt.executeUpdate();
			if (rowsAffected == 0) {
				throw new RuntimeException("Feedback not found with id: " + feedbackId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Error updating feedback status: " + e.getMessage());
		}
	}

	@Override
	public List<Feedback> getFeedbacksByUser(int userId) {
		String sql = "SELECT * FROM Feedback WHERE User_ID = ?";
		return jdbcTemplate.query(sql, new FeedbackRowMapper(), userId);
	}
}