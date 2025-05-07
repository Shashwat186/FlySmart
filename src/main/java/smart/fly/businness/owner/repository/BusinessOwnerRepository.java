package smart.fly.businness.owner.repository;

import java.util.List;

import smart.fly.businness.owner.model.BusinessOwner;
import smart.fly.flightmanager.model.FlightManager;

public interface BusinessOwnerRepository {
	BusinessOwner findById(int boId);

	BusinessOwner findByUserId(int userId);

	List<BusinessOwner> findAll();

	void save(BusinessOwner businessOwner);

	void addFlightManager(int boId, int fmId);

	List<Integer> getManagedFlightManagerIds(int boId);

	int getFlightCount(int boId);

}