<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Bookings</title>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Base Styling with color scheme */
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
--transition: all 0.3s ease;
}

body {
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
margin: 0;
padding: 0;
color: var(--color-light);
background: linear-gradient(rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)),
url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=3840&q=80');
background-size: cover;
background-attachment: fixed;
background-position: center;
min-height: 100vh;
}

/* Glassmorphism Header */
.dashboard-header {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border-bottom: var(--glass-border);
box-shadow: var(--glass-shadow),
0 4px 30px rgba(221, 168, 83, 0.1);
color: var(--color-light);
text-align: center;
padding: 24px;
position: sticky;
top: 0;
z-index: 100;
transition: var(--transition);
border-radius: var(--glass-radius);
margin-bottom: 30px;
}

.dashboard-header h1 {
margin: 0 0 16px 0;
font-weight: 300;
letter-spacing: 2px;
text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}

/* Navigation */
nav {
display: flex;
justify-content: center;
flex-wrap: wrap;
margin-top: 10px;
}

nav a {
color: rgba(245, 238, 220, 0.8);
text-decoration: none;
margin: 0 18px;
font-size: 16px;
font-weight: 500;
padding: 6px 2px;
border-bottom: 2px solid transparent;
transition: var(--transition);
letter-spacing: 0.5px;
position: relative;
}

nav a:hover, nav a.active {
color: var(--color-light);
border-bottom: 2px solid var(--color-accent);
}

nav a::after {
content: '';
position: absolute;
bottom: -5px;
left: 0;
width: 100%;
height: 2px;
background: var(--color-accent);
transform: scaleX(0);
transform-origin: right;
transition: transform 0.3s ease;
}

nav a:hover::after, nav a.active::after {
transform: scaleX(1);
transform-origin: left;
}

/* Dashboard content */
.dashboard {
max-width: 1200px;
margin: 40px auto;
padding: 0 15px;
}

/* Content Sections */
.content {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow),
0 10px 20px rgba(221, 168, 83, 0.1);
padding: 30px;
margin-bottom: 30px;
transition: var(--transition);
}

.content h2 {
margin-top: 0;
font-weight: 400;
letter-spacing: 1px;
color: var(--color-light);
display: flex;
align-items: center;
margin-bottom: 20px;
}

.content h2 i {
margin-right: 10px;
color: var(--color-accent);
}

/* Table Styling */
.content table {
width: 100%;
border-collapse: separate;
border-spacing: 0;
border-radius: 8px;
overflow: hidden;
margin-top: 20px;
}

.content table thead tr {
background: rgba(24, 59, 78, 0.5);
}

.content table th, .content table td {
padding: 16px;
text-align: left;
border-bottom: var(--glass-border);
}

.content table th {
font-weight: 500;
letter-spacing: 1px;
font-size: 14px;
text-transform: uppercase;
color: var(--color-accent);
}

.content table td {
color: rgba(245, 238, 220, 0.9);
}

.content table tbody tr {
background: rgba(255, 255, 255, 0.03);
transition: var(--transition);
}

.content table tbody tr:nth-child(even) {
background: rgba(39, 84, 138, 0.1);
}

.content table tbody tr:hover {
background: rgba(221, 168, 83, 0.1);
box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

/* Button Styling */
.btn {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: 8px;
color: var(--color-light);
padding: 10px 20px;
text-decoration: none;
font-weight: 500;
transition: var(--transition);
position: relative;
box-shadow: var(--glass-shadow);
display: inline-block;
cursor: pointer;
}

.btn:hover {
color: var(--color-accent);
box-shadow: 0 15px 25px rgba(0, 0, 0, 0.3);
}

.btn-view {
background: rgba(221, 168, 83, 0.2);
}

.btn-cancel {
background: rgba(39, 84, 138, 0.3);
}

.btn-disabled {
background-color: rgba(24, 59, 78, 0.5) !important;
color: rgba(245, 238, 220, 0.5) !important;
cursor: not-allowed;
border: var(--glass-border) !important;
opacity: 0.7;
}

/* Status Styling */
.status-scheduled {
color: #4caf50;
font-weight: bold;
}

.status-delayed {
color: #ff9800;
font-weight: bold;
}

.status-cancelled {
color: #f44336;
font-weight: bold;
}

.status-completed {
color: #2196f3;
font-weight: bold;
}

/* Feedback Form Styling */
#feedbackForm {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow),
0 10px 20px rgba(221, 168, 83, 0.1);
padding: 30px;
transition: var(--transition);
max-width: 500px;
width: 90%;
}

