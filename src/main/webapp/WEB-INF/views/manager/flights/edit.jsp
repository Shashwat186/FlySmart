<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Flight</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Updated Glassmorphism with new color scheme */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap');
:root {
--glass: rgba(39, 84, 138, 0.15);
--glass-edge: rgba(221, 168, 83, 0.2);
--text-primary: #F5EEDC;
--text-secondary: rgba(245, 238, 220, 0.8);
--blur: 20px;
--border-radius: 16px;
--color-error: #ff4d4d;
--color-accent: #DDA853;
}
* {
margin: 0;
padding: 0;
box-sizing: border-box;
font-family: 'Inter', sans-serif;
}
body {
min-height: 100vh;
background: linear-gradient(135deg, rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)),
url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
background-size: cover;
display: flex;
justify-content: center;
align-items: center;
color: var(--text-primary);
padding: 20px;
}
.glass-container {
width: 100%;
max-width: 800px;
}
.glass-card {
background: var(--glass);
backdrop-filter: blur(var(--blur));
-webkit-backdrop-filter: blur(var(--blur));
border-radius: var(--border-radius);
border: 1px solid var(--glass-edge);
padding: 40px;
box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
}
h2 {
text-align: center;
margin-bottom: 30px;
font-weight: 500;
color: var(--text-primary);
display: flex;
align-items: center;
justify-content: center;
gap: 10px;
}
.form-label {
color: var(--text-primary);
margin-bottom: 8px;
display: block;
font-weight: 400;
}
select option {
background-color: #183B4E; /* Dark background for options */
color: var(--text-primary); /* Light text color */
}

