package smart.fly.flightmanager.model;

import java.util.List;

import smart.fly.businness.owner.model.BusinessOwner;
import smart.fly.flight.model.Flight;
import smart.fly.user.model.User;

public class FlightManager {
	private int fmId;

	private User user;
	private BusinessOwner businessOwner;
	private List<Flight> managedFlights;

	public FlightManager() {
	}

	public FlightManager(int fmId) {
		this.fmId = fmId;
	}

	public int getFmId() {
		return fmId;
	}

	public void setFmId(int fmId) {
		this.fmId = fmId;
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

	public List<Flight> getManagedFlights() {
		return managedFlights;
	}

	public void setManagedFlights(List<Flight> managedFlights) {
		this.managedFlights = managedFlights;
	}

}
