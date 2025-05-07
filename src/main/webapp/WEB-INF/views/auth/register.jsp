<%@ page contentType="text/html;charset=UTF-8" %> 
<%@taglib prefix="c" uri="jakarta.tags.core"%> 
<!DOCTYPE html> 
<html> 
<head> 
<title>FlySmart - Register</title>
<style>
/* Updated Glassmorphism with login page color scheme */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap');
:root {
    --glass: rgba(39, 84, 138, 0.15);
    --glass-edge: rgba(221, 168, 83, 0.2);
    --text-primary: #F5EEDC;
    --text-secondary: rgba(245, 238, 220, 0.8);
    --blur: 20px;
    --border-radius: 16px;
    --color-error: #ff4d4d;
    --color-success: #4BB543;
}
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Inter', sans-serif;
}
body {
    min-height: 100vh;
    background: linear-gradient(135deg, rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)), url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
    background-size: cover;
    display: flex;
    justify-content: center;
    align-items: center;
    color: var(--text-primary);
}
.container {
    width: 100%;
    max-width: 600px;
    padding: 20px;
}
.glass-card {
    background: var(--glass);
    backdrop-filter: blur(var(--blur));
    -webkit-backdrop-filter: blur(var(--blur));
    border-radius: var(--border-radius);
    border: 1px solid var(--glass-edge);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    overflow: hidden;
}
.card-header {
    background-color: rgba(39, 84, 138, 0.3);
    color: var(--text-primary);
    padding: 25px;
    text-align: center;
    border-bottom: 1px solid var(--glass-edge);
}
.card-header h3 {
    margin: 0;
    font-size: 1.8rem;
    font-weight: 500;
    letter-spacing: 0.5px;
}
.card-body {
    padding: 30px;
}
.form-group {
    margin-bottom: 20px;
}
.form-group label {
    font-weight: 500;
    font-size: 0.95rem;
    color: var(--text-primary);
    margin-bottom: 8px;
    display: block;
}
.form-group span {
    font-size: 1.2rem;
    margin-right: 8px;
    color: var(--text-primary);
}
.form-control {
    width: 100%;
    padding: 14px;
    background: rgba(245, 238, 220, 0.1);
    border: 1px solid rgba(39, 84, 138, 0.3);
    border-radius: 10px;
    color: var(--text-primary);
    font-size: 15px;
    transition: all 0.3s ease;
}
.form-control::placeholder {
    color: var(--text-secondary);
}
.form-control:focus {
    outline: none;
    background: rgba(245, 238, 220, 0.2);
    border-color: #DDA853;
}
select.form-control {
    appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23DDA853'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 14px center;
    background-size: 14px;
}
select.form-control option {
    padding: 10px;
    background: white;
    color: #1a1a1a;
}
.btn {
    width: 100%;
    padding: 14px;
    background: #DDA853;
    color: #183B4E;
    font-weight: 500;
    font-size: 15px;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 10px;
}
.btn:hover {
    background: rgba(221, 168, 83, 0.9);
    transform: translateY(-1px);
}
.text-center {
    text-align: center;
}
.mt-3 {
    margin-top: 1rem;
}
a {
    color: var(--text-secondary);
    text-decoration: none;
    transition: all 0.3s ease;
}
a:hover {
    color: var(--text-primary);
}
/* Validation alerts */
.alert {
    color: var(--color-error);
    font-size: 12px;
    margin-top: 5px;
    display: none;
    font-weight: 400;
}
/* Success banner */
.success-banner {
    background: rgba(75, 181, 67, 0.1);
    border: 1px solid rgba(75, 181, 67, 0.3);
    color: var(--color-success);
    padding: 10px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
    font-size: 14px;
    display: none;
}
/* Error banner */
.error-banner {
    background: rgba(255, 77, 77, 0.1);
    border: 1px solid rgba(255, 77, 77, 0.3);
    color: var(--color-error);
    padding: 10px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
    font-size: 14px;
}
/* Profile image preview */
.profile-preview {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 10px;
    border: 2px solid #DDA853;
    display: none;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}
