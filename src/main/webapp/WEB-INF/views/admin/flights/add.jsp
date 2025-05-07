<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Flight</title>
<link href="${pageContext.request.contextPath}/resources/css/addFlight.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath}/owner/flight-add.css" rel="stylesheet">
</head>
<body>
<div class="container">
<!-- Back to Dashboard Button -->
<div class="text-center mb-3">
<a href="/admin/flights" class="btn btn-outline-light"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
</div>
<div class="form-container">
<h1><i class="fas fa-plus-circle me-2"></i>Add New Flight</h1>
<c:if test="${not empty error}">
<div class="error-message">
<i class="fas fa-exclamation-circle me-2"></i>${error}
</div>
</c:if>
<form action="${pageContext.request.contextPath}/admin/flights/add" method="post" id="flightForm">
<div class="mb-3">
<label for="flightNumber" class="form-label">Flight Number:</label>
<input type="text" id="flightNumber" name="flightNumber" class="form-control" value="${flightNumber}" maxlength="6" required>
<div id="flightNumberError" class="invalid-feedback" style="display: none;">
Duplicates are not allowed.
</div>
<div id="flightNumberLengthError" class="invalid-feedback" style="display: none;">
Flight number must be 6 characters or less.
</div>

</div>
<div class="mb-3">
<label for="airlineId" class="form-label">Airline:</label>
<select id="airlineId" name="airlineId" class="form-select" required>
<option value="">Select Airline</option>
<c:forEach items="${airlines}" var="airline">
<option value="${airline.airlineId}" ${airline.airlineId == airlineId ? 'selected' : ''}>${airline.name} (${airline.code})</option>
</c:forEach>
</select>
</div>
<div class="row">
<div class="col-md-6">
<label for="departureAirportId" class="form-label">Departure Airport:</label>
<select id="departureAirportId" name="departureAirportId" class="form-select" required>
<option value="">Select Departure Airport</option>
<c:forEach items="${airports}" var="airport">
<option value="${airport.airportId}" ${airport.airportId == departureAirportId ? 'selected' : ''}>${airport.code} - ${airport.name}</option>
</c:forEach>
</select>
</div>
<div class="col-md-6">
<label for="arrivalAirportId" class="form-label">Arrival Airport:</label>
<select id="arrivalAirportId" name="arrivalAirportId" class="form-select" required>
<option value="">Select Arrival Airport</option>
<c:forEach items="${airports}" var="airport">
<option value="${airport.airportId}" ${airport.airportId == arrivalAirportId ? 'selected' : ''}>${airport.code} - ${airport.name}</option>
</c:forEach>
</select>
<div id="airportError" class="invalid-feedback" style="display: none;">
Departure and Arrival airports cannot be the same.
</div>
</div>
</div>
<div class="row mt-3">
<div class="col-md-6">
<label for="departureDateTime" class="form-label">Departure Date/Time:</label>
<input type="datetime-local" id="departureDateTime" name="departureDateTime" class="form-control" value="${departureDateTime}" required>
</div>
<div class="col-md-6">
<label for="arrivalDateTime" class="form-label">Arrival Date/Time:</label>
<input type="datetime-local" id="arrivalDateTime" name="arrivalDateTime" class="form-control" value="${arrivalDateTime}" required>
<div id="dateTimeError" class="invalid-feedback" style="display: none;">
Arrival time must be at least 1 hour after departure.
</div>
</div>
</div>
<div class="mt-3 mb-3">
<label for="managerId" class="form-label">Flight Manager:</label>
<select id="managerId" name="managerId" class="form-select" required>
<option value="">Select Manager</option>
<c:forEach items="${managers}" var="manager">
<option value="${manager.fmId}" ${manager.fmId == managerId ? 'selected' : ''}>${manager.user.name} (${manager.user.email})</option>
</c:forEach>
</select>
</div>
<div class="seat-class-section">
<h3><i class="fas fa-chair me-2"></i>Economy Class</h3>
<label for="economyTotalSeats" class="form-label">Total Seats:</label>
<input type="number" id="economyTotalSeats" name="economyTotalSeats" class="form-control" min="1" value="${empty economyTotalSeats ? '1' : economyTotalSeats}" required>
<div id="economySeatsError" class="invalid-feedback" style="display: none;">
Economy seats must be greater than zero.
</div>
</div>
<div class="seat-class-section">
<h3><i class="fas fa-business-time me-2"></i>Business Class</h3>
<label for="businessTotalSeats" class="form-label">Total Seats:</label>
<input type="number" id="businessTotalSeats" name="businessTotalSeats" class="form-control" min="0" value="${empty businessTotalSeats ? '0' : businessTotalSeats}" required>
</div>
<div class="seat-class-section">
<h3><i class="fas fa-crown me-2"></i>First Class</h3>
<label for="firstClassTotalSeats" class="form-label">Total Seats:</label>
<input type="number" id="firstClassTotalSeats" name="firstClassTotalSeats" class="form-control" min="0" value="${empty firstClassTotalSeats ? '0' : firstClassTotalSeats}" required>
</div>
<div class="d-grid">
<button type="submit" class="btn btn-submit">
<i class="fas fa-save me-2"></i>Add Flight
</button>
</div>
</form>
</div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
const now = new Date();
const timezoneOffset = now.getTimezoneOffset() * 60000;
const localISOTime = new Date(now - timezoneOffset).toISOString().slice(0, 16);
const depInput = document.getElementById('departureDateTime');
const arrInput = document.getElementById('arrivalDateTime');
const flightNumberInput = document.getElementById('flightNumber');
const departureAirport = document.getElementById('departureAirportId');
const arrivalAirport = document.getElementById('arrivalAirportId');
const economySeats = document.getElementById('economyTotalSeats');
const form = document.getElementById('flightForm');

