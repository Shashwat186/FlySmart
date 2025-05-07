package smart.fly.airport.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.airport.model.Airport;
import smart.fly.airport.repository.AirportRepository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class AirportRepositoryImpl implements AirportRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public AirportRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Airport findById(int airportId) {
		String sql = "SELECT * FROM Airport WHERE airport_id = ?";
		return jdbcTemplate.queryForObject(sql, new AirportRowMapper(), airportId);
	}

	@Override
	public Airport findByCode(String code) {
		String sql = "SELECT * FROM Airport WHERE code = ?";
		return jdbcTemplate.queryForObject(sql, new AirportRowMapper(), code);
	}

	@Override
	public List<Airport> findAll() {
		String sql = "SELECT * FROM Airport ORDER BY name";
		return jdbcTemplate.query(sql, new AirportRowMapper());
	}

	@Override
	public List<Airport> findByLocation(String location) {
		String sql = "SELECT * FROM Airport WHERE location LIKE ?";
		return jdbcTemplate.query(sql, new AirportRowMapper(), "%" + location + "%");
	}

	@Override
	public void save(Airport airport) {
		String sql = "INSERT INTO Airport (name, code, contact_info, location) VALUES (?, ?, ?, ?)";
		jdbcTemplate.update(sql, airport.getName(), airport.getCode(), airport.getContactInfo(), airport.getLocation());
	}

	@Override
	public void update(Airport airport) {
		String sql = "UPDATE Airport SET name = ?, code = ?, contact_info = ?, location = ? WHERE airport_id = ?";
		jdbcTemplate.update(sql, airport.getName(), airport.getCode(), airport.getContactInfo(), airport.getLocation(),
				airport.getAirportId());
	}

	@Override
	public void delete(int airportId) {
		String sql = "DELETE FROM Airport WHERE airport_id = ?";
		jdbcTemplate.update(sql, airportId);
	}

	@Override
	public int countAirport() {
		String sql = "SELECT COUNT(*) FROM airport";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	private static class AirportRowMapper implements RowMapper<Airport> {
		@Override
		public Airport mapRow(ResultSet rs, int rowNum) throws SQLException {
			Airport airport = new Airport();
			airport.setAirportId(rs.getInt("airport_id"));
			airport.setName(rs.getString("name"));
			airport.setCode(rs.getString("code"));
			airport.setContactInfo(rs.getString("contact_info"));
			airport.setLocation(rs.getString("location"));
			return airport;
		}
	}

	@Override
	public List<Airport> findAllForSearch() {
		String sql = "SELECT Airport_ID, name, code, location FROM Airport ORDER BY name";
		return jdbcTemplate.query(sql, new AirportSearchRowMapper());
	}

	// New row mapper specifically for search functionality
	private static class AirportSearchRowMapper implements RowMapper<Airport> {
		@Override
		public Airport mapRow(ResultSet rs, int rowNum) throws SQLException {
			Airport airport = new Airport();
			airport.setAirportId(rs.getInt("Airport_ID"));
			airport.setName(rs.getString("name"));
			airport.setCode(rs.getString("code"));
			airport.setLocation(rs.getString("location"));
			// contact_info is intentionally omitted as it's not needed for search results
			return airport;
		}
	}
}