#feedbackForm h2 {
margin-top: 0;
font-weight: 400;
letter-spacing: 1px;
color: var(--color-light);
margin-bottom: 20px;
}

#feedbackForm label {
display: block;
margin-bottom: 8px;
font-weight: 500;
color: var(--color-light);
}

#feedbackForm textarea {
width: 100%;
padding: 12px;
background-color: rgba(255, 255, 255, 0.1);
border: var(--glass-border);
border-radius: 8px;
color: var(--color-light);
font-family: inherit;
resize: vertical;
transition: var(--transition);
}

#feedbackForm textarea:focus {
outline: none;
border-color: var(--color-accent);
box-shadow: 0 0 0 2px rgba(221, 168, 83, 0.2);
}

#feedbackForm textarea::placeholder {
color: rgba(245, 238, 220, 0.6);
}

/* Star Rating Styling - Updated */
.star-rating {
background: rgba(39, 84, 138, 0.2);
padding: 15px;
border-radius: 8px;
display: flex;
flex-direction: row;
align-items: center;
margin-top: 5px;
border: var(--glass-border);
}

.star-container {
display: flex;
flex-direction: row;
}

.star-rating input[type="radio"] {
display: none;
}

.star-rating label {
font-size: 24px;
color: #ccc;
cursor: pointer;
margin: 0 5px;
position: relative;
z-index: 2;
}

.star-rating label:before {
content: '\2605';
}

.star-rating label:hover:before,
.star-rating label:hover ~ label:before {
color: #ccc;
}

.star-container:hover label:before {
color: #ccc;
}

.star-rating label:hover:before {
color: #ffd700;
}

.star-rating input[type="radio"]:checked + label:before {
color: #ffd700;
}

.star-rating #star5:checked ~ label[for="star1"]:before,
.star-rating #star5:checked ~ label[for="star2"]:before,
.star-rating #star5:checked ~ label[for="star3"]:before,
.star-rating #star5:checked ~ label[for="star4"]:before,
.star-rating #star5:checked ~ label[for="star5"]:before {
color: #ffd700;
}

.star-rating #star4:checked ~ label[for="star1"]:before,
.star-rating #star4:checked ~ label[for="star2"]:before,
.star-rating #star4:checked ~ label[for="star3"]:before,
.star-rating #star4:checked ~ label[for="star4"]:before {
color: #ffd700;
}

.star-rating #star3:checked ~ label[for="star1"]:before,
.star-rating #star3:checked ~ label[for="star2"]:before,
.star-rating #star3:checked ~ label[for="star3"]:before {
color: #ffd700;
}

.star-rating #star2:checked ~ label[for="star1"]:before,
.star-rating #star2:checked ~ label[for="star2"]:before {
color: #ffd700;
}

.star-rating #star1:checked ~ label[for="star1"]:before {
color: #ffd700;
}

.star-rating .rating-label {
display: block;
font-size: 16px;
color: var(--color-light);
text-align: center;
margin-left: 15px;
font-weight: 500;
}

/* Icon Styling */
.icon {
display: inline-block;
margin-right: 8px;
color: var(--color-accent);
}

/* Alert Messages */
.alert-success {
background: rgba(76, 175, 80, 0.1);
border: 1px solid rgba(76, 175, 80, 0.3);
color: #4caf50;
padding: 12px;
border-radius: 8px;
margin-bottom: 20px;
backdrop-filter: var(--glass-blur);
}

