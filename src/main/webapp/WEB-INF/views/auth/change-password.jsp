<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Change Password</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
/* 3D Glassmorphism with specified color palette */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
:root {
--cream: #F5EEDC;
--dark-blue: #27548A;
--teal: #183B4E;
--gold: #DDA853;
--glass: rgba(23, 59, 78, 0.3);
--glass-edge: rgba(39, 84, 138, 0.5);
--text-primary: #F5EEDC;
--text-secondary: #DDA853;
--blur: 12px;
--border-radius: 12px;
}
* {
margin: 0;
padding: 0;
box-sizing: border-box;
font-family: 'Poppins', sans-serif;
}
body {
min-height: 100vh;
background: url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
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
box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3),
0 0 0 1px rgba(255, 255, 255, 0.1),
0 10px 30px -5px rgba(0, 0, 0, 0.5);
overflow: hidden;
position: relative;
animation: fadeIn 0.3s ease;
}
.glass-card::before {
content: '';
position: absolute;
top: 0;
left: 0;
right: 0;
bottom: 0;
background: linear-gradient(
135deg,
rgba(221, 168, 83, 0.1),
rgba(39, 84, 138, 0.2)
);
z-index: -1;
border-radius: var(--border-radius);
}
.card-header {
background: linear-gradient(135deg, var(--teal), var(--dark-blue));
color: var(--text-primary);
padding: 25px;
text-align: center;
border-bottom: 1px solid rgba(221, 168, 83, 0.3);
position: relative;
overflow: hidden;
}
.card-header::after {
content: '';
position: absolute;
bottom: 0;
left: 0;
right: 0;
height: 3px;
background: linear-gradient(90deg, transparent, var(--gold), transparent);
}
.card-header h2 {
margin: 0;
font-size: 1.8rem;
font-weight: 600;
letter-spacing: 0.5px;
text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}
.card-body {
padding: 30px;
}
.form-group {
margin-bottom: 20px;
position: relative;
}
.form-group label {
font-weight: 500;
font-size: 0.95rem;
color: var(--text-primary);
margin-bottom: 8px;
display: block;
text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
}
.form-control {
width: 100%;
padding: 14px;
background: rgba(39, 84, 138, 0.2);
border: 1px solid rgba(221, 168, 83, 0.2);
border-radius: 8px;
color: var(--text-primary);
font-size: 15px;
transition: all 0.3s ease;
box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
}
.form-control::placeholder {
color: var(--gold);
opacity: 0.6;
}
.form-control:focus {
outline: none;
background: rgba(39, 84, 138, 0.3);
border-color: var(--gold);
box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1),
0 0 0 2px rgba(221, 168, 83, 0.3);
}
.btn {
width: 100%;
padding: 14px;
background: linear-gradient(135deg, var(--dark-blue), var(--teal));
color: var(--cream);
font-weight: 600;
font-size: 15px;
border: none;
border-radius: 8px;
cursor: pointer;
transition: all 0.3s ease;
box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2),
inset 0 1px 1px rgba(255, 255, 255, 0.1);
position: relative;
overflow: hidden;
}
.btn::after {
content: '🔒';
position: absolute;
right: 15px;
top: 50%;
transform: translateY(-50%);
opacity: 0;
transition: all 0.3s ease;
}
/* Validation styles */
.alert {
color: #FF9E9E;
font-size: 13px;
margin-top: 8px;
display: none;
font-weight: 400;
padding: 8px 12px;
background: rgba(165, 91, 75, 0.15);
border-radius: 6px;
border-left: 3px solid #FF9E9E;
animation: fadeIn 0.3s ease;
}
.alert-danger {
color: #FF9E9E;
font-size: 13px;
margin-bottom: 20px;
font-weight: 400;
padding: 8px 12px;
background: rgba(165, 91, 75, 0.15);
border-radius: 6px;
border-left: 3px solid #FF9E9E;
animation: fadeIn 0.3s ease;
}
.alert-success {
color: #A5D6A7;
font-size: 13px;
margin-bottom: 20px;
font-weight: 400;
padding: 8px 12px;
background: rgba(165, 214, 167, 0.15);
border-radius: 6px;
border-left: 3px solid #A5D6A7;
animation: fadeIn 0.3s ease;
}
@keyframes fadeIn {
from { opacity: 0; }
to { opacity: 1; }
}
/* Valid input indicator */
.valid {
position: absolute;
right: 15px;
top: 40px;
color: #A5D6A7;
font-size: 16px;
display: none;
text-shadow: 0 0 5px rgba(165, 214, 167, 0.5);
}
/* Loading animation */
.loader {
display: none;
width: 24px;
height: 24px;
border: 3px solid rgba(221, 168, 83, 0.3);
border-radius: 50%;
border-top-color: var(--gold);
animation: spin 1s ease-in-out infinite;
margin: 10px auto 0;
}
@keyframes spin {
to { transform: rotate(360deg); }
}

/* Back button styles */
.back-btn {
position: absolute;
left: 20px;
top: 50%;
transform: translateY(-50%);
color: var(--cream);
text-decoration: none;
display: flex;
align-items: center;
font-weight: 500;
transition: all 0.3s ease;
padding: 8px 15px;
background: rgba(39, 84, 138, 0.3);
border-radius: 6px;
border: 1px solid rgba(221, 168, 83, 0.3);
}

.back-btn:hover {
background: rgba(39, 84, 138, 0.5);
border-color: var(--gold);
}

