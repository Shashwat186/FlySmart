package smart.fly.flightmanager.repository;

import java.util.List;


import smart.fly.flightmanager.model.FlightManager;

public interface FlightManagerRepository {
	FlightManager findById(int fmId);

	FlightManager findByUserId(int userId);

	List<FlightManager> findByBusinessOwner(int boId);

	FlightManager save(FlightManager flightManager);

	void update(FlightManager flightManager);

	void changePassword(int fmId, String newPasswordHash, String newSalt);

	void assignToBusinessOwner(int fmId, int boId);

	List<FlightManager> findAll();

	List<FlightManager> getManagedFlightManagers(int boId);

}