package smart.fly.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import smart.fly.util.PasswordUtil;

@Service
public class PasswordResetService {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private UserService userService; // Your existing user service
    
    @Autowired
    private PasswordUtil passwordUtil;
    public void createResetToken(String email) {
        // Generate token
        String token = UUID.randomUUID().toString();
        System.out.println("Password reset token generated for " + email + ": " + token);
        
        // Set expiry to 1 hour from now
        java.sql.Timestamp expiry = new java.sql.Timestamp(
            System.currentTimeMillis() + 3600000); // 1 hour in milliseconds
        
        // Delete any existing tokens for this email
        jdbcTemplate.update(
            "DELETE FROM password_reset_tokens WHERE email = ?",
            email);
        
        // Insert new token
        jdbcTemplate.update(
            "INSERT INTO password_reset_tokens (email, token, expiry_date) VALUES (?, ?, ?)",
            email, token, expiry);
    }
    
    public boolean updatePassword(String email, String newPassword) {
        try {
            // Generate new salt
            String salt = passwordUtil.generateSalt();
            
            // Hash the new password
            String hashedPassword = passwordUtil.hashPassword(newPassword, salt);
            
            // Update the password in your users table
            int rowsUpdated = jdbcTemplate.update(
                "UPDATE user SET password_hash = ?, password_salt = ? WHERE email = ?",
                hashedPassword, salt, email);
            
            return rowsUpdated > 0;
        } catch (Exception e) {
            System.err.println("Error updating password: " + e.getMessage());
            return false;
        }
    }
    
    public boolean validateToken(String token) {
        try {
            String sql = "SELECT email, expiry_date FROM password_reset_tokens WHERE token = ?";
            Map<String, Object> result = jdbcTemplate.queryForMap(sql, token);
            
            // Handle both Timestamp and LocalDateTime
            Object expiryObj = result.get("expiry_date");
            java.time.LocalDateTime expiry;
            
            if (expiryObj instanceof java.sql.Timestamp) {
                expiry = ((java.sql.Timestamp) expiryObj).toLocalDateTime();
            } else if (expiryObj instanceof java.time.LocalDateTime) {
                expiry = (java.time.LocalDateTime) expiryObj;
            } else {
                // Handle unexpected type
                return false;
            }
            
            // Check if token is expired
            if (expiry.isBefore(java.time.LocalDateTime.now())) {
                return false;
            }
            return true;
        } catch (EmptyResultDataAccessException e) {
            return false; // Token not found
        }
    }
    
    public String getEmailFromToken(String token) {
        try {
            String sql = "SELECT email FROM password_reset_tokens WHERE token = ?";
            return jdbcTemplate.queryForObject(sql, String.class, token);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public void deleteToken(String token) {
        jdbcTemplate.update("DELETE FROM password_reset_tokens WHERE token = ?", token);
    }
}