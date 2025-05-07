package smart.fly.service;

import smart.fly.exception.AuthenticationException;
import smart.fly.passenger.model.Passenger;
import smart.fly.user.model.User;

import java.util.List;

public interface PassengerService {
	Passenger save(Passenger passenger);

	Passenger registerPassenger(Passenger passenger, User user, String password) throws AuthenticationException;

	Passenger findByUserId(int userId) throws AuthenticationException;

	Passenger addUnregisteredPassenger(Passenger passenger);

	void linkToRegisteredUser(int passengerId, int userId) throws AuthenticationException;

	void updatePassengerProfile(Passenger passenger) throws AuthenticationException;

	Passenger findById(int passengerId) throws AuthenticationException;

	Passenger findByEmail(String email);

	Passenger findByPhone(String phone);

	Passenger ensurePassengerProfile(User user);

	List<Passenger> findUnregisteredPassengers();

	List<Passenger> getAllPassengers();

	int countRegisteredPassengers();

	int countTotalPassengers();
}
