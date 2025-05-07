package smart.fly.businness.owner.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import smart.fly.businness.owner.model.BusinessOwner;
import smart.fly.businness.owner.repository.BusinessOwnerRepository;

import smart.fly.user.model.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class BusinessOwnerRepositoryImpl implements BusinessOwnerRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public BusinessOwnerRepositoryImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public BusinessOwner findById(int boId) {
		String sql = "SELECT * FROM BusinessOwner WHERE bo_id = ?";
		return jdbcTemplate.queryForObject(sql, new BusinessOwnerRowMapper(), boId);
	}

	@Override
	public BusinessOwner findByUserId(int userId) {
		String sql = "SELECT * FROM business_owner WHERE User_ID = ?";
		return jdbcTemplate.queryForObject(sql, new BusinessOwnerRowMapper(), userId);
	}

	@Override
	public List<BusinessOwner> findAll() {
		String sql = "SELECT * FROM BusinessOwner";
		return jdbcTemplate.query(sql, new BusinessOwnerRowMapper());
	}

	@Override
	public void save(BusinessOwner businessOwner) {
		String sql = "INSERT INTO BusinessOwner (user_id) VALUES (?)";
		jdbcTemplate.update(sql, businessOwner.getUser().getUserId());
	}

	@Override
	public void addFlightManager(int boId, int fmId) {
		String sql = "UPDATE FlightManager SET bo_id = ? WHERE fm_id = ?";
		jdbcTemplate.update(sql, boId, fmId);
	}

	@Override
	public List<Integer> getManagedFlightManagerIds(int boId) {
		String sql = "SELECT fm_id FROM FlightManager WHERE bo_id = ?";
		return jdbcTemplate.queryForList(sql, Integer.class, boId);
	}

	@Override
	public int getFlightCount(int boId) {
		String sql = "SELECT COUNT(*) FROM Flight f JOIN FlightManager fm ON f.fm_id = fm.fm_id WHERE fm.bo_id = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, boId);
	}

	private static class BusinessOwnerRowMapper implements RowMapper<BusinessOwner> {
		@Override
		public BusinessOwner mapRow(ResultSet rs, int rowNum) throws SQLException {
			BusinessOwner bo = new BusinessOwner();
			bo.setBoId(rs.getInt("bo_id"));

			User user = new User();
			user.setUserId(rs.getInt("user_id"));
			bo.setUser(user);

			return bo;
		}
	}

}
