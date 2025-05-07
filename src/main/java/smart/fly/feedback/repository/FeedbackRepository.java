package smart.fly.feedback.repository;
 
import java.util.List;

import smart.fly.dto.FeedbackDTO;
import smart.fly.feedback.model.Feedback;
 
public interface FeedbackRepository {

	List<Feedback> getFeedbacksByUser(int userId);

	boolean addFeedback(Feedback feedback);

	boolean checkFeedbackExists(int userId, int bookingId);

	List<Integer> getBookingsWithFeedback(int userId);

	List<FeedbackDTO> getAllFeedbackWithFlightDetails();

	void updateFeedbackStatus(int feedbackId, String status);
	
}