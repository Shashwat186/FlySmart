package smart.fly.service;
 
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
 
import java.util.Arrays;
import java.util.List;
 
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
 
import smart.fly.feedback.model.Feedback;
import smart.fly.feedback.repository.FeedbackRepository;
 
@ExtendWith(MockitoExtension.class)
class FeedbackServiceTest {
 
    @Mock
    private FeedbackRepository feedbackRepository;
    
    @InjectMocks
    private FeedbackService feedbackService;
    
    private final int testUserId = 1;
    private final int testBookingId = 100;
    private final int testRating = 5;
    private final String testContent = "Great service, would recommend!";
    
    @BeforeEach
    void setUp() {
        // Common setup if needed
    }
    
    @Test
    void submitFeedback_Success() {
        // Arrange
        when(feedbackRepository.checkFeedbackExists(testUserId, testBookingId)).thenReturn(false);
        when(feedbackRepository.addFeedback(any(Feedback.class))).thenReturn(true);
        
        // Act
        boolean result = feedbackService.submitFeedback(testUserId, testBookingId, testRating, testContent);
        
        // Assert
        assertTrue(result);
        verify(feedbackRepository).checkFeedbackExists(testUserId, testBookingId);
        verify(feedbackRepository).addFeedback(argThat(feedback ->
            feedback.getUserId() == testUserId &&
            feedback.getBookingId() == testBookingId &&
            feedback.getRating() == testRating &&
            feedback.getFeedbackContent().equals(testContent)
        ));
    }
    
    @Test
    void submitFeedback_AlreadyExists() {
        // Arrange
        when(feedbackRepository.checkFeedbackExists(testUserId, testBookingId)).thenReturn(true);
        
        // Act
        boolean result = feedbackService.submitFeedback(testUserId, testBookingId, testRating, testContent);
        
        // Assert
        assertFalse(result);
        verify(feedbackRepository).checkFeedbackExists(testUserId, testBookingId);
        verify(feedbackRepository, never()).addFeedback(any(Feedback.class));
    }
    
    @Test
    void hasFeedbackForBooking_True() {
        // Arrange
        when(feedbackRepository.checkFeedbackExists(testUserId, testBookingId)).thenReturn(true);
        
        // Act
        boolean result = feedbackService.hasFeedbackForBooking(testUserId, testBookingId);
        
        // Assert
        assertTrue(result);
        verify(feedbackRepository).checkFeedbackExists(testUserId, testBookingId);
    }
    
    @Test
    void hasFeedbackForBooking_False() {
        // Arrange
        when(feedbackRepository.checkFeedbackExists(testUserId, testBookingId)).thenReturn(false);
        
        // Act
        boolean result = feedbackService.hasFeedbackForBooking(testUserId, testBookingId);
        
        // Assert
        assertFalse(result);
        verify(feedbackRepository).checkFeedbackExists(testUserId, testBookingId);
    }
    
    @Test
    void getBookingsWithFeedback_Success() {
        // Arrange
        List<Integer> expectedBookings = Arrays.asList(100, 101, 102);
        when(feedbackRepository.getBookingsWithFeedback(testUserId)).thenReturn(expectedBookings);
        
        // Act
        List<Integer> result = feedbackService.getBookingsWithFeedback(testUserId);
        
        // Assert
        assertNotNull(result);
        assertEquals(expectedBookings.size(), result.size());
        assertEquals(expectedBookings, result);
        verify(feedbackRepository).getBookingsWithFeedback(testUserId);
    }
    
    @Test
    void getBookingsWithFeedback_EmptyList() {
        // Arrange
        List<Integer> expectedBookings = Arrays.asList();
        when(feedbackRepository.getBookingsWithFeedback(testUserId)).thenReturn(expectedBookings);
        
        // Act
        List<Integer> result = feedbackService.getBookingsWithFeedback(testUserId);
        
        // Assert
        assertNotNull(result);
        assertTrue(result.isEmpty());
        verify(feedbackRepository).getBookingsWithFeedback(testUserId);
    }
}