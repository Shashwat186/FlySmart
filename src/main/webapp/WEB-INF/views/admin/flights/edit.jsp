<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Edit Flight</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
/* Color palette */
:root {
--color-light: #F5EEDC;
--color-primary: #27548A;
--color-dark: #183B4E;
--color-accent: #DDA853;
--glass-bg: rgba(39, 84, 138, 0.15);
--glass-border: 1px solid rgba(221, 168, 83, 0.2);
--glass-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
--glass-blur: blur(12px);
--glass-radius: 16px;
--transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@import url('https://fonts.googleapis.com/css2?family=Segoe+UI:wght@300;400;500;600;700&display=swap');

body {
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
margin: 0;
padding: 0;
color: var(--color-light);
background: linear-gradient(rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)),
url('https://images.unsplash.com/photo-1556388158-158ea5ccacbd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
background-size: cover;
background-attachment: fixed;
background-position: center;
min-height: 100vh;
line-height: 1.6;
}

/* Animations */
@keyframes float {
0%, 100% { transform: translateY(0); }
50% { transform: translateY(-10px); }
}

@keyframes pulse {
0%, 100% { transform: scale(1); }
50% { transform: scale(1.03); }
}

/* Floating symbols */
.floating-symbol {
position: fixed;
font-size: 24px;
opacity: 0.1;
color: var(--color-accent);
animation: float 15s infinite linear;
z-index: -1;
}

.symbol-1 { top: 10%; left: 5%; animation-delay: 0s; }
.symbol-2 { top: 25%; left: 80%; animation-delay: 2s; }
.symbol-3 { top: 60%; left: 15%; animation-delay: 4s; }
.symbol-4 { top: 75%; left: 70%; animation-delay: 6s; }
.symbol-5 { top: 40%; left: 50%; animation-delay: 8s; }

/* Container Styling */
.container {
max-width: 800px;
margin: 40px auto;
padding: 30px;
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow);
transform-style: preserve-3d;
transition: var(--transition);
}

.container:hover {
transform: translateY(-5px) rotateX(1deg) rotateY(1deg);
box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
}

/* Header Styling */
h2 {
text-align: center;
color: var(--color-light);
font-weight: 400;
letter-spacing: 1px;
margin-bottom: 30px;
text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
animation: pulse 6s infinite;
display: flex;
align-items: center;
justify-content: center;
gap: 8px;
}

/* Form Styling */
.form-label {
color: var(--color-light);
font-weight: 500;
margin-bottom: 8px;
display: flex;
align-items: center;
gap: 8px;
}

.form-control, select.form-control {
width: 100%;
padding: 12px 15px;
font-size: 16px;
background: rgba(24, 59, 78, 0.3);
border: var(--glass-border);
border-radius: 8px;
color: var(--color-light);
transition: var(--transition);
box-sizing: border-box;
transform-style: preserve-3d;
}

select.form-control {
appearance: none;
background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='%23DDA853' d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3e%3c/svg%3e");
background-repeat: no-repeat;
background-position: right 0.75rem center;
background-size: 16px 12px;
}

.form-control:focus, select.form-control:focus {
border-color: var(--color-accent);
background: rgba(39, 84, 138, 0.3);
outline: none;
box-shadow: 0 0 15px rgba(221, 168, 83, 0.3);
transform: translateZ(10px);
}

.form-control.is-invalid {
border-color: #ff6b6b;
}

/* Button Styling */
.btn {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
border: var(--glass-border);
padding: 12px 25px;
font-size: 15px;
font-weight: 500;
border-radius: 30px;
cursor: pointer;
transition: var(--transition);
letter-spacing: 0.5px;
text-transform: uppercase;
position: relative;
overflow: hidden;
transform-style: preserve-3d;
margin-right: 10px;
display: inline-flex;
align-items: center;
gap: 8px;
}

.btn-primary {
background: rgba(221, 168, 83, 0.3);
color: var(--color-light);
}

.btn-secondary {
background: rgba(39, 84, 138, 0.3);
color: var(--color-light);
}

.btn:hover {
background: rgba(221, 168, 83, 0.4);
box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
transform: translateY(-3px) translateZ(10px);
}

/* Alert Styling */
.alert {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
border: var(--glass-border);
border-radius: var(--glass-radius);
padding: 15px;
margin-bottom: 20px;
transform-style: preserve-3d;
display: flex;
align-items: center;
gap: 8px;
}

.alert-success {
background: rgba(76, 175, 80, 0.2);
color: #a3e4a8;
}

.alert-danger {
background: rgba(244, 67, 54, 0.2);
color: #ff9e9e;
}

