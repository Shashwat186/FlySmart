package smart.fly.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import smart.fly.booking.model.Booking;
import smart.fly.booking.repository.BookingRepository;
import smart.fly.exception.BookingException;
import smart.fly.flight.model.Flight;
import smart.fly.flight.repository.FlightRepository;
import smart.fly.flight.seats.model.FlightSeats;
import smart.fly.flight.seats.repository.FlightSeatsRepository;
import smart.fly.passenger.repository.PassengerRepository;
import smart.fly.payment.model.Payment;
import smart.fly.payment.repository.PaymentRepository;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BookingService {

	private final BookingRepository bookingRepository;
	private final FlightRepository flightRepository;
	private final PassengerRepository passengerRepository;
	private final FlightSeatsRepository flightSeatsRepository;
	private final PaymentRepository paymentRepository;

	@Autowired
	public BookingService(BookingRepository bookingRepository, FlightRepository flightRepository,
			PassengerRepository passengerRepository, FlightSeatsRepository flightSeatsRepository,
			PaymentRepository paymentRepository) {
		this.bookingRepository = bookingRepository;
		this.flightRepository = flightRepository;
		this.passengerRepository = passengerRepository;
		this.flightSeatsRepository = flightSeatsRepository;
		this.paymentRepository = paymentRepository;
	}

	public Booking createBooking(int passengerId, int flightId, int seatClassId, int seats, Payment payment) {
		// Validate flight and seat availability
		Flight flight = flightRepository.findById(flightId);
		if (!"SCHEDULED".equals(flight.getStatus())) {
			throw new BookingException("Flight is not available for booking");
		}

		FlightSeats flightSeats = flightSeatsRepository.findByFlightAndClass(flightId, seatClassId);
		if (flightSeats.getAvailableSeats() < seats) {
			throw new BookingException("Not enough seats available");
		}

		// Create booking
		Booking booking = new Booking();
		booking.setPassenger(passengerRepository.findById(passengerId));
		booking.setFlight(flight);
		booking.setSeatClass(flightSeats.getSeatClass());
		booking.setNumberOfSeats(seats);
		booking.setBookingDateTime(Timestamp.from(Instant.now()));
		booking.setTotalPrice(flightSeats.getPrice() * seats);

		bookingRepository.save(booking);

		// Update available seats
		flightSeatsRepository.updateAvailableSeats(flightSeats.getFlightSeatId(),
				flightSeats.getAvailableSeats() - seats);

		// Process payment
		payment.setBooking(booking);
		paymentRepository.save(payment);

		return booking;
	}

	public void cancelBooking(int bookingId) {
		Booking booking = bookingRepository.findById(bookingId);

		// Return seats to inventory
		FlightSeats seats = flightSeatsRepository.findByFlightAndClass(booking.getFlight().getFlightId(),
				booking.getSeatClass().getSeatClassId());

		flightSeatsRepository.updateAvailableSeats(seats.getFlightSeatId(),
				seats.getAvailableSeats() + booking.getNumberOfSeats());

		// Cancel booking
		bookingRepository.cancel(bookingId);
	}

	public List<Booking> getPassengerBookings(int passengerId) {
		return bookingRepository.findByPassenger(passengerId);
	}

	public Flight getFlightById(int flightId) {
		return flightRepository.findById(flightId);
	}

	// existing BookingService
	public Booking getBookingById(int bookingId) {
		return bookingRepository.findById(bookingId);
	}

	public boolean cancelBooking(int bookingId, int userId) {
		Optional<Booking> bookingOptional = bookingRepository.findBookingDetailsById(bookingId);
		if (bookingOptional.isPresent()) {
			Booking booking = bookingOptional.get();
			if (booking.getUserId() == userId) {
				String status = booking.getStatus(); // Get the status once

				if (status != null && status.equalsIgnoreCase("CANCELLED")) {
					return true; // Already cancelled
				} else if (status != null && !status.equalsIgnoreCase("CANCELLED")) {
					int rowsAffected = bookingRepository.updateBookingStatus(bookingId, "CANCELLED");
					return rowsAffected > 0;
				} else {
					// Handle the case where status is null
					System.out.println("Warning: Booking ID " + bookingId + " has a null status.");
					return false; 
				}
			} else {
				System.out.println("Warning: User ID " + userId + " does not own Booking ID " + bookingId + ".");
				return false; // Booking does not belong to the user
			}
		}
		return false; // Booking not found
	}

}