.file-input-wrapper {
    position: relative;
    overflow: hidden;
    display: inline-block;
    width: 100%;
}
.file-input-wrapper input[type="file"] {
    position: absolute;
    left: 0;
    top: 0;
    opacity: 0;
    width: 100%;
    height: 100%;
    cursor: pointer;
}
.file-input-label {
    display: block;
    padding: 12px;
    background: rgba(245, 238, 220, 0.1);
    border: 1px dashed rgba(221, 168, 83, 0.5);
    border-radius: 10px;
    text-align: center;
    color: var(--text-secondary);
    transition: all 0.3s ease;
}
.file-input-label:hover {
    border-color: #DDA853;
    background: rgba(245, 238, 220, 0.2);
}
/* Page header */
.logo {
    text-align: center;
    margin-bottom: 20px;
}
.logo h1 {
    font-weight: 500;
    font-size: 26px;
    letter-spacing: 0.5px;
    color: var(--text-primary);
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}
</style> 
</head> 
<body> 
<div class="container"> 
<div class="logo"> 
<h1>Flight Reservation</h1> 
</div> 
<div class="glass-card"> 
<div class="card-header"> 
<h3>Passenger Registration</h3> 
</div> 
<div class="card-body"> 
<div id="successBanner" class="success-banner"> 
<i class="fas fa-check-circle"></i> Registration successful! Redirecting to login... 
</div> 
<c:if test="${not empty error}"> 
<div class="error-banner"> 
<i class="fas fa-exclamation-circle"></i> ${error} 
</div> 
</c:if> 
<form id="registrationForm" action="${pageContext.request.contextPath}/auth/register" method="post" enctype="multipart/form-data"> 
<div class="form-group text-center"> 
<img id="profilePreview" class="profile-preview" src="#" alt="Profile Preview"> 
<div class="file-input-wrapper"> 
<label for="profileImage" class="file-input-label"> 
<span>📷</span> Upload Profile Image (Optional) 
</label> 
<input type="file" id="profileImage" name="profileImage" accept="image/*" onchange="previewImage(this)"> 
</div> 
</div> 
<div class="form-group"> 
<label for="name"><span>👤</span>Full Name:</label> 
<input type="text" id="name" name="name" class="form-control" value="${user.name}" required> 
<div id="nameAlert" class="alert">❌ Full Name is required.</div> 
</div> 
<div class="form-group"> 
<label for="email"><span>✉</span>Email:</label> 
<input type="email" id="email" name="email" class="form-control" value="${user.email}" required> 
<div id="emailAlert" class="alert">❌ Please enter a valid email address.</div> 
<div id="emailExistsAlert" class="alert" style="display: none;">❌ User with this email already exists.</div> 
</div> 
<div class="form-group"> 
<label for="dob"><span>📅</span>Date of Birth:</label> 
<input type="date" id="dob" name="dob" class="form-control" value="${user.dob}" required> 
<div id="dobAlert" class="alert">❌ Date of Birth is required.</div> 
</div> 
<div class="form-group"> 
<label for="gender"><span>⚧</span>Gender:</label> 
<select id="gender" name="gender" class="form-control" required> 
<option value="" disabled <c:if test="${empty user.gender}">selected</c:if>>Select Gender</option> 
<option value="Male" <c:if test="${user.gender == 'Male'}">selected</c:if>>Male</option> 
<option value="Female" <c:if test="${user.gender == 'Female'}">selected</c:if>>Female</option> 
<option value="Other" <c:if test="${user.gender == 'Other'}">selected</c:if>>Other</option> 
</select> 
</div> 
<div class="form-group"> 
<label for="phone"><span>📞</span>Phone:</label> 
<input type="tel" id="phone" name="phone" class="form-control" value="${user.phone}" required> 
<div id="phoneAlert" class="alert">❌ Please enter a valid 10-digit phone number.</div> 
</div> 
<div class="form-group"> 
<label for="password"><span>🔑</span>Password:</label> 
<input type="password" id="password" name="password" class="form-control" required> 
<div id="passwordAlert" class="alert">❌ Password must be at least 8 characters long with at least one number and one special character.</div> 
</div> 
<div class="form-group"> 
<label for="confirmPassword"><span>🔒</span>Confirm Password:</label> 
<input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required> 
<div id="confirmPasswordAlert" class="alert">❌ Passwords do not match.</div> 
</div> 
<input type="hidden" name="role" value="PASSENGER"> 
<button type="submit" class="btn">Register</button> 
</form> 
<div class="mt-3 text-center"> 
<a href="${pageContext.request.contextPath}/auth/login">Already have an account? Login</a> 
</div> 
</div> 
</div> 
</div> 
<script> 
// Image preview function 
function previewImage(input) { 
const preview = document.getElementById('profilePreview'); 
const file = input.files[0]; 
const reader = new FileReader(); 
if (file) { 
reader.onload = function(e) { 
preview.src = e.target.result; 
preview.style.display = 'block'; 
} 
reader.readAsDataURL(file); 
} else { 
preview.style.display = 'none'; 
preview.src = '#'; 
} 
} 

// Enhanced validation function 
document.getElementById('registrationForm').addEventListener('submit', function(e) { 
e.preventDefault(); 
// Clear all previous alerts 
document.querySelectorAll('.alert').forEach(alert => { 
alert.style.display = 'none'; 
}); 
let isValid = true; 
const name = document.getElementById("name").value.trim(); 
const email = document.getElementById("email").value.trim(); 
const dob = document.getElementById("dob").value; 
const phone = document.getElementById("phone").value.trim(); 
const password = document.getElementById("password").value; 
const confirmPassword = document.getElementById("confirmPassword").value; 

// Name validation 
if (name.length < 3) { 
document.getElementById("nameAlert").textContent = "❌ Full Name must be at least 3 characters long."; 
document.getElementById("nameAlert").style.display = "block"; 
isValid = false; 
} 

// Email validation 
const emailRegex = /^\S+@\S+\.\S+$/; 
if (!emailRegex.test(email)) { 
document.getElementById("emailAlert").style.display = "block"; 
isValid = false; 
} 

// DOB validation 
if (dob === "") { 
document.getElementById("dobAlert").style.display = "block"; 
isValid = false; 
} 

// Phone validation (exactly 10 digits) 
const phoneRegex = /^\d{10}$/; 
if (!phoneRegex.test(phone)) { 
document.getElementById("phoneAlert").style.display = "block"; 
isValid = false; 
} 

// Password validation (min 8 chars, at least 1 number and 1 special char) 
const passwordRegex = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$/; 
if (!passwordRegex.test(password)) { 
document.getElementById("passwordAlert").style.display = "block"; 
isValid = false; 
} 

// Confirm password validation 
if (password !== confirmPassword) { 
document.getElementById("confirmPasswordAlert").style.display = "block"; 
isValid = false; 
} 

// If all validations pass, submit the form 
if (isValid) { 
// Show success message 
document.getElementById('successBanner').style.display = 'block'; 
// Submit the form after a small delay to show the message 
setTimeout(() => { 
this.submit(); 
}, 1500); 
} 
}); 

// Check for error message and show specific error
window.onload = function() {
  const errorMessage = document.querySelector('.error-banner');
  if (errorMessage && errorMessage.textContent.includes('email or phone number already exists')) {
    // Show the email exists alert
    document.getElementById('emailExistsAlert').style.display = 'block';
  }
}
</script> 
</body> 
</html>

