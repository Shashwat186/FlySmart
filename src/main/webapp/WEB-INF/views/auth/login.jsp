<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Login | Flight Reservation</title>
<style>
/* Updated Glassmorphism with new color scheme */
@import
	url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap')
	;

:root {
	--glass: rgba(39, 84, 138, 0.15);
	--glass-edge: rgba(221, 168, 83, 0.2);
	--text-primary: #F5EEDC;
	--text-secondary: rgba(245, 238, 220, 0.8);
	--blur: 20px;
	--border-radius: 16px;
	--color-error: #ff4d4d;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Inter', sans-serif;
}

body {
	min-height: 100vh;
	background: linear-gradient(135deg, rgba(24, 59, 78, 0.85),
		rgba(39, 84, 138, 0.85)),
		url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80')
		no-repeat center center fixed;
	background-size: cover;
	display: flex;
	justify-content: center;
	align-items: center;
	color: var(--text-primary);
}

.container {
	width: 380px;
	padding: 0 20px;
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

.logo {
	text-align: center;
	margin-bottom: 30px;
}

.logo h1 {
	font-weight: 500;
	font-size: 26px;
	letter-spacing: 0.5px;
}

.input-group {
	margin-bottom: 20px;
}

input, select {
	width: 100%;
	padding: 14px;
	background: rgba(245, 238, 220, 0.1);
	border: 1px solid rgba(39, 84, 138, 0.3);
	border-radius: 10px;
	color: var(--text-primary);
	font-size: 15px;
	transition: all 0.3s ease;
}
/* Ensure all options are visible */
select option {
	padding: 10px;
	background: white;
	color: #1a1a1a;
}

input::placeholder {
	color: var(--text-secondary);
}

input:focus, select:focus {
	outline: none;
	background: rgba(245, 238, 220, 0.2);
	border-color: #DDA853;
}

select {
	appearance: none;
	background-image:
		url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23DDA853'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
	background-repeat: no-repeat;
	background-position: right 14px center;
	background-size: 14px;
}

.btn {
	width: 100%;
	padding: 14px;
	background: #DDA853;
	border: none;
	border-radius: 10px;
	color: #183B4E;
	font-weight: 500;
	font-size: 15px;
	cursor: pointer;
	transition: all 0.3s ease;
	margin-top: 10px;
}

.btn:hover {
	background: rgba(221, 168, 83, 0.9);
	transform: translateY(-1px);
}

.links {
	display: flex;
	justify-content: space-between;
	margin-top: 22px;
	font-size: 13px;
}

.links a {
	color: var(--text-secondary);
	text-decoration: none;
	transition: all 0.3s ease;
}

.links a:hover {
	color: var(--text-primary);
}
/* Minimal validation */
.error-text {
	color: var(--color-error);
	font-size: 12px;
	margin-top: 5px;
	display: none;
	font-weight: 400;
}
.red-text {
    	color: red;
    	font-weight: bold;
		}
</style>
</head>
<body>
	<div class="container">
		<div class="glass-card">
			<div class="logo">
				<h1>FlySmart</h1>
			</div>
			<c:if test="${not empty error}">
				<div
					style="color: #ff4d4d; text-align: center; margin-bottom: 20px; font-size: 13px;">
					${error}</div>
			</c:if>
			<form action="${pageContext.request.contextPath}/auth/login"
				method="post" onsubmit="return validateForm()">
				<div class="input-group">
    <input type="email" name="email" placeholder="Email" required value="${email}">
</div>
<div class="input-group">
    <input type="password" id="password" name="password" placeholder="Password" required oninput="clearError()">
    <div id="passwordError" class="error-text">Password must be at least 6 characters</div>
</div>
<div class="input-group">
    <select name="role">
        <option value="PASSENGER" ${role == 'PASSENGER' ? 'selected' : ''}>🧳Passenger</option>
        <option value="MANAGER" ${role == 'MANAGER' ? 'selected' : ''}>🛫 Flight Manager</option>
        <option value="OWNER" ${role == 'OWNER' ? 'selected' : ''}>🏢 Business Owner</option>
    </select>
</div>
				<button type="submit" class="btn">Login</button>
			</form>
			<div class="links">
				<a href="${pageContext.request.contextPath}/auth/register">Create
					Account</a> <a
					href="${pageContext.request.contextPath}/auth/forgot-password">Forgot
					Password?</a>
			</div>
		</div>
	</div>

	<script>
		function validateForm() {
			const password = document.getElementById('password');
			const errorElement = document.getElementById('passwordError');
			if (password.value.length < 6) {
				errorElement.style.display = 'block';
				return false;
			}
			return true;
		}
		function clearError() {
			document.getElementById('passwordError').style.display = 'none';
		}
	</script>
</body>
</html>
