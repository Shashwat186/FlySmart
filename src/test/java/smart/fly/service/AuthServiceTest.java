package smart.fly.service;
 
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.sql.DataSource;
 
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 
import smart.fly.exception.AuthenticationException;
import smart.fly.passenger.model.Passenger;
import smart.fly.user.model.User;
import smart.fly.user.repository.UserRepository;
import smart.fly.util.PasswordUtil;
 
@ExtendWith(MockitoExtension.class)
class AuthServiceTest {
 
    @Mock
    private UserRepository userRepository;
    
    @Mock
    private PasswordUtil passwordUtil;
    
    @Mock
    private PassengerService passengerService;
    
    @Mock
    private DataSource dataSource;
    
    @Mock
    private Connection connection;
    
    @Mock
    private PreparedStatement preparedStatement;
    
    @InjectMocks
    private AuthService authService;
    
    private User testUser;
    private final String testEmail = "test@example.com";
    private final String testPassword = "password123";
    private final String testSalt = "salt123";
    private final String testHash = "hashedPassword123";
    
    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setUserId(1);
        testUser.setEmail(testEmail);
        testUser.setPasswordHash(testHash);
        testUser.setPasswordSalt(testSalt);
        testUser.setName("Test User");
        testUser.setPhone("1234567890");
    }
    
    @Test
    void authenticate_Success() throws AuthenticationException {
        when(userRepository.findByEmail(testEmail)).thenReturn(testUser);
        when(passwordUtil.verifyPassword(testPassword, testHash, testSalt)).thenReturn(true);
        
        User result = authService.authenticate(testEmail, testPassword);
        
        assertNotNull(result);
        assertEquals(testEmail, result.getEmail());
        verify(userRepository).findByEmail(testEmail);
        verify(passwordUtil).verifyPassword(testPassword, testHash, testSalt);
    }
    
    @Test
    void authenticate_UserNotFound() {
        when(userRepository.findByEmail(testEmail)).thenReturn(null);
        
        assertThrows(AuthenticationException.class, () -> {
            authService.authenticate(testEmail, testPassword);
        });
        
        verify(userRepository).findByEmail(testEmail);
    }
    
    @Test
    void authenticate_PasswordMismatch() {
        when(userRepository.findByEmail(testEmail)).thenReturn(testUser);
        when(passwordUtil.verifyPassword(testPassword, testHash, testSalt)).thenReturn(false);
        
        assertThrows(AuthenticationException.class, () -> {
            authService.authenticate(testEmail, testPassword);
        });
        
        verify(userRepository).findByEmail(testEmail);
        verify(passwordUtil).verifyPassword(testPassword, testHash, testSalt);
    }
    
    @Test
    void registerUser_Success() {
        String newPassword = "newPassword123";
        String newSalt = "newSalt123";
        String newHash = "newHash123";
        
        when(passwordUtil.generateSalt()).thenReturn(newSalt);
        when(passwordUtil.hashPassword(newPassword, newSalt)).thenReturn(newHash);
        when(userRepository.save(testUser)).thenReturn(testUser);
        
        User result = authService.registerUser(testUser, newPassword);
        
        assertNotNull(result);
        assertEquals(newHash, result.getPasswordHash());
        assertEquals(newSalt, result.getPasswordSalt());
        verify(passwordUtil).generateSalt();
        verify(passwordUtil).hashPassword(newPassword, newSalt);
        verify(userRepository).save(testUser);
    }
    
    @Test
    void changePassword_Success() throws SQLException, AuthenticationException {
        String currentPassword = "current123";
        String newPassword = "newPassword123";
        String newSalt = "newSalt123";
        String newHash = "newHash123";
        
        when(passwordUtil.verifyPassword(currentPassword, testHash, testSalt)).thenReturn(true);
        when(passwordUtil.generateSalt()).thenReturn(newSalt);
        when(passwordUtil.hashPassword(newPassword, newSalt)).thenReturn(newHash);
        when(dataSource.getConnection()).thenReturn(connection);
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);
        
        authService.changePassword(testUser, currentPassword, newPassword);
        
        assertEquals(newHash, testUser.getPasswordHash());
        assertEquals(newSalt, testUser.getPasswordSalt());
        verify(passwordUtil).verifyPassword(currentPassword, testHash, testSalt);
        verify(passwordUtil).generateSalt();
        verify(passwordUtil).hashPassword(newPassword, newSalt);
        verify(preparedStatement).setString(1, newHash);
        verify(preparedStatement).setString(2, newSalt);
        verify(preparedStatement).setLong(3, testUser.getUserId());
        verify(preparedStatement).executeUpdate();
    }
    
    @Test
    void changePassword_CurrentPasswordIncorrect() {
        String currentPassword = "wrongPassword";
        String newPassword = "newPassword123";
        
        when(passwordUtil.verifyPassword(currentPassword, testHash, testSalt)).thenReturn(false);
        
        assertThrows(AuthenticationException.class, () -> {
            authService.changePassword(testUser, currentPassword, newPassword);
        });
        
        verify(passwordUtil).verifyPassword(currentPassword, testHash, testSalt);
    }
    
    @Test
    void changePassword_DatabaseError() throws SQLException {
        String currentPassword = "current123";
        String newPassword = "newPassword123";
        String newSalt = "newSalt123";
        String newHash = "newHash123";
        
        when(passwordUtil.verifyPassword(currentPassword, testHash, testSalt)).thenReturn(true);
        when(passwordUtil.generateSalt()).thenReturn(newSalt);
        when(passwordUtil.hashPassword(newPassword, newSalt)).thenReturn(newHash);
        when(dataSource.getConnection()).thenThrow(new SQLException("Database error"));
        
        assertThrows(AuthenticationException.class, () -> {
            authService.changePassword(testUser, currentPassword, newPassword);
        });
        
        verify(passwordUtil).verifyPassword(currentPassword, testHash, testSalt);
        verify(passwordUtil).generateSalt();
        verify(passwordUtil).hashPassword(newPassword, newSalt);
    }
    
    @Test
    void changePassword_UpdateFailed() throws SQLException {
        String currentPassword = "current123";
        String newPassword = "newPassword123";
        String newSalt = "newSalt123";
        String newHash = "newHash123";
        
        when(passwordUtil.verifyPassword(currentPassword, testHash, testSalt)).thenReturn(true);
        when(passwordUtil.generateSalt()).thenReturn(newSalt);
        when(passwordUtil.hashPassword(newPassword, newSalt)).thenReturn(newHash);
        when(dataSource.getConnection()).thenReturn(connection);
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(0);
        
        assertThrows(AuthenticationException.class, () -> {
            authService.changePassword(testUser, currentPassword, newPassword);
        });
        
        verify(passwordUtil).verifyPassword(currentPassword, testHash, testSalt);
        verify(passwordUtil).generateSalt();
        verify(passwordUtil).hashPassword(newPassword, newSalt);
        verify(preparedStatement).executeUpdate();
    }
    
    @Test
    void debugAuth_Success() {
        when(passwordUtil.hashPassword("debug123", "staticSalt")).thenReturn("debugHash");
        
        User result = authService.debugAuth();
        
        assertNotNull(result);
        assertEquals("debug@example.com", result.getEmail());
        assertEquals("debugHash", result.getPasswordHash());
        assertEquals("staticSalt", result.getPasswordSalt());
        assertEquals("PASSENGER", result.getRole());
        verify(passwordUtil).hashPassword("debug123", "staticSalt");
    }
}