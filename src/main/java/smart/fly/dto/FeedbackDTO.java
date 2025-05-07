package smart.fly.dto;

import java.time.LocalDateTime;

public class FeedbackDTO {
	   private int feedbackId;
	    private int userId;
	    private String userName;
	    private LocalDateTime feedbackDateTime;
	    private int rating;
	    private String feedbackContent;
	    private String status;
	    private int bookingId;
	    private int flightId;
	    private String flightNumber;
	    private String airlineName;
	    private String departureAirportName;
	    private String departureAirportCode;
	    private String arrivalAirportName;
	    private String arrivalAirportCode;
	    private LocalDateTime departureDateTime;
	    private LocalDateTime arrivalDateTime;
		public int getFeedbackId() {
			return feedbackId;
		}
		public void setFeedbackId(int feedbackId) {
			this.feedbackId = feedbackId;
		}
		public int getUserId() {
			return userId;
		}
		public void setUserId(int userId) {
			this.userId = userId;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
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
		public int getBookingId() {
			return bookingId;
		}
		public void setBookingId(int bookingId) {
			this.bookingId = bookingId;
		}
		public int getFlightId() {
			return flightId;
		}
		public void setFlightId(int flightId) {
			this.flightId = flightId;
		}
		public String getFlightNumber() {
			return flightNumber;
		}
		public void setFlightNumber(String flightNumber) {
			this.flightNumber = flightNumber;
		}
		public String getAirlineName() {
			return airlineName;
		}
		public void setAirlineName(String airlineName) {
			this.airlineName = airlineName;
		}
		public String getDepartureAirportName() {
			return departureAirportName;
		}
		public void setDepartureAirportName(String departureAirportName) {
			this.departureAirportName = departureAirportName;
		}
		public String getDepartureAirportCode() {
			return departureAirportCode;
		}
		public void setDepartureAirportCode(String departureAirportCode) {
			this.departureAirportCode = departureAirportCode;
		}
		public String getArrivalAirportName() {
			return arrivalAirportName;
		}
		public void setArrivalAirportName(String arrivalAirportName) {
			this.arrivalAirportName = arrivalAirportName;
		}
		public String getArrivalAirportCode() {
			return arrivalAirportCode;
		}
		public void setArrivalAirportCode(String arrivalAirportCode) {
			this.arrivalAirportCode = arrivalAirportCode;
		}
		public LocalDateTime getDepartureDateTime() {
			return departureDateTime;
		}
		public void setDepartureDateTime(LocalDateTime departureDateTime) {
			this.departureDateTime = departureDateTime;
		}
		public LocalDateTime getArrivalDateTime() {
			return arrivalDateTime;
		}
		public void setArrivalDateTime(LocalDateTime arrivalDateTime) {
			this.arrivalDateTime = arrivalDateTime;
		}
}
