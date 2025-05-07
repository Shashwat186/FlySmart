package smart.fly.booking.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import smart.fly.booking.model.Booking;

public interface BookingRepository {
	Booking findById(int bookingId);

	List<Booking> findByPassenger(int passengerId);

	List<Booking> findByFlight(int flightId);

	void save(Booking booking);

	void cancel(int bookingId);

	void updateSeats(int bookingId, int newSeatCount);

	List<Booking> findBookingByUserId(int User_ID);

	List<Booking> findBookingDetailsByUserId(int userId);

	Optional<Booking> findBookingDetailsById(int bookingId);
    //We declared it as optional if we are unable to find booking details it can return the value as null.
	List<Booking> findPreviousBookingsByUserId(int userId, LocalDateTime todayStart);

	List<Booking> findUpcomingBookingsByUserId(int userId, LocalDateTime todayStart);

	int updateBookingStatus(int bookingId, String status);
}