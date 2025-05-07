package smart.fly.dto;
 
import lombok.Data;
 
@Data
public class FlightFormDTO {
    private String flightNumber;
    private Integer airlineId;
    private Integer departureAirportId;
    private Integer arrivalAirportId;
    private String departureDateTime;
    private String arrivalDateTime;
    private Integer managerId;
	public FlightFormDTO(String flightNumber, Integer airlineId, Integer departureAirportId, Integer arrivalAirportId,
			String departureDateTime, String arrivalDateTime, Integer managerId) {
		super();
		this.flightNumber = flightNumber;
		this.airlineId = airlineId;
		this.departureAirportId = departureAirportId;
		this.arrivalAirportId = arrivalAirportId;
		this.departureDateTime = departureDateTime;
		this.arrivalDateTime = arrivalDateTime;
		this.managerId = managerId;
	}
	public String getFlightNumber() {
		return flightNumber;
	}
	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}
	public Integer getAirlineId() {
		return airlineId;
	}
	public void setAirlineId(Integer airlineId) {
		this.airlineId = airlineId;
	}
	public Integer getDepartureAirportId() {
		return departureAirportId;
	}
	public void setDepartureAirportId(Integer departureAirportId) {
		this.departureAirportId = departureAirportId;
	}
	public Integer getArrivalAirportId() {
		return arrivalAirportId;
	}
	public void setArrivalAirportId(Integer arrivalAirportId) {
		this.arrivalAirportId = arrivalAirportId;
	}
	public String getDepartureDateTime() {
		return departureDateTime;
	}
	public void setDepartureDateTime(String departureDateTime) {
		this.departureDateTime = departureDateTime;
	}
	public String getArrivalDateTime() {
		return arrivalDateTime;
	}
	public void setArrivalDateTime(String arrivalDateTime) {
		this.arrivalDateTime = arrivalDateTime;
	}
	public Integer getManagerId() {
		return managerId;
	}
	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
	}
}
 