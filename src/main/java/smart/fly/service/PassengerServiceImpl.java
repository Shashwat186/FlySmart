
package smart.fly.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import smart.fly.exception.AuthenticationException;
import smart.fly.passenger.model.Passenger;
import smart.fly.passenger.repository.PassengerRepository;
import smart.fly.user.model.User;
import smart.fly.user.repository.UserRepository;
import smart.fly.util.ValidationUtil;
import java.util.List;

@Service
@Transactional
public class PassengerServiceImpl implements PassengerService {

	private final PassengerRepository passengerRepository;
	private final UserRepository userRepository;

	public PassengerServiceImpl(PassengerRepository passengerRepository, UserRepository userRepository) {
		this.passengerRepository = passengerRepository;
		this.userRepository = userRepository;
	}

	@Override
	public Passenger save(Passenger passenger) {
		ValidationUtil.validateEmail(passenger.getEmail());
		ValidationUtil.validatePhone(passenger.getPhone());
		passengerRepository.save(passenger);
		return passenger;
	}

	@Override
	public Passenger registerPassenger(Passenger passenger, User user, String password) throws AuthenticationException {
		ValidationUtil.validateEmail(user.getEmail());
		ValidationUtil.validatePhone(user.getPhone());
		if (userRepository.emailExists(user.getEmail())) {
			throw new AuthenticationException("Email already registered");
		}

		user.setRole("PASSENGER");
		User savedUser = userRepository.save(user);

		passenger.setUser(savedUser);
		passenger.setRegistered(true);
		return save(passenger);
	}

	@Override
	public Passenger findByUserId(int userId) throws AuthenticationException {
		Passenger passenger = passengerRepository.findByUserId(userId);
		if (passenger == null) {
			throw new AuthenticationException("Passenger profile not found");
		}
		return passenger;
	}

	@Override
	public Passenger addUnregisteredPassenger(Passenger passenger) {
		ValidationUtil.validateEmail(passenger.getEmail());
		ValidationUtil.validatePhone(passenger.getPhone());
		passenger.setRegistered(false);
		return save(passenger);
	}

	@Override
	public void linkToRegisteredUser(int passengerId, int userId) throws AuthenticationException {
		Passenger passenger = passengerRepository.findById(passengerId);
		if (passenger == null) {
			throw new AuthenticationException("Passenger not found");
		}
		User user = userRepository.findById(userId);
		if (user == null) {
			throw new AuthenticationException("User not found");
		}
		passengerRepository.linkToUser(passengerId, userId);
	}

	@Override
	public void updatePassengerProfile(Passenger passenger) throws AuthenticationException {
		Passenger existing = passengerRepository.findById(passenger.getPassengerId());
		if (existing == null) {
			throw new AuthenticationException("Passenger not found");
		}
		passenger.setRegistered(existing.isRegistered());
		passenger.setUser(existing.getUser());
		passengerRepository.update(passenger);
	}

	@Override
	public Passenger findById(int passengerId) throws AuthenticationException {
		Passenger passenger = passengerRepository.findById(passengerId);
		if (passenger == null) {
			throw new AuthenticationException("Passenger not found");
		}
		return passenger;
	}

	@Override
	public Passenger findByEmail(String email) {
		return passengerRepository.findByEmail(email);
	}

	@Override
	public Passenger findByPhone(String phone) {
		return passengerRepository.findByPhone(phone);
	}

	@Override
	public Passenger ensurePassengerProfile(User user) {
		Passenger passenger = passengerRepository.findByUserId(user.getUserId());
		if (passenger == null) {
			passenger = new Passenger();
			passenger.setName(user.getName());
			passenger.setEmail(user.getEmail());
			passenger.setPhone(user.getPhone());
			passenger.setUser(user);
			passenger.setRegistered(true);
			return save(passenger);
		}
		return passenger;
	}

	@Override
	public List<Passenger> findUnregisteredPassengers() {
		return passengerRepository.findUnregisteredPassengers();
	}

	@Override
	public List<Passenger> getAllPassengers() {
		return passengerRepository.findAll();
	}

	@Override
	public int countRegisteredPassengers() {
		return passengerRepository.countRegisteredPassengers();
	}

	@Override
	public int countTotalPassengers() {
		return passengerRepository.countTotalPassengers();
	}
}
