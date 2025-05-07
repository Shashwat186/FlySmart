package smart.fly.payment.model;
 
import java.sql.Date;
import java.sql.Timestamp;

import smart.fly.booking.model.Booking;
 
public class Payment {
    private int paymentId;
    private String cardNumber;
    private String cardHolderName;
    private Date expiryDate;
    private Timestamp paymentDateTime;
    private String paymentMode; 
    private String transactionId;
    private String upiId;
    private String cardType; // "Credit", "Debit"
    
    // Object reference
    private Booking booking;
 
   
    public Payment() {}
    
    public Payment(int paymentId, String cardNumber, String cardHolderName, Date expiryDate, 
                  Timestamp paymentDateTime, String paymentMode, String transactionId, 
                  String upiId, String cardType) {
        this.paymentId = paymentId;
        this.cardNumber = cardNumber;
        this.cardHolderName = cardHolderName;
        this.expiryDate = expiryDate;
        this.paymentDateTime = paymentDateTime;
        this.paymentMode = paymentMode;
        this.transactionId = transactionId;
        this.upiId = upiId;
        this.cardType = cardType;
    }

	public int getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getCardHolderName() {
		return cardHolderName;
	}

	public void setCardHolderName(String cardHolderName) {
		this.cardHolderName = cardHolderName;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	public Timestamp getPaymentDateTime() {
		return paymentDateTime;
	}

	public void setPaymentDateTime(Timestamp paymentDateTime) {
		this.paymentDateTime = paymentDateTime;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getUpiId() {
		return upiId;
	}

	public void setUpiId(String upiId) {
		this.upiId = upiId;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public Booking getBooking() {
		return booking;
	}

	public void setBooking(Booking booking) {
		this.booking = booking;
	}

}
 