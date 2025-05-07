package smart.fly.flight.model;

import java.sql.Timestamp;
import java.util.List;

import smart.fly.airline.model.Airline;
import smart.fly.airport.model.Airport;
import smart.fly.flightmanager.model.FlightManager;

public class Flight {
	private int flightId;
	private String flightNumber;
	private Timestamp departureDateTime;
	private Timestamp arrivalDateTime;
	private String status;
	private int fmId; // Changed to lowercase for convention

	public Flight(int flightId, String flightNumber, Timestamp departureDateTime, Timestamp arrivalDateTime,
			String status, int fmId, Airline airline, Airport departureAirport, Airport arrivalAirport,
			FlightManager flightManager) {
		super();
		this.flightId = flightId;
		this.flightNumber = flightNumber;
		this.departureDateTime = departureDateTime;
		this.arrivalDateTime = arrivalDateTime;
		this.status = status;
		this.fmId = fmId;
		this.airline = airline;
		this.departureAirport = departureAirport;
		this.arrivalAirport = arrivalAirport;
		this.flightManager = flightManager;
	}

	public Flight(String flightNumber, Timestamp departureDateTime, Timestamp arrivalDateTime, String status, int fmId,
			Airline airline, Airport departureAirport, Airport arrivalAirport, FlightManager flightManager) {
		super();
		this.flightNumber = flightNumber;
		this.departureDateTime = departureDateTime;
		this.arrivalDateTime = arrivalDateTime;
		this.status = status;
		this.fmId = fmId;
		this.airline = airline;
		this.departureAirport = departureAirport;
		this.arrivalAirport = arrivalAirport;
		this.flightManager = flightManager;
	}

	// Object references (will be populated manually in RowMapper)
	private Airline airline;
	private Airport departureAirport;
	private Airport arrivalAirport;
	private FlightManager flightManager;

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

	public Timestamp getDepartureDateTime() {
		return departureDateTime;
	}

	public void setDepartureDateTime(Timestamp departureDateTime) {
		this.departureDateTime = departureDateTime;
	}

	public Timestamp getArrivalDateTime() {
		return arrivalDateTime;
	}

	public void setArrivalDateTime(Timestamp arrivalDateTime) {
		this.arrivalDateTime = arrivalDateTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getFmId() {
		return fmId;
	}

	public void setFmId(int fmId) {
		this.fmId = fmId;
	}

	public Airline getAirline() {
		return airline;
	}

	public void setAirline(Airline airline) {
		this.airline = airline;
	}

	public Airport getDepartureAirport() {
		return departureAirport;
	}

	public void setDepartureAirport(Airport departureAirport) {
		this.departureAirport = departureAirport;
	}

	public Airport getArrivalAirport() {
		return arrivalAirport;
	}

	public void setArrivalAirport(Airport arrivalAirport) {
		this.arrivalAirport = arrivalAirport;
	}

	public FlightManager getFlightManager() {
		return flightManager;
	}

	public void setFlightManager(FlightManager flightManager) {
		this.flightManager = flightManager;
	}

	public Flight() {
		super();
	}

}