package smart.fly.seatclass.repository;

import java.util.List;

import smart.fly.seatclass.model.SeatClass;

public interface SeatClassRepository {
	SeatClass findById(int seatClassId);

	List<SeatClass> findAll();

	void save(SeatClass seatClass);

	void updatePrice(int seatClassId, double newPrice);

	SeatClass findByName(String className);

	List<SeatClass> findByFlightIdWithAvailableSeats(int flightId);

	public Integer getAvailableSeatsForFlightSeatClass(int flightId, Integer SeatClassId);
}