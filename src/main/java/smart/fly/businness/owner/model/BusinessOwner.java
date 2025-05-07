package smart.fly.businness.owner.model;

import java.util.List;

import smart.fly.feedback.model.Feedback;
import smart.fly.flight.model.Flight;
import smart.fly.flightmanager.model.FlightManager;

import smart.fly.user.model.User;

public class BusinessOwner {
	private int boId;

	// Object references
	private User user;
	private List<FlightManager> managedManagers;
	private List<Flight> managedFlights;

	private List<Feedback> receivedFeedback;

	public BusinessOwner() {
	}

	public BusinessOwner(int boId) {
		this.boId = boId;
	}

	public int getBoId() {
		return boId;
	}

	public void setBoId(int boId) {
		this.boId = boId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<FlightManager> getManagedManagers() {
		return managedManagers;
	}

	public void setManagedManagers(List<FlightManager> managedManagers) {
		this.managedManagers = managedManagers;
	}

	public List<Flight> getManagedFlights() {
		return managedFlights;
	}

	public void setManagedFlights(List<Flight> managedFlights) {
		this.managedFlights = managedFlights;
	}

	public List<Feedback> getReceivedFeedback() {
		return receivedFeedback;
	}

	public void setReceivedFeedback(List<Feedback> receivedFeedback) {
		this.receivedFeedback = receivedFeedback;
	}

}
