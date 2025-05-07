package smart.fly.flight.add.repository;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;

@Repository
public class AddFlightRepository {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    

    public int addFlight(String flightNumber, Integer airlineId, Integer departureAirportId,
                        Integer arrivalAirportId, Timestamp departureDateTime,
                        Timestamp arrivalDateTime, Integer managerId) {
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO Flight (flight_number, Airline_Id, Departure_Airport_Id, Arrival_Airport_Id, " +
                "Departure_Date_Time, Arrival_Date_Time, Status, fm_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, flightNumber);
            ps.setInt(2, airlineId);
            ps.setInt(3, departureAirportId);
            ps.setInt(4, arrivalAirportId);
            ps.setTimestamp(5, departureDateTime);
            ps.setTimestamp(6, arrivalDateTime);
            ps.setString(7, "SCHEDULED");
            ps.setInt(8, managerId);
            return ps;
        }, keyHolder);
        
        Number generatedFlightId = keyHolder.getKey();
        
        if (generatedFlightId == null) {
            throw new RuntimeException("Failed to retrieve generated Flight ID.");
        }
        
        return generatedFlightId.intValue();
    }
    
   
    public int addFlightSeats(int flightId, int seatClassId, int totalSeats, double price) {
        return jdbcTemplate.update(
            "INSERT INTO flight_seats (Flight_ID, Seat_Class_ID, Available_Seats, Total_Seats, price) VALUES (?, ?, ?, ?, ?)",
            flightId, seatClassId, totalSeats, totalSeats, price);
    }
}