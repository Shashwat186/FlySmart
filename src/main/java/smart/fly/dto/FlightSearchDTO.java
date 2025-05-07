package smart.fly.dto;
 
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.time.temporal.ChronoUnit;
import smart.fly.airline.model.Airline;
import smart.fly.airport.model.Airport;
 
public class FlightSearchDTO {
    private int flightId;
    private String flightNumber;
    private LocalDateTime departureDateTime;
    private LocalDateTime arrivalDateTime;
    private Date departureDate;
    private Date arrivalDate;
    private String status;
    private Airline airline;
    private Airport departureAirport;
    private Airport arrivalAirport;
    private double price;
    private long duration;
 
    public int getFlightId() {
        return flightId;
    }
 
    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }
 
    public String getFlightNumber() {
        return flightNumber;
    }
 
    public void setFlightNumber(String flightNumber) {
        this.flightNumber = flightNumber;
    }
 
    public LocalDateTime getDepartureDateTime() {
        return departureDateTime;
    }
 
    public void setDepartureDateTime(LocalDateTime departureDateTime) {
        this.departureDateTime = departureDateTime;
        this.departureDate = (departureDateTime != null) ? Date.from(departureDateTime.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
 
    public LocalDateTime getArrivalDateTime() {
        return arrivalDateTime;
    }
 
    public void setArrivalDateTime(LocalDateTime arrivalDateTime) {
        this.arrivalDateTime = arrivalDateTime;
        this.arrivalDate = (arrivalDateTime != null) ? Date.from(arrivalDateTime.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
 
    public Date getDepartureDate() {
        return departureDate;
    }
 
    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
       // this.departureDateTime = (departureDate != null) ? departureDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime() : null;
    }
 
    public Date getArrivalDate() {
        return arrivalDate;
    }
 
    public void setArrivalDate(Date arrivalDate) {
        this.arrivalDate = arrivalDate;
       // this.arrivalDateTime = (arrivalDate != null) ? arrivalDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime() : null;
    }
 
    public String getStatus() {
        return status;
    }
 
    public void setStatus(String status) {
        this.status = status;
    }
 
    public Airline getAirline() {
        return airline;
    }
 
    public void setAirline(Airline airline) {
        this.airline = airline;
    }
 
    public Airport getDepartureAirport() {
        return departureAirport;
    }
 
    public void setDepartureAirport(Airport departureAirport) {
        this.departureAirport = departureAirport;
    }
 
    public Airport getArrivalAirport() {
        return arrivalAirport;
    }
 
    public void setArrivalAirport(Airport arrivalAirport) {
        this.arrivalAirport = arrivalAirport;
    }
 
    public double getPrice() {
        return price;
    }
 
    public void setPrice(double price) {
        this.price = price;
    }
 
    public long getDuration() {
        return duration;
    }
 
    public void setDuration(long duration) {
        this.duration = duration;
    }
 
    public FlightSearchDTO(int flightId, String flightNumber, LocalDateTime departureDateTime,
                           LocalDateTime arrivalDateTime, String status, Airline airline, Airport departureAirport,
                           Airport arrivalAirport, double price) {
        this.flightId = flightId;
        this.flightNumber = flightNumber;
        this.departureDateTime = departureDateTime;
        this.arrivalDateTime = arrivalDateTime;
        this.departureDate = (departureDateTime != null) ? Date.from(departureDateTime.atZone(ZoneId.systemDefault()).toInstant()) : null;
        this.arrivalDate = (arrivalDateTime != null) ? Date.from(arrivalDateTime.atZone(ZoneId.systemDefault()).toInstant()) : null;
        this.status = status;
        this.airline = airline;
        this.departureAirport = departureAirport;
        this.arrivalAirport = arrivalAirport;
        this.price = price;
        this.duration = ChronoUnit.MINUTES.between(departureDateTime, arrivalDateTime);
    }

	public FlightSearchDTO() {
		super();
	}
 
    
}
 