package smart.fly.user.repository.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import smart.fly.user.model.User;
import smart.fly.user.repository.UserRepository;
import smart.fly.util.PasswordUtil;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

@Repository
public class UserRepositoryImpl implements UserRepository {
	private final JdbcTemplate jdbcTemplate;
	private final PasswordUtil passwordUtil;

	@Autowired
	public UserRepositoryImpl(JdbcTemplate jdbcTemplate, PasswordUtil passwordUtil) {
		this.jdbcTemplate = jdbcTemplate;
		this.passwordUtil = passwordUtil;
	}

	@Override
	public User findByEmail(String email) {
		String sql = "SELECT * FROM User WHERE email = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new UserRowMapper(), email);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public User findById(int userId) {
		String sql = "SELECT * FROM User WHERE user_id = ?";
		return jdbcTemplate.queryForObject(sql, new UserRowMapper(), userId);
	}

	@Override
	public User save(User user) {
		String sql = "INSERT INTO User (name, email, phone, Role, Gender, dob, password_hash, password_salt,profile_photo) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";

		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(connection -> {
			PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setString(4, user.getRole());
			ps.setString(5, user.getGender());
			ps.setTimestamp(6, user.getDob() != null ? new java.sql.Timestamp(user.getDob().getTime()) : null);
			ps.setString(7, user.getPasswordHash());
			ps.setString(8, user.getPasswordSalt());
			if (user.getProfilePhoto() != null) {
				ps.setBytes(9, user.getProfilePhoto());
			} else {
				ps.setNull(9, java.sql.Types.BLOB);
			}
			return ps;
		}, keyHolder);

		if (keyHolder.getKey() != null) {
			user.setUserId(keyHolder.getKey().intValue());
		}
		return user;
	}

	@Override
	public void update(User user) {
		String sql = "UPDATE User SET name = ?, phone = ?, gender = ?, dob = ? WHERE user_id = ?";
		jdbcTemplate.update(sql, user.getName(), user.getPhone(), user.getGender(),
				new java.sql.Date(user.getDob().getTime()), user.getUserId());
	}

	@Override
	public void delete(int userId) {
		String sql = "DELETE FROM User WHERE user_id = ?";
		jdbcTemplate.update(sql, userId);
	}

	@Override
	public void changePassword(int userId, String newPasswordHash, String newSalt) {
		String sql = "UPDATE User SET password_hash = ?, password_salt = ? WHERE user_id = ?";
		jdbcTemplate.update(sql, newPasswordHash, newSalt, userId);
	}

	@Override
	public boolean emailExists(String email) {
		String sql = "SELECT COUNT(*) FROM User WHERE email = ?";
		int count = jdbcTemplate.queryForObject(sql, Integer.class, email);
		return count > 0;
	}

	@Override
	public List<User> findAllByRole(String role) {
		String sql = "SELECT * FROM User WHERE role = ?";
		return jdbcTemplate.query(sql, new UserRowMapper(), role);
	}

	@Override
	public int countByRole(String role) {
		String sql = "SELECT COUNT(*) FROM User WHERE role = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, role);
	}

	@Override
	public void updateProfilePhoto(int userId, byte[] profilePhoto) {
		String sql = "UPDATE User SET profile_photo = ? WHERE user_id = ?";
		jdbcTemplate.update(sql, profilePhoto, userId);
	}

	private static class UserRowMapper implements RowMapper<User> {
		@Override
		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			User user = new User();
			user.setUserId(rs.getInt("user_id"));
			user.setName(rs.getString("name"));
			user.setEmail(rs.getString("email"));
			user.setPhone(rs.getString("phone"));
			user.setRole(rs.getString("role"));
			user.setGender(rs.getString("gender"));
			user.setDob(rs.getDate("dob"));
			user.setPasswordHash(rs.getString("password_hash"));
			user.setPasswordSalt(rs.getString("password_salt"));
			user.setProfilePhoto(rs.getBytes("profile_photo"));
			return user;
		}
	}
}