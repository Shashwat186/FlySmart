<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Original styles remain unchanged */
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
        }
 
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            color: var(--color-light);
            background: linear-gradient(135deg, var(--color-dark), var(--color-primary)), url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            min-height: 100vh;
            animation: gradientShift 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
        }
 
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
 
        .container {
            max-width: 500px;
            width: 90%;
            padding: 30px;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            border-radius: var(--glass-radius);
            box-shadow: var(--glass-shadow), 0 10px 20px rgba(221, 168, 83, 0.1);
            transform-style: preserve-3d;
            transform: perspective(1000px) translateY(0);
            transition: all 0.5s ease;
            text-align: center;
        }
 
        .container:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4), 0 10px 20px rgba(221, 168, 83, 0.2);
            transform: perspective(1000px) translateY(-5px);
        }
 
        .container h2 {
            margin: 0 0 20px 0;
            font-weight: 300;
            letter-spacing: 2px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            color: var(--color-light);
        }
 
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            border: var(--glass-border);
            transform: translateZ(10px);
        }
 
        .alert-danger {
            background: rgba(220, 53, 69, 0.2);
            color: var(--color-light);
        }
 
        .form-group {
            margin-bottom: 20px;
            transform: translateZ(10px);
        }
 
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--color-accent);
            text-align: left;
        }
 
        .form-group input {
            width: 100%;
            padding: 10px;
            border: var(--glass-border);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.05);
            color: var(--color-light);
            font-size: 14px;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }
 
        .form-group input:focus {
            outline: none;
            border-color: var(--color-accent);
            background: rgba(221, 168, 83, 0.1);
        }
 
        .btn {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(221, 168, 83, 0.1);
            color: var(--color-light);
            border: var(--glass-border);
            padding: 10px 20px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            border-radius: 30px;
            transition: all 0.3s ease;
            cursor: pointer;
            letter-spacing: 0.5px;
            display: inline-block;
            transform-style: preserve-3d;
            transform: perspective(500px) translateZ(0);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }
 
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(221, 168, 83, 0.2), transparent);
            transition: all 0.5s ease;
        }
 
        .btn:hover {
            background: rgba(221, 168, 83, 0.2);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            transform: perspective(500px) translateZ(20px) rotateX(5deg);
            color: var(--color-light);
        }
 
        .btn:hover::before {
            left: 100%;
        }
 
        .btn-primary {
            background: rgba(39, 84, 138, 0.3);
        }
 
        .btn-primary:hover {
            background: rgba(39, 84, 138, 0.4);
        }
 
        .mt-3 {
            margin-top: 20px;
            transform: translateZ(10px);
        }
 
        .mt-3 a {
            color: var(--color-accent);
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
            position: relative;
        }
 
        .mt-3 a:hover {
            color: var(--color-light);
        }
 
        .mt-3 a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 1px;
            background: var(--color-accent);
            transform: scaleX(0);
            transform-origin: right;
            transition: transform 0.3s ease;
        }
 
        .mt-3 a:hover::after {
            transform: scaleX(1);
            transform-origin: left;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container">
    <h2><i class="fas fa-lock icon"></i> Reset Password</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger"><i class="fas fa-exclamation-triangle icon"></i> ${error}</div>
    </c:if>
    <div id="clientError" class="alert alert-danger" style="display: none;"></div>
    <form action="${pageContext.request.contextPath}/auth/reset-password" method="post" id="resetPasswordForm">
        <input type="hidden" name="token" value="${token}">
        <div class="form-group">
            <label for="newPassword"><i class="fas fa-key icon"></i> New Password</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword"><i class="fas fa-key icon"></i> Confirm New Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary"><i class="fas fa-check icon"></i> Reset Password</button>
    </form>
    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/auth/login"><i class="fas fa-arrow-left icon"></i> Back to Login</a>
    </div>
</div>

<script>
document.getElementById('resetPasswordForm').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const errorDiv = document.getElementById('clientError');
    
    // Reset error display
    errorDiv.style.display = 'none';
    errorDiv.innerHTML = '';
    
    // Password validation rules
    const minLength = 8;
    const hasUpperCase = /[A-Z]/.test(newPassword);
    const hasLowerCase = /[a-z]/.test(newPassword);
    const hasNumbers = /\d/.test(newPassword);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(newPassword);
    
    // Validate password
    if (newPassword.length < minLength) {
        errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle icon"></i> Password must be at least 8 characters long';
        errorDiv.style.display = 'block';
        return;
    }
    
    if (!hasUpperCase || !hasLowerCase || !hasNumbers || !hasSpecialChar) {
        errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle icon"></i> Password must contain uppercase, lowercase, number, and special character';
        errorDiv.style.display = 'block';
        return;
    }
    
    if (newPassword !== confirmPassword) {
        errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle icon"></i> Passwords do not match';
        errorDiv.style.display = 'block';
        return;
    }
    
    // If all validations pass, submit the form
    this.submit();
});
</script>

</body>
</html>