.back-btn i {
margin-right: 6px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
.container {
padding: 15px;
}
.card-header {
padding: 20px;
}
.card-header h2 {
font-size: 1.5rem;
}
.card-body {
padding: 20px;
}
.back-btn {
padding: 6px 12px;
font-size: 14px;
}
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container">
<div class="glass-card">
<div class="card-header">
<a href="${pageContext.request.contextPath}/manager/dashboard" class="back-btn"><i class="fas fa-arrow-left"></i> Back</a>
<h2><i class="fas fa-lock icon"></i> Change Password</h2>
</div>
<div class="card-body">
<c:if test="${not empty error}">
<div class="alert-danger"><i class="fas fa-exclamation-circle"></i> ${error}</div>
</c:if>
<c:if test="${not empty success}">
<div class="alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
</c:if>
<form action="${pageContext.request.contextPath}/auth/change-password" method="post" onsubmit="return validateForm();">
<div class="form-group">
<label for="currentPassword"><span><i class="fas fa-key icon"></i></span>Current Password</label>
<input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="Enter current password" required>
<div id="currentPasswordAlert" class="alert"><i class="fas fa-exclamation-circle"></i> Current password is required</div>
<span class="valid" id="currentPasswordValid"><i class="fas fa-check-circle"></i></span>
</div>
<div class="form-group">
<label for="newPassword"><span><i class="fas fa-key icon"></i></span>New Password</label>
<input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="At least 7 chars, letter, digit, special char" required>
<div id="newPasswordAlert" class="alert"><i class="fas fa-exclamation-circle"></i> Password must be at least 7 characters, including a letter, digit, and special character</div>
<span class="valid" id="newPasswordValid"><i class="fas fa-check-circle"></i></span>
</div>
<div class="form-group">
<label for="confirmPassword"><span><i class="fas fa-lock icon"></i></span>Confirm New Password</label>
<input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Re-enter new password" required>
<div id="confirmPasswordAlert" class="alert"><i class="fas fa-exclamation-circle"></i> Passwords do not match</div>
<span class="valid" id="confirmPasswordValid"><i class="fas fa-check-circle"></i></span>
</div>
<button type="submit" class="btn">Change Password</button>
<div class="loader" id="formLoader"></div>
</form>
</div>
</div>
</div>

<script>
// Enhanced validation with visual feedback
function validateForm() {
let isValid = true;
const currentPassword = document.getElementById("currentPassword").value;
const newPassword = document.getElementById("newPassword").value;
const confirmPassword = document.getElementById("confirmPassword").value;

// Clear existing alerts and valid indicators
document.querySelectorAll('.alert').forEach(alert => alert.style.display = 'none');
document.querySelectorAll('.valid').forEach(icon => icon.style.display = 'none');

// Validate current password
if (currentPassword === "") {
document.getElementById("currentPasswordAlert").style.display = "block";
isValid = false;
} else {
document.getElementById("currentPasswordValid").style.display = "inline-block";
}

// Validate new password (at least 7 chars, letter, digit, special char)
const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{7,}$/;
if (!passwordRegex.test(newPassword)) {
document.getElementById("newPasswordAlert").style.display = "block";
isValid = false;
} else {
document.getElementById("newPasswordValid").style.display = "inline-block";
}

// Validate new password is not the same as current password
if (newPassword === currentPassword) {
document.getElementById("newPasswordAlert").textContent = "New password must be different from your current password";
document.getElementById("newPasswordAlert").style.display = "block";
document.getElementById("newPasswordValid").style.display = "none";
isValid = false;
}

// Validate confirm password
if (newPassword !== confirmPassword) {
document.getElementById("confirmPasswordAlert").style.display = "block";
isValid = false;
} else if (passwordRegex.test(newPassword) && newPassword !== currentPassword) {
document.getElementById("confirmPasswordValid").style.display = "inline-block";
}

// Show loading animation if form is valid
if (isValid) {
document.getElementById("formLoader").style.display = "block";
document.querySelector('button[type="submit"]').disabled = true;
}

return isValid;
}

// Real-time validation for better UX
document.getElementById('currentPassword').addEventListener('input', function() {
if (this.value !== '') {
document.getElementById("currentPasswordAlert").style.display = "none";
document.getElementById("currentPasswordValid").style.display = "inline-block";
} else {
document.getElementById("currentPasswordValid").style.display = "none";
}
});

document.getElementById('newPassword').addEventListener('input', function() {
const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{7,}$/;
const currentPassword = document.getElementById('currentPassword').value;
  
if (passwordRegex.test(this.value)) {
document.getElementById("newPasswordValid").style.display = "inline-block";
  
// Check if new password is same as current password
if (this.value === currentPassword && currentPassword !== '') {
document.getElementById("newPasswordAlert").textContent = "New password must be different from your current password";
document.getElementById("newPasswordAlert").style.display = "block";
document.getElementById("newPasswordValid").style.display = "none";
} else {
document.getElementById("newPasswordAlert").style.display = "none";
}
} else {
document.getElementById("newPasswordAlert").textContent = "Password must be at least 7 characters, including a letter, digit, and special character";
document.getElementById("newPasswordAlert").style.display = "block";
document.getElementById("newPasswordValid").style.display = "none";
}
});

document.getElementById('confirmPassword').addEventListener('input', function() {
const newPassword = document.getElementById('newPassword').value;
const currentPassword = document.getElementById('currentPassword').value;
const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{7,}$/;
  
if (this.value === newPassword && passwordRegex.test(newPassword) && newPassword !== currentPassword) {
document.getElementById("confirmPasswordAlert").style.display = "none";
document.getElementById("confirmPasswordValid").style.display = "inline-block";
} else {
document.getElementById("confirmPasswordValid").style.display = "none";
if (this.value !== "" && this.value !== newPassword) {
document.getElementById("confirmPasswordAlert").style.display = "block";
}
}
});
</script>
</body>
</html>