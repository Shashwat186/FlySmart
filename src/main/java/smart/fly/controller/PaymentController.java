package smart.fly.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import smart.fly.adult.model.*;
import smart.fly.booking.search.repository.BookingSearchRepository;
import smart.fly.child.model.Child;
import smart.fly.flight.details.FlightDetails;
import smart.fly.passenger.model.Passenger;

import org.springframework.beans.factory.annotation.Autowired;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
public class PaymentController {

	@Autowired
	private DataSource dataSource;//Newer alternative to drivermanager.
	//factory for connections to a physical database
	private BookingSearchRepository bookingRepository;

	public PaymentController(DataSource dataSource, BookingSearchRepository bookingRepository) {
		super();
		this.dataSource = dataSource;
		this.bookingRepository = bookingRepository;
	}

	@PostMapping("/booking/processPayment")
	public ModelAndView processPayment(@RequestParam("paymentMode") String paymentMode,
			@RequestParam(value = "cardNumber", required = false) String cardNumber,
			@RequestParam(value = "cardHolderName", required = false) String cardHolderName,
			@RequestParam(value = "expiryDate", required = false) String expiryDate,
			@RequestParam(value = "cardType", required = false) String cardType,
			@RequestParam(value = "upiId", required = false) String upiId,
			@RequestParam(value = "walletName", required = false) String walletName, HttpSession session) {

		Integer flightId = (Integer) session.getAttribute("flightId");
		Integer seatClassId = (Integer) session.getAttribute("seatClassId");
		Integer numberOfAdults = (Integer) session.getAttribute("numberOfAdults");
		Integer numberOfChildren = (Integer) session.getAttribute("numberOfChildren");
		List<Adult> adults = (List<Adult>) session.getAttribute("adults");
		List<Child> children = (List<Child>) session.getAttribute("children");
		Double totalPrice = (Double) session.getAttribute("totalPrice");
		Integer loggedInUserId = (Integer) session.getAttribute("loggedInUserId");

		Connection connection = null;
		int bookingId = -1;

		try {
			connection = dataSource.getConnection();
			connection.setAutoCommit(false);

			// 1. Insert booking
			bookingId = bookingRepository.createBooking(flightId, seatClassId, numberOfAdults + numberOfChildren,
					totalPrice, loggedInUserId, numberOfAdults, numberOfChildren);

			// 2. Check if booking ID exists
			bookingRepository.verifyBookingExists(bookingId);

			// 3. Insert passengers
			List<Passenger> passengers = new ArrayList<>();

			for (Adult adult : adults) {
				bookingRepository.createPassenger(bookingId, adult.getName(), adult.getEmail(), null,
						checkRegistrationStatus(adult.getEmail()), loggedInUserId);
				passengers.add(new Passenger(adult.getName(), adult.getEmail()));
			}

			for (Child child : children) {
				bookingRepository.createPassenger(bookingId, child.getName(), null, child.getAge(), false,
						loggedInUserId);
				passengers.add(new Passenger(child.getName(), null, child.getAge()));
			}

			// 4. Insert payment
			String cardTypeValue = ("Credit Card".equals(paymentMode) || "Debit Card".equals(paymentMode)) ? cardType
					: null;
			bookingRepository.createPayment(bookingId, paymentMode, cardNumber, cardHolderName, expiryDate,
					cardTypeValue, "DUMMY_" + System.currentTimeMillis(), upiId, walletName, totalPrice);

			// 5. Update flight seats
			bookingRepository.updateFlightSeats(flightId, seatClassId, numberOfAdults + numberOfChildren);

			// 6. Get flight details
			FlightDetails flightDetails = bookingRepository.getFlightDetails(flightId);

			connection.commit();

			// Clear session attributes
			session.removeAttribute("flightId");
			session.removeAttribute("seatClassId");
			session.removeAttribute("numberOfAdults");
			session.removeAttribute("numberOfChildren");
			session.removeAttribute("adults");
			session.removeAttribute("children");
			session.removeAttribute("totalPrice");

			// Prepare and return view
			ModelAndView mv = new ModelAndView("booking/confirm");
			mv.addObject("bookingId", bookingId);
			mv.addObject("flightNumber", flightDetails.getFlightNumber());
			mv.addObject("airlineName", flightDetails.getAirlineName());
			mv.addObject("airlineCode", flightDetails.getAirlineCode());
			mv.addObject("departureAirportName", flightDetails.getDepartureAirportName());
			mv.addObject("departureAirportCode", flightDetails.getDepartureAirportCode());
			mv.addObject("arrivalAirportName", flightDetails.getArrivalAirportName());
			mv.addObject("arrivalAirportCode", flightDetails.getArrivalAirportCode());
			mv.addObject("Arrival_Date_Time", flightDetails.getArrivalDateTime());
			mv.addObject("flightStatus", flightDetails.getFlightStatus());
			mv.addObject("seatClassId", seatClassId);
			mv.addObject("numberOfSeats", numberOfAdults + numberOfChildren);
			mv.addObject("totalPrice", totalPrice);
			mv.addObject("passengers", passengers);
			mv.addObject("paymentMode", paymentMode);
			mv.addObject("departure_date", flightDetails.getDepartureDateTime());

			return mv;

		} catch (SQLException e) {
			if (connection != null) {
				try {
					connection.rollback();
				} catch (SQLException ignored) {
				}
			}
			e.printStackTrace();
			return new ModelAndView("paymentFailed");
		} finally {
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException ignored) {
			}
		}
	}



	private boolean checkRegistrationStatus(String email) throws SQLException {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			connection = dataSource.getConnection();
			String sql = "SELECT User_ID FROM user WHERE email = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			return rs.next();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException ignored) {
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException ignored) {
			}
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException ignored) {
			}
		}
	}
}