package smart.fly.payment.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.booking.model.Booking;
import smart.fly.payment.model.Payment;
import smart.fly.payment.repository.PaymentRepository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class PaymentRepositoryImpl implements PaymentRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public PaymentRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public void save(Payment payment) {
		String sql = "INSERT INTO Payment (booking_id, card_number, card_holder_name, "
				+ "expiry_date, payment_date_time, payment_mode, transaction_id, upi_id, card_type) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, payment.getBooking().getBookingId(), payment.getCardNumber(),
				payment.getCardHolderName(), payment.getExpiryDate(), payment.getPaymentDateTime(),
				payment.getPaymentMode(), payment.getTransactionId(), payment.getUpiId(), payment.getCardType());
	}

	@Override
	public Payment findByBooking(int bookingId) {
		String sql = "SELECT * FROM Payment WHERE booking_id = ?";
		return jdbcTemplate.queryForObject(sql, new PaymentRowMapper(), bookingId);
	}

	@Override
	public List<Payment> findByTransactionId(String transactionId) {
		String sql = "SELECT * FROM Payment WHERE transaction_id = ?";
		return jdbcTemplate.query(sql, new PaymentRowMapper(), transactionId);
	}

	@Override
	public void updatePaymentStatus(int paymentId, String status) {
		String sql = "UPDATE Payment SET status = ? WHERE payment_id = ?";
		jdbcTemplate.update(sql, status, paymentId);
	}

//	@Override
//	public int totalPayment() {
//		String sql = "SELECT SUM(amount) AS total_price\r\n" + "FROM payment";
//		return jdbcTemplate.queryForObject(sql, Integer.class);
//	}
	@Override
	public int totalPayment() {
	    String sql = "SELECT SUM(p.Amount) AS total_price " +
	                 "FROM payment p " +
	                 "JOIN booking b ON p.Booking_ID = b.Booking_ID " +
	                 "WHERE b.status = 'BOOKED'";
	    
	    return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	private static class PaymentRowMapper implements RowMapper<Payment> {
		@Override
		public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
			Payment payment = new Payment();
			payment.setPaymentId(rs.getInt("payment_id"));

			Booking booking = new Booking();
			booking.setBookingId(rs.getInt("booking_id"));
			payment.setBooking(booking);

			payment.setCardNumber(rs.getString("card_number"));
			payment.setCardHolderName(rs.getString("card_holder_name"));
			payment.setExpiryDate(rs.getDate("expiry_date"));
			payment.setPaymentDateTime(rs.getTimestamp("payment_date_time"));
			payment.setPaymentMode(rs.getString("payment_mode"));
			payment.setTransactionId(rs.getString("transaction_id"));
			payment.setUpiId(rs.getString("upi_id"));
			payment.setCardType(rs.getString("card_type"));

			return payment;
		}
	}
}
