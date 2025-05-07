package smart.fly.booking.model;

import java.sql.Timestamp;

import smart.fly.flight.model.Flight;
import smart.fly.passenger.model.Passenger;
import smart.fly.payment.model.Payment;
import smart.fly.seatclass.model.SeatClass;

public class Booking {
	private int bookingId;
	private Timestamp bookingDateTime;
	private int numberOfSeats;
	private double totalPrice;
	int userId;
	private int NumberOfAdults;
	private int NumberOfChildren;
	private String status;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getNumberOfAdults() {
		return NumberOfAdults;
	}

	public void setNumberOfAdults(int numberOfAdults) {
		NumberOfAdults = numberOfAdults;
	}

	public int getNumberOfChildren() {
		return NumberOfChildren;
	}

	public void setNumberOfChildren(int numberOfChildren) {
		NumberOfChildren = numberOfChildren;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	// Object references
	private Passenger passenger;
	private Flight flight;
	private SeatClass seatClass;
	private Payment payment;

	
	public Booking() {
	}

	public Booking(int bookingId, Timestamp bookingDateTime, int numberOfSeats, double totalPrice) {
		this.bookingId = bookingId;
		this.bookingDateTime = bookingDateTime;
		this.numberOfSeats = numberOfSeats;
		this.totalPrice = totalPrice;
	}

	public Booking(int bookingId, Timestamp bookingDateTime, int numberOfSeats, double totalPrice, int userId,
			int numberOfAdults, int numberOfChildren, String status, Passenger passenger, Flight flight,
			SeatClass seatClass, Payment payment) {
		super();
		this.bookingId = bookingId;
		this.bookingDateTime = bookingDateTime;
		this.numberOfSeats = numberOfSeats;
		this.totalPrice = totalPrice;
		this.userId = userId;
		NumberOfAdults = numberOfAdults;
		NumberOfChildren = numberOfChildren;
		this.status = status;
		this.passenger = passenger;
		this.flight = flight;
		this.seatClass = seatClass;
		this.payment = payment;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public Timestamp getBookingDateTime() {
		return bookingDateTime;
	}

	public void setBookingDateTime(Timestamp bookingDateTime) {
		this.bookingDateTime = bookingDateTime;
	}

	public int getNumberOfSeats() {
		return numberOfSeats;
	}

	public void setNumberOfSeats(int numberOfSeats) {
		this.numberOfSeats = numberOfSeats;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Passenger getPassenger() {
		return passenger;
	}

	public void setPassenger(Passenger passenger) {
		this.passenger = passenger;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	public SeatClass getSeatClass() {
		return seatClass;
	}

	public void setSeatClass(SeatClass seatClass) {
		this.seatClass = seatClass;
	}

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}



}