.alert-danger {
background: rgba(244, 67, 54, 0.1);
border: 1px solid rgba(244, 67, 54, 0.3);
color: #f44336;
padding: 12px;
border-radius: 8px;
margin-bottom: 20px;
backdrop-filter: var(--glass-blur);
}

/* Confirmation Dialog */
#confirmationBox {
display: none;
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow),
0 10px 20px rgba(221, 168, 83, 0.1);
padding: 25px;
max-width: 400px;
margin: 20px auto;
text-align: center;
color: var(--color-light);
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
z-index: 1000;
}

#confirmationMessage {
margin-bottom: 20px;
font-size: 16px;
}

#confirmationBox button {
margin: 0 10px;
}

/* Success Dialog */
#successBox {
display: none;
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow),
0 10px 20px rgba(221, 168, 83, 0.1);
padding: 25px;
max-width: 400px;
margin: 20px auto;
text-align: center;
color: var(--color-light);
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
z-index: 1000;
}

#successMessage {
margin-bottom: 20px;
font-size: 16px;
display: flex;
align-items: center;
justify-content: center;
gap: 10px;
}

#successBox button {
margin-top: 20px;
}

/* Responsive Design */
@media (max-width: 768px) {
.dashboard-header h1 {
font-size: 24px;
}

nav a {
margin: 0 10px;
font-size: 14px;
}

.content {
padding: 20px;
}

.content table th, .content table td {
padding: 10px;
}

#feedbackForm {
width: 85%;
padding: 20px;
}

#confirmationBox,
#successBox {
width: 85%;
padding: 20px;
}
}
</style>
</head>
<body>
<div class="dashboard">
<header class="dashboard-header">
<h1>
<i class="fas fa-ticket-alt icon"></i>My Bookings
</h1>
<nav>
<nav class="nav justify-content-center mt-3 mt-md-4">
<a href="${pageContext.request.contextPath}/passenger/dashboard" class="nav-link">
<i class="fas fa-tachometer-alt icon"></i>Dashboard
</a>
<a href="${pageContext.request.contextPath}/passenger/bookings" class="nav-link">
<i class="fas fa-ticket icon"></i>My Bookings
</a>
<a href="${pageContext.request.contextPath}/auth/logout" class="nav-link">
<i class="fas fa-sign-out-alt icon"></i>Logout
</a>
</nav>
</header>

