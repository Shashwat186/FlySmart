package smart.fly.service;
 
import org.junit.jupiter.api.BeforeEach;

import org.junit.jupiter.api.Test;

import org.junit.jupiter.api.extension.ExtendWith;

import org.mockito.InjectMocks;

import org.mockito.Mock;

import org.mockito.junit.jupiter.MockitoExtension;

import smart.fly.user.model.User;

import smart.fly.user.repository.UserRepository;
 
import java.util.Arrays;

import java.util.List;
 
import static org.junit.jupiter.api.Assertions.*;

import static org.mockito.Mockito.*;
 
@ExtendWith(MockitoExtension.class)

class UserServiceTest {
 
    @Mock

    private UserRepository userRepository;
 
    @InjectMocks

    private UserService userService;
 
    private User testUser;
 
    @BeforeEach

    void setUp() {

        testUser = new User();

        testUser.setUserId(1);

        testUser.setRole("ADMIN");

    }
 
    @Test

    void getUserById_shouldReturnUser_whenUserExists() {

        // Arrange

        when(userRepository.findById(1)).thenReturn(testUser);
 
        // Act

        User result = userService.getUserById(1);
 
        // Assert

        assertNotNull(result);

        assertEquals(testUser, result);

        verify(userRepository, times(1)).findById(1);

    }
 
    @Test

    void getUserById_shouldReturnNull_whenUserDoesNotExist() {

        // Arrange

        when(userRepository.findById(999)).thenReturn(null);
 
        // Act

        User result = userService.getUserById(999);
 
        // Assert

        assertNull(result);

        verify(userRepository, times(1)).findById(999);

    }
 
    @Test

    void getUsersByRole_shouldReturnListOfUsers_whenRoleExists() {

        // Arrange

        List<User> users = Arrays.asList(testUser, new User());

        when(userRepository.findAllByRole("ADMIN")).thenReturn(users);
 
        // Act

        List<User> result = userService.getUsersByRole("ADMIN");
 
        // Assert

        assertNotNull(result);

        assertEquals(2, result.size());

        assertEquals(users, result);

        verify(userRepository, times(1)).findAllByRole("ADMIN");

    }
 
    @Test

    void getUsersByRole_shouldReturnEmptyList_whenNoUsersWithRole() {

        // Arrange

        when(userRepository.findAllByRole("GUEST")).thenReturn(Arrays.asList());
 
        // Act

        List<User> result = userService.getUsersByRole("GUEST");
 
        // Assert

        assertNotNull(result);

        assertTrue(result.isEmpty());

        verify(userRepository, times(1)).findAllByRole("GUEST");

    }
 
    @Test

    void deleteUser_shouldCallRepositoryDelete() {

        // Act

        userService.deleteUser(1);
 
        // Assert

        verify(userRepository, times(1)).delete(1);

    }

}
 