.form-control, .form-select {
width: 100%;
padding: 14px;
background: rgba(245, 238, 220, 0.1);
border: 1px solid rgba(39, 84, 138, 0.3);
border-radius: 10px;
color: var(--text-primary);
font-size: 15px;
transition: all 0.3s ease;
margin-bottom: 5px;
}
.form-control::placeholder {
color: var(--text-secondary);
}
.form-control:focus, .form-select:focus {
outline: none;
background: rgba(245, 238, 220, 0.2);
border-color: var(--color-accent);
}
.form-select {
appearance: none;
background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23DDA853'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
background-repeat: no-repeat;
background-position: right 14px center;
background-size: 14px;
color: var(--text-primary);
}
.btn {
padding: 14px 24px;
background: var(--color-accent);
border: none;
border-radius: 10px;
color: #183B4E;
font-weight: 500;
font-size: 15px;
cursor: pointer;
transition: all 0.3s ease;
}
.btn:hover {
background: rgba(221, 168, 83, 0.9);
transform: translateY(-1px);
}
.btn-secondary {
background: rgba(39, 84, 138, 0.3);
color: var(--text-primary);
border: 1px solid var(--glass-edge);
}
.btn-secondary:hover {
background: rgba(39, 84, 138, 0.4);
}
.error-message {
color: var(--color-error);
font-size: 12px;
margin-top: 5px;
font-weight: 400;
}
.alert {
background: var(--glass);
backdrop-filter: blur(var(--blur));
-webkit-backdrop-filter: blur(var(--blur));
border: 1px solid var(--glass-edge);
border-radius: 10px;
padding: 15px;
margin-bottom: 20px;
color: var(--text-primary);
}
.alert-success {
background: rgba(76, 175, 80, 0.2);
border-color: rgba(76, 175, 80, 0.3);
}
.alert-danger {
background: rgba(244, 67, 54, 0.2);
border-color: rgba(244, 67, 54, 0.3);
}
.icon {
color: var(--color-accent);
}
/* Status indicator */
.status-indicator {
padding: 8px 12px;
border-radius: 6px;
display: inline-flex;
align-items: center;
gap: 5px;
font-size: 14px;
margin-top: 8px;
}
.status-scheduled { background: rgba(25, 118, 210, 0.2); color: #90caf9; }
.status-delayed { background: rgba(255, 152, 0, 0.2); color: #ffcc80; }
.status-cancelled { background: rgba(244, 67, 54, 0.2); color: #ef9a9a; }
.status-completed { background: rgba(76, 175, 80, 0.2); color: #a5d6a7; }
/* Custom Alert Popup */
.custom-alert {
position: fixed;
top: 20px;
right: 20px;
backdrop-filter: blur(var(--blur));
-webkit-backdrop-filter: blur(var(--blur));
background: rgba(244, 67, 54, 0.3);
border: 1px solid var(--glass-edge);
border-radius: var(--border-radius);
padding: 15px 20px;
color: #ff9e9e;
display: flex;
align-items: center;
gap: 10px;
z-index: 1000;
box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
transform: translateX(150%);
transition: transform 0.4s ease;
}
.custom-alert.show {
transform: translateX(0);
}
.custom-alert.info {
background: rgba(33, 150, 243, 0.3);
color: #a0d7ff;
}
.custom-alert i {
color: #ff6b6b;
}
.custom-alert.info i {
color: #a0d7ff;
}
</style>

<script>
function validateForm() {
let valid = true;
// Get input elements and error containers
const flightNumber = document.getElementById('flightNumber');
const airlineId = document.getElementById('airlineId');
const departureAirportId = document.getElementById('departureAirportId');
const arrivalAirportId = document.getElementById('arrivalAirportId');
const departureDateTime = document.getElementById('departureDateTime');
const arrivalDateTime = document.getElementById('arrivalDateTime');
const managerId = document.getElementById('managerId');
const status = document.getElementById('status');
const flightNumberError = document.getElementById('flightNumberError');
const airlineError = document.getElementById('airlineError');
const departureAirportError = document.getElementById('departureAirportError');
const arrivalAirportError = document.getElementById('arrivalAirportError');
const departureDateTimeError = document.getElementById('departureDateTimeError');
const arrivalDateTimeError = document.getElementById('arrivalDateTimeError');
const managerError = document.getElementById('managerError');
const statusError = document.getElementById('statusError');
// Reset error messages
flightNumberError.textContent = '';
airlineError.textContent = '';
departureAirportError.textContent = '';
arrivalAirportError.textContent = '';
departureDateTimeError.textContent = '';
arrivalDateTimeError.textContent = '';
managerError.textContent = '';
statusError.textContent = '';
// Validate Flight Number
if (!flightNumber.value.trim()) {
flightNumberError.textContent = 'Flight Number is required!';
valid = false;
} else if (flightNumber.value.length > 6) {
flightNumberError.textContent = 'Flight Number cannot exceed 6 characters!';
valid = false;
}
// Validate Airline
if (!airlineId.value) {
airlineError.textContent = 'Please select an airline!';
valid = false;
}
// Validate Departure Airport
if (!departureAirportId.value) {
departureAirportError.textContent = 'Please select a departure airport!';
valid = false;
}
// Validate Arrival Airport
if (!arrivalAirportId.value) {
arrivalAirportError.textContent = 'Please select an arrival airport!';
valid = false;
} else if (departureAirportId.value === arrivalAirportId.value) {
arrivalAirportError.textContent = 'Departure and arrival airports cannot be the same!';
valid = false;
}
// Validate Departure DateTime
if (!departureDateTime.value) {
departureDateTimeError.textContent = 'Departure time is required!';
valid = false;
}
// Validate Arrival DateTime
if (!arrivalDateTime.value) {
arrivalDateTimeError.textContent = 'Arrival time is required!';
valid = false;
} else if (departureDateTime.value && arrivalDateTime.value) {
const depTime = new Date(departureDateTime.value);
const arrTime = new Date(arrivalDateTime.value);
if (arrTime <= depTime) {
arrivalDateTimeError.textContent = 'Arrival time must be after departure time!';
valid = false;
}
}
// Validate Manager
if (!managerId.value) {
managerError.textContent = 'Please select a flight manager!';
valid = false;
}
// Validate Status
if (!status.value) {
statusError.textContent = 'Please select a status!';
valid = false;
}
// Auto-update status based on departure time
updateStatusBasedOnDateTime();
return valid;
}

// Function to show alert popup
function showAlert(message, type = 'error') {
const alertElement = document.getElementById('customAlert');
if (!alertElement) {
// Create alert element if it doesn't exist
const alert = document.createElement('div');
alert.id = 'customAlert';
alert.className = 'custom-alert';
const icon = document.createElement('i');
icon.className = type === 'info' ? 'fas fa-info-circle' : 'fas fa-exclamation-triangle';
const messageSpan = document.createElement('span');
messageSpan.id = 'alertMessage';
messageSpan.textContent = message;
alert.appendChild(icon);
alert.appendChild(messageSpan);
document.body.appendChild(alert);
setTimeout(() => {
alert.classList.add('show');
}, 100);
setTimeout(() => {
alert.classList.remove('show');
setTimeout(() => {
document.body.removeChild(alert);
}, 500);
}, 5000);
} else {
// Update existing alert
const messageElement = document.getElementById('alertMessage');
messageElement.textContent = message;
const icon = alertElement.querySelector('i');
icon.className = type === 'info' ? 'fas fa-info-circle' : 'fas fa-exclamation-triangle';
if (type === 'info') {
alertElement.classList.add('info');
} else {
alertElement.classList.remove('info');
}
alertElement.classList.add('show');
setTimeout(() => {
alertElement.classList.remove('show');
}, 5000);
}
}

// Function to update status based on date/time
function updateStatusBasedOnDateTime() {
const departureDateTimeInput = document.getElementById('departureDateTime');
const originalDepartureDateTimeInput = document.getElementById('originalDepartureDateTime');
const statusSelect = document.getElementById('status');
const originalStatus = document.getElementById('originalStatus').value;

if (!departureDateTimeInput.value || !originalDepartureDateTimeInput.value) return;

const departureDate = new Date(departureDateTimeInput.value);
const originalDepartureDate = new Date(originalDepartureDateTimeInput.value);
const now = new Date();

// If the flight date is in the past, set status to "Completed"
if (departureDate < now) {
if (statusSelect.value !== 'Cancelled') {
statusSelect.value = 'Completed';
showAlert(`Status automatically set to "Completed" because departure time is in the past.`, 'info');
}
}
// If the time is increased from the original, set status to "Delayed"
else if (departureDate > originalDepartureDate && originalStatus !== 'Cancelled') {
statusSelect.value = 'Delayed';
showAlert(`Status automatically set to "Delayed" because departure time was moved to a later date/time.`, 'info');
}
// If it's a future date and not delayed, keep as Scheduled
else if (departureDate > now && statusSelect.value !== 'Cancelled' && statusSelect.value !== 'Delayed') {
statusSelect.value = 'Scheduled';
}
updateStatusIndicator();
}

// Add input event listener for real-time flight number validation
function setupFlightNumberValidation() {
const flightNumber = document.getElementById('flightNumber');
const flightNumberError = document.getElementById('flightNumberError');


if (flightNumber) {
flightNumber.addEventListener('input', function() {
flightNumberError.textContent = '';
if (this.value.length > 6) {
flightNumberError.textContent = 'Flight Number cannot exceed 6 characters!';
this.value = this.value.slice(0, 6); // Automatically truncate to 6 chars
}
});
}
}

// Update status indicator UI
function updateStatusIndicator() {
const status = document.getElementById('status').value;
const indicator = document.getElementById('statusIndicator');
if (!indicator) return;

// Remove all previous classes
indicator.className = 'status-indicator mt-2';

// Add appropriate class and icon based on status
let icon, text;
switch(status) {
case 'Scheduled':
indicator.classList.add('status-scheduled');
icon = 'fas fa-clock';
text = 'Flight is on schedule';
break;
case 'Delayed':
indicator.classList.add('status-delayed');
icon = 'fas fa-exclamation-triangle';
text = 'Flight has been delayed';
break;
case 'Cancelled':
indicator.classList.add('status-cancelled');
icon = 'fas fa-ban';
text = 'Flight has been cancelled';
break;
case 'Completed':
indicator.classList.add('status-completed');
icon = 'fas fa-check-circle';
text = 'Flight has been completed';
break;
}
indicator.innerHTML = `<i class="${icon}"></i> ${text}`;
}

// Add event listener for departure date/time changes to update status
document.addEventListener('DOMContentLoaded', function() {
const departureDateTime = document.getElementById('departureDateTime');
if (departureDateTime) {
departureDateTime.addEventListener('change', updateStatusBasedOnDateTime);
}
// Initialize status indicator
updateStatusIndicator();
// Check if we need to update status based on current date/time
updateStatusBasedOnDateTime();
// Add event listener for status changes to update the indicator
const statusSelect = document.getElementById('status');
if (statusSelect) {
statusSelect.addEventListener('change', updateStatusIndicator);
}
// Setup real-time validation for flight number
setupFlightNumberValidation();
});
</script>
</head>
<body>
<div class="glass-container">

<div class="glass-card">
<h2><i class="fas fa-edit icon"></i>Edit Flight</h2>

<!-- Error messages at the top -->
<c:if test="${not empty success}">
<div class="alert alert-success">${success}</div>
</c:if>
<c:if test="${not empty error}">
<div class="alert alert-danger">${error}</div>
</c:if>

<form:form method="post" modelAttribute="flight" onsubmit="return validateForm()">
<input type="hidden" name="flightId" value="${flight.flightId}" />
<!-- Hidden fields to store original values for comparison -->
<input type="hidden" id="originalDepartureDateTime" value="<fmt:formatDate value="${flight.departureDateTime}" pattern="yyyy-MM-dd'T'HH:mm" />" />
<input type="hidden" id="originalStatus" value="${flight.status}" />

<div class="mb-3">
<form:label path="flightNumber" class="form-label">Flight Number (max 6 characters)</form:label>
<form:input path="flightNumber" id="flightNumber" class="form-control" maxlength="6" />
<div id="flightNumberError" class="error-message"></div>
</div>
<div class="mb-3">
<label class="form-label">Airline</label>
<select name="airlineId" id="airlineId" class="form-select">
<c:forEach items="${airlines}" var="airline">
<option value="${airline.airlineId}"
${flight.airline.airlineId == airline.airlineId ? 'selected' : ''}>
${airline.name} (${airline.code})
</option>
</c:forEach>
</select>
<div id="airlineError" class="error-message"></div>
</div>
<div class="row">
<div class="col-md-6">
<div class="mb-3">
<label class="form-label">Departure Airport</label>
<select name="departureAirportId" id="departureAirportId" class="form-select">
<c:forEach items="${airports}" var="airport">
<option value="${airport.airportId}"
${flight.departureAirport.airportId == airport.airportId ? 'selected' : ''}>
${airport.name} (${airport.code})
</option>
</c:forEach>
</select>
<div id="departureAirportError" class="error-message"></div>
</div>
</div>
<div class="col-md-6">
<div class="mb-3">
<label class="form-label">Arrival Airport</label>
<select name="arrivalAirportId" id="arrivalAirportId" class="form-select">
<c:forEach items="${airports}" var="airport">
<option value="${airport.airportId}"
${flight.arrivalAirport.airportId == airport.airportId ? 'selected' : ''}>
${airport.name} (${airport.code})
</option>
</c:forEach>
</select>
<div id="arrivalAirportError" class="error-message"></div>
</div>
</div>
</div>
<div class="row">
<div class="col-md-6">
<div class="mb-3">
<form:label path="departureDateTime" class="form-label">Departure Time</form:label>
<input name="departureDateTime" id="departureDateTime" type="datetime-local" class="form-control"
value="<fmt:formatDate value="${flight.departureDateTime}" pattern="yyyy-MM-dd'T'HH:mm" />" />
<div id="departureDateTimeError" class="error-message"></div>
</div>
</div>
<div class="col-md-6">
<div class="mb-3">
<form:label path="arrivalDateTime" class="form-label">Arrival Time</form:label>
<input name="arrivalDateTime" id="arrivalDateTime" type="datetime-local" class="form-control"
value="<fmt:formatDate value="${flight.arrivalDateTime}" pattern="yyyy-MM-dd'T'HH:mm" />" />
<div id="arrivalDateTimeError" class="error-message"></div>
</div>
</div>
</div>
<div class="mb-3">
<label class="form-label">Flight Manager</label>
<select name="managerId" id="managerId" class="form-select">
<c:forEach items="${managers}" var="manager">
<option value="${manager.fmId}"
${flight.fmId == manager.fmId ? 'selected' : ''}>
${manager.user.name} (${manager.user.email})
</option>
</c:forEach>
</select>
<div id="managerError" class="error-message"></div>
</div>
<div class="mb-3">
<form:label path="status" class="form-label">Status</form:label>
<form:select path="status" id="status" class="form-select">
<form:option value="Scheduled">Scheduled</form:option>
<form:option value="Delayed">Delayed</form:option>
<form:option value="Cancelled">Cancelled</form:option>
<form:option value="Completed">Completed</form:option>
</form:select>
<div id="statusError" class="error-message"></div>
<div id="statusIndicator" class="status-indicator mt-2"></div>
</div>
<div class="d-flex justify-content-between">
<button type="submit" class="btn">Update Flight</button>
<a href="${pageContext.request.contextPath}/manager/flights" class="btn btn-secondary">Cancel</a>
</div>
</form:form>
</div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
