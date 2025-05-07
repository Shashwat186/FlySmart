package smart.fly.airline.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.airline.model.Airline;
import smart.fly.airline.repository.AirlineRepository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class AirlineRepositoryImpl implements AirlineRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired   
	public AirlineRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Airline findById(int airlineId) {
		String sql = "SELECT * FROM Airline WHERE airline_id = ?";
		return jdbcTemplate.queryForObject(sql, new AirlineRowMapper(), airlineId);
	}

	@Override
	public Airline findByCode(String code) {
		String sql = "SELECT * FROM Airline WHERE code = ?";
		return jdbcTemplate.queryForObject(sql, new AirlineRowMapper(), code);
	}

	@Override
	public List<Airline> findAll() {
		String sql = "SELECT * FROM Airline ORDER BY name";
		return jdbcTemplate.query(sql, new AirlineRowMapper());
	}

	@Override
	public void save(Airline airline) {
		String sql = "INSERT INTO Airline (name, code, contact_info) VALUES (?, ?, ?)";
		jdbcTemplate.update(sql, airline.getName(), airline.getCode(), airline.getContactInfo());
	}

	@Override
	public void update(Airline airline) {
		String sql = "UPDATE Airline SET name = ?, code = ?, contact_info = ? WHERE airline_id = ?";
		jdbcTemplate.update(sql, airline.getName(), airline.getCode(), airline.getContactInfo(),
				airline.getAirlineId());
	}

	@Override
	public void delete(int airlineId) {
		String sql = "DELETE FROM Airline WHERE airline_id = ?";
		jdbcTemplate.update(sql, airlineId);
	}

	@Override
	public int countAirline() {
		String sql = "SELECT COUNT(*) FROM airline";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	private static class AirlineRowMapper implements RowMapper<Airline> {
		@Override
		public Airline mapRow(ResultSet rs, int rowNum) throws SQLException {
			Airline airline = new Airline();
			airline.setAirlineId(rs.getInt("airline_id"));
			airline.setName(rs.getString("name"));
			airline.setCode(rs.getString("code"));
			airline.setContactInfo(rs.getString("contact_info"));
			return airline;
		}
	}
}
