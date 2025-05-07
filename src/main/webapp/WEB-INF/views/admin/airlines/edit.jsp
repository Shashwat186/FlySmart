<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Airline</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
--transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
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

/* 3D Glassmorphism Header */
header {
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
transform-style: preserve-3d;
transform: perspective(1000px);
transition: var(--transition);
}

header:hover {
transform: perspective(1000px) rotateX(5deg);
box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4),
0 4px 30px rgba(221, 168, 83, 0.2);
}

header h1 {
margin: 0 0 16px 0;
font-weight: 300;
letter-spacing: 2px;
text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
display: flex;
align-items: center;
justify-content: center;
gap: 10px;
}

/* Navigation with 3D effects */
nav {
display: flex;
justify-content: center;
flex-wrap: wrap;
gap: 15px;
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
display: flex;
align-items: center;
gap: 8px;
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

/* Content Area */
.content {
max-width: 600px;
margin: 40px auto;
padding: 30px;
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow),
0 10px 20px rgba(221, 168, 83, 0.1);
transform-style: preserve-3d;
transform: perspective(1000px);
transition: var(--transition);
}

.content:hover {
box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4),
0 10px 20px rgba(221, 168, 83, 0.2);
transform: perspective(1000px) translateY(-5px);
}

/* Form Styling */
.form-group {
margin-bottom: 24px;
position: relative;
}

label {
display: block;
font-weight: 500;
margin-bottom: 8px;
color: var(--color-light);
display: flex;
align-items: center;
gap: 8px;
}

input[type="text"] {
width: 100%;
padding: 12px 15px;
font-size: 16px;
background: rgba(255, 255, 255, 0.05);
border: var(--glass-border);
border-radius: 8px;
color: var(--color-light);
transition: var(--transition);
box-sizing: border-box;
}

input[type="text"]:focus {
border-color: var(--color-accent);
background: rgba(255, 255, 255, 0.1);
outline: none;
box-shadow: 0 0 15px rgba(221, 168, 83, 0.3);
transform: translateY(-2px);
}

.error-message {
color: #ff6b6b;
font-size: 14px;
margin-top: 5px;
display: flex;
align-items: center;
gap: 5px;
}

/* Button Styling */
.btn {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
color: var(--color-light);
border: var(--glass-border);
padding: 12px 25px;
font-size: 15px;
font-weight: 500;
border-radius: var(--glass-radius);
cursor: pointer;
transition: var(--transition);
letter-spacing: 0.5px;
display: inline-flex;
align-items: center;
gap: 8px;
text-decoration: none;
margin-right: 10px;
}

.btn:hover {
background: rgba(221, 168, 83, 0.2);
box-shadow: 0 5px 15px rgba(221, 168, 83, 0.3);
transform: translateY(-3px);
}
.red-text {
    	color: red;
    	font-weight: bold;
		}

.btn-primary {
background: rgba(221, 168, 83, 0.2);
}

.btn-primary:hover {
background: rgba(221, 168, 83, 0.4);
}

.btn-secondary {
background: rgba(229, 62, 62, 0.2);
}

.btn-secondary:hover {
background: rgba(229, 62, 62, 0.4);
}

/* Icons and Symbols */
.icon {
display: inline-block;
margin-right: 8px;
color: var(--color-accent);
}

/* Responsive Design */
@media (max-width: 768px) {
.content {
margin: 20px;
padding: 20px;
}

nav {
flex-direction: column;
align-items: center;
gap: 10px;
}

 
header h1 {
font-size: 1.5rem;
}
}
</style>
</head>
<body>
<div class="dashboard">
<header>
<h1><i class="fas fa-building icon"></i> Edit Airline</h1>

</header>
<div class="content">

<c:if test="${not empty error}">
        <div class="error-banner red-text">
             ${error}
        </div>
    </c:if>
<form method="post" action="${pageContext.request.contextPath}/admin/airlines/edit/${airline.airlineId}" onsubmit="return validateForm()">
<div class="form-group">
<label for="name"><i class="fas fa-building icon"></i> Name:</label>
<input type="text" id="name" name="name" value="${airline.name}" required placeholder="Enter airline name">
<div id="nameError" class="error-message"></div>
</div>
<div class="form-group">
<label for="code"><i class="fas fa-code icon"></i> Code:</label>
<input type="text" id="code" name="code" value="${airline.code}" required placeholder="Enter 2-letter code" maxlength="2">
<div id="codeError" class="error-message"></div>
</div>
<div class="form-group">
<label for="contactInfo"><i class="fas fa-phone icon"></i> Contact Info:</label>
<input type="text" id="contactInfo" name="contactInfo" value="${airline.contactInfo}" placeholder="Optional contact information">
<div id="contactError" class="error-message"></div>
</div>
<button type="submit" class="btn btn-primary"><i class="fas fa-save icon"></i> Update</button>
<a href="${pageContext.request.contextPath}/admin/airlines" class="btn btn-secondary"><i class="fas fa-times icon"></i> Cancel</a>
</form>
</div>
</div>

<script>
// Form Validation
function validateForm() {
let valid = true;

// Get input elements and error message containers
const nameInput = document.getElementById('name');
const codeInput = document.getElementById('code');
const contactInput = document.getElementById('contactInfo');
const nameError = document.getElementById('nameError');
const codeError = document.getElementById('codeError');
const contactError = document.getElementById('contactError');

// Reset error messages
nameError.textContent = '';
codeError.textContent = '';
contactError.textContent = '';

// Validate Name
if (!nameInput.value.trim()) {
nameError.textContent = 'Name is required!';
valid = false;
}

// Validate Code
if (!codeInput.value.trim()) {
codeError.textContent = 'Code is required!';
valid = false;
} else if (codeInput.value.trim().length !== 2) {
codeError.textContent = 'Code must be exactly 2 characters!';
valid = false;
}

// Validate Contact Info (optional validation)
if (contactInput.value.trim()) {
if (contactInput.value.trim().length !== 10) {
contactError.textContent = 'Contact Info must be exactly 10 digits!';
valid = false;
}
}

return valid;
}

// Add interactive 3D effects to form
document.addEventListener('DOMContentLoaded', function() {
const form = document.querySelector('form');
if (form) {
form.addEventListener('mousemove', (e) => {
const xAxis = (window.innerWidth / 2 - e.pageX) / 25;
const yAxis = (window.innerHeight / 2 - e.pageY) / 25;
form.style.transform = `translateZ(10px) rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
});
form.addEventListener('mouseleave', () => {
form.style.transform = 'translateZ(0) rotateY(0) rotateX(0)';
});
}
});
</script>
</body>
</html>
