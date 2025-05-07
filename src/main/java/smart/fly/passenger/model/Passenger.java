package smart.fly.passenger.model;

import java.util.List;

import smart.fly.booking.model.Booking;
import smart.fly.user.model.User;

public class Passenger {
	private int passengerId;
	private String name;
	private String email;
	private String phone;
	private int loyaltyPoints;
	private boolean isRegistered;
	private String linkReqId;
	private int age;

	public Passenger(String name, String email, int age) {
		super();
		this.name = name;
		this.email = email;
		this.age = age;
	}

	public Passenger(String name, String email) {
		super();
		this.name = name;
		this.email = email;
	}

	// Object references
	private User user;
	private List<Booking> bookings;

	// Constructors
	public Passenger() {
	}

	public Passenger(int passengerId, String name, String email, String phone, int loyaltyPoints, boolean isRegistered,
			String linkReqId) {
		this.passengerId = passengerId;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.loyaltyPoints = loyaltyPoints;
		this.isRegistered = isRegistered;
		this.linkReqId = linkReqId;
	}

	public int getPassengerId() {
		return passengerId;
	}

	public void setPassengerId(int passengerId) {
		this.passengerId = passengerId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getLoyaltyPoints() {
		return loyaltyPoints;
	}

	public void setLoyaltyPoints(int loyaltyPoints) {
		this.loyaltyPoints = loyaltyPoints;
	}

	public boolean isRegistered() {
		return isRegistered;
	}

	public void setRegistered(boolean isRegistered) {
		this.isRegistered = isRegistered;
	}

	public String getLinkReqId() {
		return linkReqId;
	}

	public void setLinkReqId(String linkReqId) {
		this.linkReqId = linkReqId;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Booking> getBookings() {
		return bookings;
	}

	public void setBookings(List<Booking> bookings) {
		this.bookings = bookings;
	}

}