// Set minimum date to current time to prevent past dates
depInput.min = localISOTime;
arrInput.min = localISOTime;

// Flight Number Validation
flightNumberInput.addEventListener('input', function() {
    const flightNumber = this.value.trim();
    const lengthErrorDiv = document.getElementById('flightNumberLengthError');
    
    if (flightNumber.length > 6) {
        lengthErrorDiv.style.display = 'block';
        flightNumberInput.classList.add('is-invalid');
    } else {
        lengthErrorDiv.style.display = 'none';
        // Only remove is-invalid if there's no duplicate error
        if (!document.getElementById('flightNumberError').style.display || 
            document.getElementById('flightNumberError').style.display === 'none') {
            flightNumberInput.classList.remove('is-invalid');
        }
    }
});

// Flight Number Duplication Check
flightNumberInput.addEventListener('blur', function() {
    const flightNumber = this.value.trim();
    if (flightNumber) {
        fetch('${pageContext.request.contextPath}/admin/flights/checkFlightNumber?flightNumber=' + encodeURIComponent(flightNumber))
        .then(response => response.json())
        .then(data => {
            const errorDiv = document.getElementById('flightNumberError');
            if (data.exists) {
                errorDiv.style.display = 'block';
                flightNumberInput.classList.add('is-invalid');
            } else {
                errorDiv.style.display = 'none';
                // Only remove is-invalid if there's no length error
                if (!document.getElementById('flightNumberLengthError').style.display || 
                    document.getElementById('flightNumberLengthError').style.display === 'none') {
                    flightNumberInput.classList.remove('is-invalid');
                }
            }
        })
        .catch(error => console.error('Error checking flight number:', error));
    }
});

// Validate Departure and Arrival Airports
function validateAirports() {
    const depValue = departureAirport.value;
    const arrValue = arrivalAirport.value;
    const errorDiv = document.getElementById('airportError');
    if (depValue && arrValue && depValue === arrValue) {
        errorDiv.style.display = 'block';
        arrivalAirport.classList.add('is-invalid');
        return false;
    } else {
        errorDiv.style.display = 'none';
        arrivalAirport.classList.remove('is-invalid');
        return true;
    }
}
departureAirport.addEventListener('change', validateAirports);
arrivalAirport.addEventListener('change', validateAirports);

// Validate Economy Seats
economySeats.addEventListener('input', function() {
    const value = parseInt(this.value);
    const errorDiv = document.getElementById('economySeatsError');
    if (isNaN(value) || value <= 0) {
        errorDiv.style.display = 'block';
        this.classList.add('is-invalid');
    } else {
        errorDiv.style.display = 'none';
        this.classList.remove('is-invalid');
    }
});

// Form Submission Validation
form.addEventListener('submit', function(e) {
    let isValid = true;
    const depDateTime = new Date(depInput.value);
    const arrDateTime = new Date(arrInput.value);
    const diffInMs = arrDateTime - depDateTime;
    const diffInHours = diffInMs / (1000 * 60 * 60);
    const economySeatsValue = parseInt(economySeats.value);
    const flightNumber = flightNumberInput.value.trim();

    // Reset all error states
    document.getElementById('dateTimeError').style.display = 'none';
    arrInput.classList.remove('is-invalid');

    // Validate Flight Number Length
    if (flightNumber.length > 6) {
        document.getElementById('flightNumberLengthError').style.display = 'block';
        flightNumberInput.classList.add('is-invalid');
        isValid = false;
        e.preventDefault();
    }

    // Validate Date and Time
    if (isNaN(depDateTime) || isNaN(arrDateTime)) {
        alert('Please enter valid departure and arrival times.');
        isValid = false;
        e.preventDefault();
    } else if (arrDateTime <= depDateTime) {
        document.getElementById('dateTimeError').style.display = 'block';
        arrInput.classList.add('is-invalid');
        isValid = false;
        e.preventDefault();
    } else if (diffInHours < 1) {
        document.getElementById('dateTimeError').style.display = 'block';
        arrInput.classList.add('is-invalid');
        isValid = false;
        e.preventDefault();
    }

    // Validate Airports
    if (!validateAirports()) {
        isValid = false;
        e.preventDefault();
    }

    // Validate Economy Seats
    if (isNaN(economySeatsValue) || economySeatsValue <= 0) {
        document.getElementById('economySeatsError').style.display = 'block';
        economySeats.classList.add('is-invalid');
        isValid = false;
        e.preventDefault();
    }

    // Check Flight Number Duplication (synchronous check)
    if (flightNumberInput.classList.contains('is-invalid')) {
        isValid = false;
        e.preventDefault();
    }

    if (!isValid) {
        e.preventDefault();
    }
});
});
</script>
</body>
</html>
