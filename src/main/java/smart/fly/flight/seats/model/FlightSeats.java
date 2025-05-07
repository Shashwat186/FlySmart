package smart.fly.flight.seats.model;

import smart.fly.flight.model.Flight;
import smart.fly.seatclass.model.SeatClass;

public class FlightSeats {
    private int flightSeatId;
    private int availableSeats;
    private int totalSeats;
    private double price;
    
    // Object references
    private Flight flight;
    private SeatClass seatClass;
 
    // Constructors
    public FlightSeats() {}
    
    public FlightSeats(int flightSeatId, int availableSeats, int totalSeats, double price) {
        this.flightSeatId = flightSeatId;
        this.availableSeats = availableSeats;
        this.totalSeats = totalSeats;
        this.price = price;
    }

	public int getFlightSeatId() {
		return flightSeatId;
	}

	public void setFlightSeatId(int flightSeatId) {
		this.flightSeatId = flightSeatId;
	}

	public int getAvailableSeats() {
		return availableSeats;
	}

	public void setAvailableSeats(int availableSeats) {
		this.availableSeats = availableSeats;
	}

	public int getTotalSeats() {
		return totalSeats;
	}

	public void setTotalSeats(int totalSeats) {
		this.totalSeats = totalSeats;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
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
 
    // Getters and setters
    
//    public int getFlightSeatId() { return flightSeatId; }
//    public void setFlightSeatId(int flightSeatId) { this.flightSeatId = flightSeatId; }
//    public int getAvailableSeats() { return availableSeats; }
//    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
//    public int getTotalSeats() { return totalSeats; }
//    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }
//    public double getPrice() { return price; }
//    public void setPrice(double price) { this.price = price; }
//    public Flight getFlight() { return flight; }
//    public void setFlight(Flight flight) { this.flight = flight; }
//    public SeatClass getSeatClass() { return seatClass; }
//    public void setSeatClass(SeatClass seatClass) { this.seatClass = seatClass; }
}
 