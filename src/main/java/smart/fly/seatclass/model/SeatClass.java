package smart.fly.seatclass.model;

import java.util.List;
import smart.fly.booking.model.Booking;
import smart.fly.flight.seats.model.FlightSeats;

public class SeatClass {
	private Integer seatClassId;
	private String name; // Changed from ClassName to name
	private double price;
	private List<FlightSeats> flightSeats;
	private List<Booking> bookings;

	public SeatClass() {
		super();
	}

	public SeatClass(Integer seatClassId, String name, double price, List<FlightSeats> flightSeats,
			List<Booking> bookings) {
		super();
		this.seatClassId = seatClassId;
		this.name = name;
		this.price = price;
		this.flightSeats = flightSeats;
		this.bookings = bookings;
	}

	public Integer getSeatClassId() {
		return seatClassId;
	}

	public void setSeatClassId(Integer seatClassId) {
		this.seatClassId = seatClassId;
	}

	public String getName() { // Changed getter from getClassName to getName
		return name;
	}

	public void setName(String name) { // Changed setter from setClassName to setName
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public List<FlightSeats> getFlightSeats() {
		return flightSeats;
	}

	public void setFlightSeats(List<FlightSeats> flightSeats) {
		this.flightSeats = flightSeats;
	}

	public List<Booking> getBookings() {
		return bookings;
	}

	public void setBookings(List<Booking> bookings) {
		this.bookings = bookings;
	}
}