<div class="content">
<h2>
<i class="fas fa-plane-departure icon"></i>Upcoming Bookings
</h2>
<c:choose>
<c:when test="${upcomingBookingsEmpty}">
<p>No upcoming bookings found.</p>
</c:when>
<c:otherwise>
<div class="table-responsive">
<table>
<thead>
<tr>
<th><i class="fas fa-hashtag icon"></i>Flight</th>
<th><i class="fas fa-plane-departure icon"></i>Departure</th>
<th><i class="fas fa-plane-arrival icon"></i>Arrival</th>
<th><i class="fas fa-calendar-alt icon"></i>Departure Date</th>
<th><i class="fas fa-calendar-check icon"></i>Arrival Date</th>
<th><i class="fas fa-info-circle icon"></i>Status</th>
<th><i class="fas fa-cogs icon"></i>Cancel Ticket</th>
</tr>
</thead>
<tbody>
<c:forEach items="${upcomingBookings}" var="booking">
<tr>
<td>${booking.flight.flightNumber}</td>
<td>${booking.flight.departureAirport.code} (${booking.flight.departureAirport.name})</td>
<td>${booking.flight.arrivalAirport.code} (${booking.flight.arrivalAirport.name})</td>
<td><fmt:formatDate value="${booking.flight.departureDateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<td><fmt:formatDate value="${booking.flight.arrivalDateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<td class="status-${booking.flight.status.toLowerCase()}">${booking.flight.status}</td>
<td>
<c:if test="${booking.flight.status != 'CANCELLED'}">
<a href="#" onclick="confirmCancel('${pageContext.request.contextPath}/passenger/cancel/${booking.bookingId}')" class="btn btn-cancel">
<i class="fas fa-ban icon"></i>Cancel
</a>
</c:if>
<c:if test="${booking.flight.status == 'CANCELLED'}">
<span class="status-cancelled"><i class="fas fa-times-circle icon"></i>Cancelled</span>
</c:if>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</c:otherwise>
</c:choose>
</div>

<div id="feedbackForm" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
<h2><i class="fas fa-comment icon"></i>Give Feedback for Booking ID: <span id="feedbackBookingId"></span></h2>
<form id="feedbackFormData" method="post" action="${pageContext.request.contextPath}/passenger/submit-feedback" onsubmit="submitFeedback(event)">
<input type="hidden" name="bookingId" id="formBookingId" value="">
<div style="margin-bottom: 15px;">
<label for="feedbackRating">Rating (1-5):</label>
<div class="star-rating">
<div class="star-container">
<input type="radio" id="star1" name="rating" value="1" required>
<label for="star1" title="1 star"></label>
<input type="radio" id="star2" name="rating" value="2">
<label for="star2" title="2 stars"></label>
<input type="radio" id="star3" name="rating" value="3">
<label for="star3" title="3 stars"></label>
<input type="radio" id="star4" name="rating" value="4">
<label for="star4" title="4 stars"></label>
<input type="radio" id="star5" name="rating" value="5">
<label for="star5" title="5 stars"></label>
</div>
<span class="rating-label"></span>
</div>
</div>
<div style="margin-bottom: 15px;">
<label for="feedbackText">Feedback:</label>
<textarea id="feedbackText" name="feedbackContent" rows="5" placeholder="Your feedback here..." required></textarea>
</div>
<div style="text-align: right; margin-top: 20px;">
<button type="button" class="btn btn-cancel" onclick="closeFeedbackForm()">
<i class="fas fa-times icon"></i>Cancel
</button>
<button type="submit" class="btn btn-view">
<i class="fas fa-paper-plane icon"></i>Submit Feedback
</button>
</div>
</form>
</div>

<div class="content">
<h2>
<i class="fas fa-history icon"></i>Previous Bookings
</h2>
<c:choose>
<c:when test="${previousBookingsEmpty}">
<p>No previous bookings found.</p>
</c:when>
<c:otherwise>
<div class="table-responsive">
<table id="previousBookingsTable">
<thead>
<tr>
<th><i class="fas fa-hashtag icon"></i>Flight</th>
<th><i class="fas fa-plane-departure icon"></i>Departure</th>
<th><i class="fas fa-plane-arrival icon"></i>Arrival</th>
<th><i class="fas fa-calendar-alt icon"></i>Departure Date</th>
<th><i class="fas fa-calendar-check icon"></i>Arrival Date</th>
<th><i class="fas fa-info-circle icon"></i>Status</th>
<th><i class="fas fa-comment icon"></i>Give Feedback</th>
</tr>
</thead>
<tbody>
<c:forEach items="${previousBookings}" var="booking">
<c:if test="${booking.flight.status != 'CANCELLED'}">
<tr data-booking-id="${booking.bookingId}">
<td>${booking.flight.flightNumber}</td>
<td>${booking.flight.departureAirport.code} (${booking.flight.departureAirport.name})</td>
<td>${booking.flight.arrivalAirport.code} (${booking.flight.arrivalAirport.name})</td>
<td><fmt:formatDate value="${booking.flight.departureDateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<td><fmt:formatDate value="${booking.flight.arrivalDateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<td class="status-${booking.flight.status.toLowerCase()}">${booking.flight.status}</td>
<td>
<c:choose>
<c:when test="${bookingsWithFeedback.contains(booking.bookingId)}">
<button class="btn btn-disabled" disabled>
<i class="fas fa-check-circle icon"></i>Submitted
</button>
</c:when>
<c:otherwise>
<button class="btn btn-view" onclick="openFeedbackForm('${booking.bookingId}')">
<i class="fas fa-comment icon"></i>Give Feedback
</button>
</c:otherwise>
</c:choose>
</td>
</tr>
</c:if>
</c:forEach>
</tbody>
</table>
</div>
</c:otherwise>
</c:choose>
</div>

<!-- Confirmation Dialog -->
<div id="confirmationBox">
<p id="confirmationMessage"></p>
<button id="confirmYes" class="btn"><i class="fas fa-check icon"></i> Yes</button>
<button id="confirmNo" class="btn btn-cancel"><i class="fas fa-times icon"></i> No</button>
</div>

<!-- Success Dialog -->
<div id="successBox">
<p id="successMessage"><i class="fas fa-check-circle" style="color: #4caf50;"></i> Your feedback has been submitted successfully!</p>
<button id="successOk" class="btn btn-view"><i class="fas fa-check icon"></i> OK</button>
</div>

<script>
//Confirmation Dialog Logic
function confirmCancel(cancelUrl) {
    const confirmationBox = document.getElementById('confirmationBox');
    const confirmationMessage = document.getElementById('confirmationMessage');
    const confirmYes = document.getElementById('confirmYes');
    const confirmNo = document.getElementById('confirmNo');
 
    confirmationMessage.textContent = 'Are you sure you want to cancel this booking?';
confirmationBox.style.display = 'block';
 
    confirmYes.onclick = function() {
        window.location.href = cancelUrl;
confirmationBox.style.display = 'none';
    };
 
    confirmNo.onclick = function() {
confirmationBox.style.display = 'none';
    };
}
 
// Stores the current booking ID being updated
let currentBookingId = null;
 
function openFeedbackForm(bookingId) {
    console.log('Opening feedback form for booking ID:', bookingId);
    document.getElementById('feedbackBookingId').innerText = bookingId;
    document.getElementById('formBookingId').value = bookingId;
    document.getElementById('feedbackForm').style.display = 'block';
    // Store the current booking ID
    currentBookingId = bookingId;
    resetStars();
}
 
function closeFeedbackForm() {
    document.getElementById('feedbackForm').style.display = 'none';
    document.getElementById('feedbackBookingId').innerText = '';
    document.getElementById('formBookingId').value = '';
    document.getElementById('feedbackText').value = '';
    currentBookingId = null;
    resetStars();
}
 
function resetStars() {
    const stars = document.querySelectorAll('.star-rating input[type="radio"]');
    stars.forEach(star => star.checked = false);
    const starLabels = document.querySelectorAll('.star-rating label');
starLabels.forEach(label => label.style.color = '#ccc');
    document.querySelector('.star-rating .rating-label').textContent = '';
}
 
function updateRatingLabel() {
    const rating = document.querySelector('.star-rating input[name="rating"]:checked')?.value || '';
    const label = document.querySelector('.star-rating .rating-label');
    switch (rating) {
        case '1':
            label.textContent = 'Poor';
            break;
        case '2':
            label.textContent = 'Fair';
            break;
        case '3':
            label.textContent = 'Good';
            break;
        case '4':
            label.textContent = 'Very Good';
            break;
        case '5':
            label.textContent = 'Amazing';
            break;
        default:
            label.textContent = '';
    }
}
 
function showSuccessMessage() {
    const successBox = document.getElementById('successBox');
    const successOk = document.getElementById('successOk');
successBox.style.display = 'block';
    successOk.onclick = function() {
successBox.style.display = 'none';
    };
}
 
function updateButtonToSubmitted(bookingId) {
    console.log('Updating button for booking ID:', bookingId);
    
    // Method 1: Using querySelector with attribute selector
    const rows = document.querySelectorAll(`tr[data-booking-id="${bookingId}"]`);
    console.log('Found rows:', rows.length);
 
    if (rows.length > 0) {
        const row = rows[0];
        const buttonCell = row.cells[row.cells.length - 1]; // Get the last cell
        
        if (buttonCell) {
            console.log('Found button cell, updating to submitted state');
            buttonCell.innerHTML = '<button class="btn btn-disabled" disabled><i class="fas fa-check-circle icon"></i>Submitted</button>';
            return true;
        } else {
            console.log('Button cell not found');
        }
    } else {
        console.log('Row not found using data attribute');
    }
    
    // Method 2: Traverse the table directly (backup)
    const table = document.getElementById('previousBookingsTable');
    if (table) {
        const rows = table.querySelectorAll('tbody tr');
        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const rowBookingId = row.getAttribute('data-booking-id');
            
            if (rowBookingId === bookingId) {
                console.log('Found row using table traversal');
                const buttonCell = row.cells[row.cells.length - 1];
                if (buttonCell) {
                    console.log('Updating button using table traversal method');
                    buttonCell.innerHTML = '<button class="btn btn-disabled" disabled><i class="fas fa-check-circle icon"></i>Submitted</button>';
                    return true;
                }
            }
        }
    } else {
        console.log('Table not found');
    }
    
    return false;
}
 
function submitFeedback(event) {
    event.preventDefault();
    const bookingId = document.getElementById('formBookingId').value;
    const rating = document.querySelector('.star-rating input[name="rating"]:checked')?.value;
    const feedback = document.getElementById('feedbackText').value;
 
    console.log('Submitting feedback for booking ID:', bookingId);
    console.log('Rating:', rating, 'Feedback:', feedback);
 
    if (!rating || !feedback) {
        alert('Please provide both a rating and feedback content.');
        return;
    }
 
    const formData = new FormData();
    formData.append('bookingId', bookingId);
    formData.append('rating', rating);
    formData.append('feedbackContent', feedback);
 
    fetch('${pageContext.request.contextPath}/passenger/submit-feedback', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.ok) {
            console.log('Feedback submitted successfully');
            // Try to update the button immediately
            const updated = updateButtonToSubmitted(bookingId);
            console.log('Button updated:', updated);
            
            // Close the form and show success message
            closeFeedbackForm();
            showSuccessMessage();
            
            // Schedule another attempt to update the button after a short delay
            // This is a fallback in case the DOM wasn't ready the first time
            setTimeout(() => {
                if (!updated) {
                    console.log('Attempting button update again after delay');
                    updateButtonToSubmitted(bookingId);
                }
            }, 300);
        } else {
            console.error('Server returned error response');
            alert('Failed to submit feedback. Please try again.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while submitting feedback.');
    });
}
 
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM fully loaded');
    
    // Log all booking IDs for debugging
    const bookingRows = document.querySelectorAll('tr[data-booking-id]');
    console.log('Found', bookingRows.length, 'booking rows');
    bookingRows.forEach(row => {
        console.log('Booking ID:', row.getAttribute('data-booking-id'));
    });
    
    const starInputs = document.querySelectorAll('.star-rating input[type="radio"]');
    const starLabels = document.querySelectorAll('.star-rating label');
 
    starInputs.forEach(input => {
        input.addEventListener('change', function() {
            const value = parseInt(this.value);
starLabels.forEach(label => label.style.color = '#ccc');
            for(let i = 0; i < value; i++) {
                starLabels[i].style.color = '#ffd700';
            }
            updateRatingLabel();
        });
    });
 
    starLabels.forEach((label, index) => {
        label.addEventListener('mouseenter', function() {
starLabels.forEach(l => l.style.color = '#ccc');
            for(let i = 0; i <= index; i++) {
                starLabels[i].style.color = '#ffd700';
            }
        });
 
        label.addEventListener('mouseleave', function() {
            const selectedValue = document.querySelector('.star-rating input[name="rating"]:checked')?.value;
starLabels.forEach(l => l.style.color = '#ccc');
            if(selectedValue) {
                for(let i = 0; i < parseInt(selectedValue); i++) {
                    starLabels[i].style.color = '#ffd700';
                }
            }
        });
    });
 
    document.querySelector('.star-container').addEventListener('mouseleave', function() {
        const selectedValue = document.querySelector('.star-rating input[name="rating"]:checked')?.value;
starLabels.forEach(l => l.style.color = '#ccc');
        if(selectedValue) {
            for(let i = 0; i < parseInt(selectedValue); i++) {
                starLabels[i].style.color = '#ffd700';
            }
        }
    });
});
</script>
</div>
</body>
</html>