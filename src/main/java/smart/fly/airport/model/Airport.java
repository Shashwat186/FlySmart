package smart.fly.airport.model;

import java.util.List;

import smart.fly.flight.model.Flight;

public class Airport {
	private int airportId;
	private String name;
	private String code;
	private String contactInfo;
	private String location;

	// Object references
	private List<Flight> departingFlights;
	private List<Flight> arrivingFlights;

	
	public Airport() {
	}

	public Airport(int airportId, String name, String code, String contactInfo, String location) {
		this.airportId = airportId;
		this.name = name;
		this.code = code;
		this.contactInfo = contactInfo;
		this.location = location;
	}

	
	public int getAirportId() {
		return airportId;
	}

	public void setAirportId(int airportId) {
		this.airportId = airportId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContactInfo() {
		return contactInfo;
	}

	public void setContactInfo(String contactInfo) {
		this.contactInfo = contactInfo;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public List<Flight> getDepartingFlights() {
		return departingFlights;
	}

	public void setDepartingFlights(List<Flight> departingFlights) {
		this.departingFlights = departingFlights;
	}

	public List<Flight> getArrivingFlights() {
		return arrivingFlights;
	}

	public void setArrivingFlights(List<Flight> arrivingFlights) {
		this.arrivingFlights = arrivingFlights;
	}
}
