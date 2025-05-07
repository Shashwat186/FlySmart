package smart.fly.dto;
 
import smart.fly.passenger.model.Passenger;
import java.util.List;
 
public class BookingRequestDTO {
    private int flightId;
    private int seatClassId;
    private int numberOfSeats;
    private List<Passenger> passengers;
    private String paymentMode;
    private String cardNumber;
    private String cardHolderName;
    private String expiryDate;
    private String cvv;
    private Double totalPrice;
    private Integer NumberOfAdults;
    private Integer NumberOfChildren;
    

	public Integer getNumberOfAdults() {
		return NumberOfAdults;
	}

	public void setNumberOfAdults(Integer numberOfAdults) {
		NumberOfAdults = numberOfAdults;
	}

	public Integer getNumberOfChildren() {
		return NumberOfChildren;
	}

	public void setNumberOfChildren(Integer numberOfChildren) {
		NumberOfChildren = numberOfChildren;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	// Getters and setters for all fields
    public int getFlightId() {
        return flightId;
    }
 
    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }
 
    public int getSeatClassId() {
        return seatClassId;
    }
 
    public void setSeatClassId(int seatClassId) {
        this.seatClassId = seatClassId;
    }
 
    public int getNumberOfSeats() {
        return numberOfSeats;
    }
 
    public void setNumberOfSeats(int numberOfSeats) {
        this.numberOfSeats = numberOfSeats;
    }
 
    public List<Passenger> getPassengers() {
        return passengers;
    }
 
    public void setPassengers(List<Passenger> passengers) {
        this.passengers = passengers;
    }
 
    public String getPaymentMode() {
        return paymentMode;
    }
 
    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
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
 
    public String getExpiryDate() {
        return expiryDate;
    }
 
    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }
 
    public String getCvv() {
        return cvv;
    }
 
    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
}