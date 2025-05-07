package smart.fly.feedback.model;


import java.time.LocalDateTime;

import smart.fly.businness.owner.model.BusinessOwner;
import smart.fly.user.model.User;

public class Feedback {
	private int feedbackId;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public String getFeedbackContent() {
		return feedbackContent;
	}

	public void setFeedbackContent(String feedbackContent) {
		this.feedbackContent = feedbackContent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	private LocalDateTime feedbackDateTime;
	private int rating; // 1-5
	private String comments;

	private int userId;
	private int bookingId;

	private String feedbackContent;
	private String status; // 'unchecked' or 'checked'

	public Feedback(int userId, int bookingId, int rating, String feedbackContent) {
		this.userId = userId;
		this.bookingId = bookingId;
		this.rating = rating;
		this.feedbackContent = feedbackContent;
		this.status = "unchecked";
		this.feedbackDateTime = LocalDateTime.now();
	}

	// Object references
	private User user;
	private BusinessOwner businessOwner;

	public Feedback() {
	}

	public int getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(int feedbackId) {
		this.feedbackId = feedbackId;
	}

	public LocalDateTime getFeedbackDateTime() {
		return feedbackDateTime;
	}

	public void setFeedbackDateTime(LocalDateTime feedbackDateTime) {
		this.feedbackDateTime = feedbackDateTime;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public BusinessOwner getBusinessOwner() {
		return businessOwner;
	}

	public void setBusinessOwner(BusinessOwner businessOwner) {
		this.businessOwner = businessOwner;
	}

}