/* Custom Alert Popup */
.custom-alert {
position: fixed;
top: 20px;
right: 20px;
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: rgba(244, 67, 54, 0.3);
border: var(--glass-border);
border-radius: var(--glass-radius);
padding: 15px 20px;
color: #ff9e9e;
display: flex;
align-items: center;
gap: 10px;
z-index: 1000;
box-shadow: var(--glass-shadow);
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

/* Icons */
.icon {
color: var(--color-accent);
}

/* Responsive adjustments */
@media (max-width: 768px) {
.container {
margin: 20px;
padding: 20px;
}

.form-control, select.form-control {
padding: 10px 12px;
font-size: 14px;
}

.btn {
width: 100%;
margin-bottom: 10px;
}

.text-center {
display: flex;
flex-direction: column;
align-items: center;
}

.custom-alert {
top: 10px;
right: 10px;
left: 10px;
transform: translateY(-150%);
}

.custom-alert.show {
transform: translateY(0);
}
}

/* Status indicator */
.status-indicator {
padding: 8px 12px;
border-radius: 4px;
display: inline-flex;
align-items: center;
gap: 5px;
font-size: 14px;
margin-top: 5px;
}

.status-scheduled { background: rgba(25, 118, 210, 0.2); color: #90caf9; }
.status-delayed { background: rgba(255, 152, 0, 0.2); color: #ffcc80; }
.status-cancelled { background: rgba(244, 67, 54, 0.2); color: #ef9a9a; }
.status-completed { background: rgba(76, 175, 80, 0.2); color: #a5d6a7; }
</style>
</head>
<body>
<!-- Floating symbols -->
<div class="floating-symbol symbol-1">✈</div>
<div class="floating-symbol symbol-2">🛫</div>
<div class="floating-symbol symbol-3">🛬</div>
<div class="floating-symbol symbol-4">🌐</div>
<div class="floating-symbol symbol-5">🛩</div>

<div class="container">
<h2><i class="fas fa-edit icon"></i> Edit Flight</h2>

<!-- Error messages moved to top -->
<c:if test="${not empty success}">
<div class="alert alert-success"><i class="fas fa-check-circle icon"></i> ${success}</div>
</c:if>
<c:if test="${not empty error}">
<div class="alert alert-danger"><i class="fas fa-exclamation-circle icon"></i> ${error}</div>
</c:if>

<form:form method="post" modelAttribute="flight" id="editFlightForm">
<input type="hidden" name="flightId" value="${flight.flightId}" />
<input type="hidden" id="originalDepartureDateTime" value="<fmt:formatDate value="${flight.departureDateTime}" pattern="yyyy-MM-dd'T'HH:mm" />" />
<input type="hidden" id="originalStatus" value="${flight.status}" />

<div class="mb-3">
<form:label path="flightNumber" class="form-label"><i class="fas fa-hashtag icon"></i> Flight Number</form:label>
<form:input path="flightNumber" class="form-control" required="true" maxlength="6" />
<div class="text-danger" id="flightNumberError"></div>

</div>

<div class="mb-3">
<label class="form-label"><i class="fas fa-plane icon"></i> Airline</label>
<select name="airlineId" class="form-control" required>
<c:forEach items="${airlines}" var="airline">
<option value="${airline.airlineId}"
${flight.airline.airlineId == airline.airlineId ? 'selected' : ''}>
${airline.name} (${airline.code})
</option>
</c:forEach>
</select>
</div>

<div class="row">
<div class="col-md-6">
<div class="mb-3">
<label class="form-label"><i class="fas fa-plane-departure icon"></i> Departure Airport</label>
<select name="departureAirportId" id="departureAirport" class="form-control" required>
<c:forEach items="${airports}" var="airport">
<option value="${airport.airportId}"
${flight.departureAirport.airportId == airport.airportId ? 'selected' : ''}>
${airport.name} (${airport.code})
</option>
</c:forEach>
</select>
</div>
</div>
<div class="col-md-6">
<div class="mb-3">
<label class="form-label"><i class="fas fa-plane-arrival icon"></i> Arrival Airport</label>
<select name="arrivalAirportId" id="arrivalAirport" class="form-control" required>
<c:forEach items="${airports}" var="airport">
<option value="${airport.airportId}"
${flight.arrivalAirport.airportId == airport.airportId ? 'selected' : ''}>
${airport.name} (${airport.code})
</option>
</c:forEach>
</select>
<div class="text-danger" id="airportError"></div>
</div>
</div>
</div>

<div class="row">
<div class="col-md-6">
<div class="mb-3">
<form:label path="departureDateTime" class="form-label"><i class="far fa-calendar-alt icon"></i> Departure Time</form:label>
<input name="departureDateTime" id="departureDateTime" type="datetime-local" class="form-control" required
value="<fmt:formatDate value="${flight.departureDateTime}" pattern="yyyy-MM-dd'T'HH:mm" />" />
</div>
</div>
<div class="col-md-6">
<div class="mb-3">
<form:label path="arrivalDateTime" class="form-label"><i class="far fa-calendar-alt icon"></i> Arrival Time</form:label>
<input name="arrivalDateTime" id="arrivalDateTime" type="datetime-local" class="form-control" required
value="<fmt:formatDate value="${flight.arrivalDateTime}" pattern="yyyy-MM-dd'T'HH:mm" />" />
</div>
</div>
</div>

<div class="mb-3">
<label class="form-label"><i class="fas fa-user-tie icon"></i> Flight Manager</label>
<select name="managerId" class="form-control" required>
<c:forEach items="${managers}" var="manager">
<option value="${manager.fmId}"
${flight.fmId == manager.fmId ? 'selected' : ''}>
${manager.user.name} (${manager.user.email})
</option>
</c:forEach>
</select>
</div>

<div class="mb-3">
<form:label path="status" class="form-label"><i class="fas fa-info-circle icon"></i> Status</form:label>
<form:select path="status" id="statusSelect" class="form-control" required="true">
<form:option value="Scheduled">Scheduled</form:option>
<form:option value="Delayed">Delayed</form:option>
<form:option value="Cancelled">Cancelled</form:option>
<form:option value="Completed">Completed</form:option>
</form:select>
<div id="statusIndicator" class="status-indicator mt-2"></div>
</div>

<div class="text-center">
<button type="submit" class="btn btn-primary"><i class="fas fa-save icon"></i> Update Flight</button>
<a href="/admin/flights" class="btn btn-secondary"><i class="fas fa-times icon"></i> Cancel</a>
</div>
</form:form>
</div>

<!-- Custom Alert Popup -->
<div id="customAlert" class="custom-alert">
<i class="fas fa-exclamation-triangle"></i>
<span id="alertMessage">This flight number is already in use for another flight!</span>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Existing flight numbers for validation (passed from server)
const existingFlightNumbers = [
<c:forEach items="${existingFlightNumbers}" var="flightNum" varStatus="status">
"${flightNum}"${status.last ? '' : ','}
</c:forEach>
];
const currentFlightId = "${flight.flightId}";
const currentFlightNumber = "${flight.flightNumber}";

// Function to show alert popup
function showAlert(message, type = 'error') {
const alert = document.getElementById('customAlert');
const messageElement = document.getElementById('alertMessage');
messageElement.textContent = message;

// Set alert type (error or info)
if (type === 'info') {
alert.classList.add('info');
alert.querySelector('i').className = 'fas fa-info-circle';
} else {
alert.classList.remove('info');
alert.querySelector('i').className = 'fas fa-exclamation-triangle';
}

alert.classList.add('show');
// Auto-hide after 5 seconds
setTimeout(() => {
alert.classList.remove('show');
}, 5000);
}

// Enhanced 3D tilt effect
document.querySelectorAll('.mb-3').forEach(el => {
el.addEventListener('mousemove', (e) => {
let xAxis = (window.innerWidth / 2 - e.pageX) / 25;
let yAxis = (window.innerHeight / 2 - e.pageY) / 25;
el.style.transform = `rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
});

el.addEventListener('mouseenter', () => {
el.style.transition = 'none';
});

el.addEventListener('mouseleave', () => {
el.style.transition = 'all 0.5s ease';
el.style.transform = 'rotateY(0deg) rotateX(0deg)';
});
});

// Function to validate airports
function validateAirports() {
const departureAirport = document.getElementById('departureAirport').value;
const arrivalAirport = document.getElementById('arrivalAirport').value;
const airportError = document.getElementById('airportError');

if (departureAirport === arrivalAirport) {
document.getElementById('departureAirport').classList.add('is-invalid');
document.getElementById('arrivalAirport').classList.add('is-invalid');
airportError.textContent = 'Arrival and departure airports cannot be the same';
return false;
} else {
document.getElementById('departureAirport').classList.remove('is-invalid');
document.getElementById('arrivalAirport').classList.remove('is-invalid');
airportError.textContent = '';
return true;
}
}

// Function to validate flight number length
function validateFlightNumberLength(flightNum) {
const flightNumberInput = document.querySelector('input[name="flightNumber"]');
const flightNumberError = document.getElementById('flightNumberError');


if (flightNum.length > 6) {
flightNumberInput.classList.add('is-invalid');
flightNumberError.textContent = 'Flight number must be 6 characters or less';
showAlert('Flight number must be 6 characters or less');
return false;
}
return true;
}

// Function to update status based on date/time
function updateStatusBasedOnDateTime() {
const departureDateTimeInput = document.getElementById('departureDateTime');
const originalDepartureDateTimeInput = document.getElementById('originalDepartureDateTime');
const statusSelect = document.getElementById('statusSelect');
const originalStatus = document.getElementById('originalStatus').value;
if (!departureDateTimeInput.value) return;
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

// Update status indicator UI
function updateStatusIndicator() {
const status = document.getElementById('statusSelect').value;
const indicator = document.getElementById('statusIndicator');
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

// Form validation
document.getElementById('editFlightForm').addEventListener('submit', function(e) {
let isValid = true;

// Flight number validation
const flightNumberInput = document.querySelector('input[name="flightNumber"]');
const flightNumber = flightNumberInput.value.trim();
const flightNumberError = document.getElementById('flightNumberError');

// Flight number required check
if (!flightNumber) {
flightNumberInput.classList.add('is-invalid');
flightNumberError.textContent = 'Flight Number is required';
isValid = false;
} 
// Flight number length check
else if (!validateFlightNumberLength(flightNumber)) {
isValid = false;
} 
// Flight number duplicate check
else if (flightNumber !== currentFlightNumber && existingFlightNumbers.includes(flightNumber)) {
flightNumberInput.classList.add('is-invalid');
flightNumberError.textContent = 'This flight number is already in use';
showAlert('This flight number is already in use for another flight!');
isValid = false;
} 
else {
flightNumberInput.classList.remove('is-invalid');
flightNumberError.textContent = '';
}

// Airport validation
if (!validateAirports()) {
isValid = false;
}

// Date validation
const depDateTime = document.querySelector('input[name="departureDateTime"]').value;
const arrDateTime = document.querySelector('input[name="arrivalDateTime"]').value;

if (!depDateTime || !arrDateTime) {
showAlert('Please fill in all date/time fields');
isValid = false;
} else {
const depDate = new Date(depDateTime);
const arrDate = new Date(arrDateTime);

if (arrDate <= depDate) {
showAlert('Arrival date/time must be after departure date/time');
isValid = false;
}
}

// Final status update before submission
updateStatusBasedOnDateTime();

// Required field validation
document.querySelectorAll('input[required], select[required]').forEach(input => {
if (!input.value) {
input.classList.add('is-invalid');
isValid = false;
} else {
input.classList.remove('is-invalid');
}
});

if (!isValid) {
e.preventDefault();
}
});

// Real-time input validation
document.querySelectorAll('input, select').forEach(input => {
input.addEventListener('blur', function() {
if (this.required && !this.value) {
this.classList.add('is-invalid');
} else {
this.classList.remove('is-invalid');
}

if (this.name === 'flightNumber') {
const flightNumber = this.value.trim();
const errorElement = document.getElementById('flightNumberError');


// Validate flight number length
if (flightNumber.length > 6) {
this.classList.add('is-invalid');
errorElement.textContent = 'Flight number must be 6 characters or less';
} 
// Validate flight number duplicate
else if (flightNumber && flightNumber !== currentFlightNumber && existingFlightNumbers.includes(flightNumber)) {
this.classList.add('is-invalid');
errorElement.textContent = 'This flight number is already in use';
showAlert('This flight number is already in use for another flight!');
} else {
this.classList.remove('is-invalid');
errorElement.textContent = '';
}
}
});
});

// Add input event listener for real-time flight number length validation
document.querySelector('input[name="flightNumber"]').addEventListener('input', function() {
const flightNumber = this.value.trim();
const errorElement = document.getElementById('flightNumberError');
    
if (flightNumber.length > 6) {
this.classList.add('is-invalid');
errorElement.textContent = 'Flight number must be 6 characters or less';
} else {
// Only remove is-invalid if there's no duplicate error
if (errorElement.textContent !== 'This flight number is already in use') {
this.classList.remove('is-invalid');
errorElement.textContent = '';
}
}
});

// Real-time airport validation
document.getElementById('departureAirport').addEventListener('change', validateAirports);
document.getElementById('arrivalAirport').addEventListener('change', validateAirports);

// Auto-update status based on date/time changes
document.getElementById('departureDateTime').addEventListener('change', updateStatusBasedOnDateTime);
document.getElementById('statusSelect').addEventListener('change', updateStatusIndicator);

// Initialize status indicator on page load
document.addEventListener('DOMContentLoaded', function() {
updateStatusIndicator();
// Check if we need to update status based on current date/time
updateStatusBasedOnDateTime();
});
</script>
</body>
</html>