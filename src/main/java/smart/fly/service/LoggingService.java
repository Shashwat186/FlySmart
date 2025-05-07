package smart.fly.service;

import org.springframework.stereotype.Service;

import smart.fly.action.log.ActionLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class LoggingService {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public LoggingService(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void logAction(int userId, String action, String controller) {
		String sql = "INSERT INTO action_log (user_id, action_performed, controller_name, timestamp) VALUES (?, ?, ?, ?)";
		jdbcTemplate.update(sql, userId, action, controller, Timestamp.valueOf(LocalDateTime.now())); // Convert
																										// LocalDateTime
																										// to Timestamp
	}

	public List<ActionLog> getActionLogForOwner(int ownerUserId) {
		String sql = "SELECT * FROM action_log WHERE user_id = ? ORDER BY timestamp DESC";
		return jdbcTemplate.query(sql, new ActionLogRowMapper(), ownerUserId);
	}

	private static class ActionLogRowMapper implements org.springframework.jdbc.core.RowMapper<ActionLog> {
		@Override
		public ActionLog mapRow(java.sql.ResultSet rs, int rowNum) throws java.sql.SQLException {
			ActionLog log = new ActionLog();
			log.setLogId(rs.getInt("log_id"));
			log.setUserId(rs.getInt("user_id"));
			log.setActionPerformed(rs.getString("action_performed"));
			log.setControllerName(rs.getString("controller_name"));
			log.setTimestamp(rs.getTimestamp("timestamp")); // Fetch as Timestamp, it will be automatically converted to
															// Date
			return log;
		}
	}
}