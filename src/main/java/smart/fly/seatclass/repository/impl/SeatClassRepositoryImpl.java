package smart.fly.seatclass.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.seatclass.model.SeatClass;
import smart.fly.seatclass.repository.SeatClassRepository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class SeatClassRepositoryImpl implements SeatClassRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public SeatClassRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public SeatClass findById(int seatClassId) {
		String sql = "SELECT * FROM Seat_Class WHERE Seat_Class_ID = ?";
		return jdbcTemplate.queryForObject(sql, new SeatClassRowMapper(), seatClassId);
	}

	@Override
	public List<SeatClass> findAll() {
		String sql = "SELECT * FROM Seat_Class";
		return jdbcTemplate.query(sql, new SeatClassRowMapper());
	}

	@Override
	public void save(SeatClass seatClass) {
		String sql = "INSERT INTO Seat_Class (class_name, price) VALUES (?, ?)";
		jdbcTemplate.update(sql, seatClass.getName(), seatClass.getPrice());
	}

	@Override
	public void updatePrice(int seatClassId, double newPrice) {
		String sql = "UPDATE Seat_Class SET price = ? WHERE seat_class_id = ?";
		jdbcTemplate.update(sql, newPrice, seatClassId);
	}

	@Override
	public SeatClass findByName(String className) {
		String sql = "SELECT * FROM seat_class WHERE class_name = ?";
		return jdbcTemplate.queryForObject(sql, new SeatClassRowMapper(), className);
	}

	private static class SeatClassRowMapper implements RowMapper<SeatClass> {
		@Override
		public SeatClass mapRow(ResultSet rs, int rowNum) throws SQLException {
			SeatClass seatClass = new SeatClass();
			seatClass.setSeatClassId(rs.getInt("Seat_Class_ID"));
			seatClass.setName(rs.getString("Class_Name"));
			seatClass.setPrice(rs.getDouble("price"));
			return seatClass;
		}
	}

	@Override
	public List<SeatClass> findByFlightIdWithAvailableSeats(int flightId) {
		String sql = "SELECT sc.* FROM seat_class sc " + "JOIN flight_Seats fs ON sc.Seat_Class_ID = fs.Seat_Class_ID "
				+ "WHERE fs.Flight_ID = ? AND fs.Available_Seats > 0 " + "GROUP BY sc.Seat_Class_ID"; // Use GROUP BY to
																										// avoid
																										// duplicates if
																										// multiple
																										// Flight_Seat
																										// entries exist
																										// for the same
																										// Seat_Class
		return jdbcTemplate.query(sql, new SeatClassRowMapper(), flightId);
	}

	@Override
	public Integer getAvailableSeatsForFlightSeatClass(int flightId, Integer SeatClassId) {
		String sql = "SELECT Available_Seats FROM Flight_Seats WHERE Flight_ID = ? AND Seat_Class_ID = ?";
		try {
			return jdbcTemplate.queryForObject(sql, Integer.class, flightId, SeatClassId);
		} catch (EmptyResultDataAccessException e) {
			return null; // Or handle the case where no entry exists
		}
	}
}
