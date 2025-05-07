package smart.fly.airline.model;
 
import java.util.List;

import smart.fly.flight.model.Flight;
 
public class Airline {
    private int airlineId;
    private String name;
    private String code;
    private String contactInfo;
    
    // Object references
    private List<Flight> flights;
 
    
    public Airline() {}
    
    public Airline(int airlineId, String name, String code, String contactInfo) {
        this.airlineId = airlineId;
        this.name = name;
        this.code = code;
        this.contactInfo = contactInfo;
    }

	public int getAirlineId() {
		return airlineId;
	}

	public void setAirlineId(int airlineId) {
		this.airlineId = airlineId;
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

	public List<Flight> getFlights() {
		return flights;
	}

	public void setFlights(List<Flight> flights) {
		this.flights = flights;
	}
 
   

    
}
 