package smart.fly.flightmanager.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import smart.fly.businness.owner.model.BusinessOwner;
import smart.fly.flightmanager.model.FlightManager;
import smart.fly.flightmanager.repository.FlightManagerRepository;
import smart.fly.user.model.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


import org.springframework.jdbc.support.*;

@Repository
public class FlightManagerRepositoryImpl implements FlightManagerRepository {
	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public FlightManagerRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public FlightManager findById(int fmId) {
		String sql = "SELECT * FROM flight_manager WHERE FM_ID = ?";
		return jdbcTemplate.queryForObject(sql, new FlightManagerRowMapper(), fmId);
	}

	@Override
	public FlightManager findByUserId(int userId) {
		String sql = "SELECT * FROM flight_manager WHERE User_ID = ?";
		return jdbcTemplate.queryForObject(sql, new FlightManagerRowMapper(), userId);
	}

	@Override
	public List<FlightManager> findByBusinessOwner(int boId) {
		String sql = "SELECT fm.*, u.name, u.email FROM flight_manager fm " + "JOIN user u ON fm.User_ID = u.User_ID "
				+ "WHERE fm.BO_ID = ?";
		return jdbcTemplate.query(sql, new FlightManagerRowMapper(), boId);
	}

	@Override
	public FlightManager save(FlightManager flightManager) {
		String sql = "INSERT INTO flight_manager (BO_ID, User_ID) VALUES (?, ?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();

		jdbcTemplate.update(connection -> {
			PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, flightManager.getBusinessOwner().getBoId());
			ps.setInt(2, flightManager.getUser().getUserId());
			return ps;
		}, keyHolder);

		if (keyHolder.getKey() != null) {
			flightManager.setFmId(keyHolder.getKey().intValue());
		}
		return flightManager;
	}

	@Override
	public void update(FlightManager flightManager) {
		String sql = "UPDATE flight_manager SET BO_ID = ? WHERE FM_ID = ?";
		jdbcTemplate.update(sql, flightManager.getBusinessOwner().getBoId(), flightManager.getFmId());
	}

	@Override
	public void changePassword(int fmId, String newPasswordHash, String newSalt) {
		String sql = "UPDATE user u JOIN flight_manager fm ON u.User_ID = fm.User_ID "
				+ "SET u.password_hash = ?, u.password_salt = ? " + "WHERE fm.FM_ID = ?";
		jdbcTemplate.update(sql, newPasswordHash, newSalt, fmId);
	}

	@Override
	public void assignToBusinessOwner(int fmId, int boId) {
		String sql = "UPDATE flight_manager SET BO_ID = ? WHERE FM_ID = ?";
		jdbcTemplate.update(sql, boId, fmId);
	}

	private static class FlightManagerRowMapper implements RowMapper<FlightManager> {
		@Override
		public FlightManager mapRow(ResultSet rs, int rowNum) throws SQLException {
			FlightManager fm = new FlightManager();
			fm.setFmId(rs.getInt("FM_ID"));

			BusinessOwner bo = new BusinessOwner();
			bo.setBoId(rs.getInt("BO_ID"));
			fm.setBusinessOwner(bo);

			User user = new User();
			user.setUserId(rs.getInt("User_ID"));

			
			try {
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
			} catch (SQLException e) {
				
			}

			fm.setUser(user);
			return fm;
		}
	}

	@Override
	public List<FlightManager> findAll() {
		String sql = "SELECT fm.*, u.name, u.email " + "FROM flight_manager fm "
				+ "JOIN user u ON fm.User_ID = u.User_ID " + "WHERE u.Role = 'MANAGER' " + "ORDER BY u.name";
		return jdbcTemplate.query(sql, new FlightManagerRowMapper());
	}

	@Override
	public List<FlightManager> getManagedFlightManagers(int boId) {
		String sql = "SELECT fm.*, u.name, u.email " + "FROM flight_manager fm "
				+ "JOIN user u ON fm.User_ID = u.User_ID " + "WHERE fm.BO_ID = ?";
		return jdbcTemplate.query(sql, new FlightManagerRowMapper(), boId);
	}

}