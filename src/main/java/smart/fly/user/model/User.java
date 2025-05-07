package smart.fly.user.model;

import java.sql.Date;
import java.util.List;

import smart.fly.booking.model.Booking;
import smart.fly.businness.owner.model.BusinessOwner;
import smart.fly.feedback.model.Feedback;
import smart.fly.flightmanager.model.FlightManager;
import smart.fly.passenger.model.Passenger;

public class User {
	private int userId;
	private String name;
	private String password;
	private String email;
	private String phone;
	private String role; // "Passenger", "Manager", "Owner"
	private String gender; // "Male", "Female", "Other"
	private Date dob;
	private String passwordHash;
	private String passwordSalt;
	private byte[] profilePhoto;

	// Object references
	private Passenger passengerProfile;
	private BusinessOwner businessOwnerProfile;
	private FlightManager flightManagerProfile;
	private List<Booking> bookings;
	private List<Feedback> feedbacks;

	// Constructors
	public User() {
	}

	public User(int userId, String name, String email, String phone, String role, String gender, Date dob,
			String passwordHash, String passwordSalt, byte[] profilePhoto) {
		this.userId = userId;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.role = role;
		this.gender = gender;
		this.dob = dob;
		this.passwordHash = passwordHash;
		this.passwordSalt = passwordSalt;
		this.profilePhoto = profilePhoto;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public String getPasswordSalt() {
		return passwordSalt;
	}

	public void setPasswordSalt(String passwordSalt) {
		this.passwordSalt = passwordSalt;
	}

	public byte[] getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(byte[] profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

	public Passenger getPassengerProfile() {
		return passengerProfile;
	}

	public void setPassengerProfile(Passenger passengerProfile) {
		this.passengerProfile = passengerProfile;
	}

	public BusinessOwner getBusinessOwnerProfile() {
		return businessOwnerProfile;
	}

	public void setBusinessOwnerProfile(BusinessOwner businessOwnerProfile) {
		this.businessOwnerProfile = businessOwnerProfile;
	}

	public FlightManager getFlightManagerProfile() {
		return flightManagerProfile;
	}

	public void setFlightManagerProfile(FlightManager flightManagerProfile) {
		this.flightManagerProfile = flightManagerProfile;
	}

	public List<Booking> getBookings() {
		return bookings;
	}

	public void setBookings(List<Booking> bookings) {
		this.bookings = bookings;
	}

	public List<Feedback> getFeedbacks() {
		return feedbacks;
	}

	public void setFeedbacks(List<Feedback> feedbacks) {
		this.feedbacks = feedbacks;
	}

}
