package smart.fly.payment.repository;

import java.util.List;

import smart.fly.payment.model.Payment;

public interface PaymentRepository {
	void save(Payment payment);

	Payment findByBooking(int bookingId);

	List<Payment> findByTransactionId(String transactionId);

	void updatePaymentStatus(int paymentId, String status);

	int totalPayment();
}