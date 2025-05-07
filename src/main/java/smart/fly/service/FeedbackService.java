package smart.fly.service;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import smart.fly.businness.owner.repository.BusinessOwnerRepository;
import smart.fly.exception.FeedbackException;
import smart.fly.feedback.model.Feedback;
import smart.fly.feedback.repository.FeedbackRepository;
import smart.fly.user.repository.UserRepository;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
 
@Service
public class FeedbackService {
 
	private final FeedbackRepository feedbackRepository;
	 
    public FeedbackService(FeedbackRepository feedbackRepository) {
        this.feedbackRepository = feedbackRepository;
    }
 
    public boolean submitFeedback(int userId, int bookingId, int rating, String feedbackContent) {
        // Check if feedback already exists for this booking
        if (hasFeedbackForBooking(userId, bookingId)) {
            return false; 
        }
        
        Feedback feedback = new Feedback(userId, bookingId, rating, feedbackContent);
        return feedbackRepository.addFeedback(feedback);
    }
     
    public boolean hasFeedbackForBooking(int userId, int bookingId) {
        return feedbackRepository.checkFeedbackExists(userId, bookingId);
    }
     
    public List<Integer> getBookingsWithFeedback(int userId) {
        return feedbackRepository.getBookingsWithFeedback(userId);
    }
}
 