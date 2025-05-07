<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback Management</title>
<style>
:root {
--color-light: #F5EEDC;
--color-primary: #27548A;
--color-dark: #183B4E;
--color-accent: #DDA853;
--glass-bg: rgba(39, 84, 138, 0.15);
--glass-border: rgba(221, 168, 83, 0.2);
--blur: 10px;
--text-color: var(--color-light);
--accent-color: var(--color-accent);
--danger-color: #ff4d4d;
--success-color: #4dff88;
--warning-color: #ffcc4d;
--info-color: #4dc3ff;
}

body {
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
background: linear-gradient(135deg, rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85));
color: var(--text-color);
min-height: 100vh;
margin: 0;
padding: 20px;
display: flex;
justify-content: center;
align-items: flex-start;
}

.container {
width: 95%;
max-width: 1200px;
background: var(--glass-bg);
backdrop-filter: blur(var(--blur));
-webkit-backdrop-filter: blur(var(--blur));
border-radius: 20px;
border: 1px solid var(--glass-border);
box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.36);
padding: 30px;
margin: 20px 0;
}

.header-container {
display: flex;
align-items: center;
justify-content: center;
margin-bottom: 30px;
position: relative;
}

h1 {
color: var(--color-light);
text-align: center;
font-weight: 300;
letter-spacing: 1px;
margin: 0;
}

.back-button {
position: absolute;
left: 0;
display: flex;
align-items: center;
justify-content: center;
background-color: var(--accent-color);
color: white;
border: none;
border-radius: 50px;
padding: 8px 15px;
font-size: 13px;
font-weight: 600;
cursor: pointer;
transition: all 0.3s ease;
text-transform: uppercase;
letter-spacing: 0.5px;
text-decoration: none;
}

.back-button:hover {
background-color: #5a3d8a;
transform: translateY(-2px);
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.table {
width: 100%;
border-collapse: separate;
border-spacing: 0;
margin-bottom: 20px;
background: var(--glass-bg);
backdrop-filter: blur(var(--blur));
border-radius: 15px;
overflow: hidden;
}

.table thead th {
background: rgba(24, 59, 78, 0.5);
color: var(--color-light);
padding: 15px;
text-align: left;
font-weight: 500;
border-bottom: 1px solid var(--glass-border);
}

.table tbody tr {
transition: all 0.3s ease;
background: rgba(255, 255, 255, 0.03);
}

.table tbody tr:hover {
background: rgba(221, 168, 83, 0.1);
}

.table tbody td {
padding: 12px 15px;
border-bottom: 1px solid var(--glass-border);
color: rgba(245, 238, 220, 0.9);
}

.badge {
padding: 5px 10px;
border-radius: 50px;
font-size: 12px;
font-weight: 600;
text-transform: uppercase;
letter-spacing: 0.5px;
}

.badge-warning {
background-color: var(--warning-color);
color: #333;
}

.badge-success {
background-color: var(--success-color);
color: #333;
}

.btn {
border: none;
border-radius: 50px;
padding: 8px 15px;
font-size: 13px;
font-weight: 600;
cursor: pointer;
transition: all 0.3s ease;
text-transform: uppercase;
letter-spacing: 0.5px;
}

.btn-sm {
padding: 5px 12px;
font-size: 12px;
}

.btn-primary {
background-color: var(--accent-color);
color: white;
}

.btn-primary:hover {
background-color: #5a3d8a;
transform: translateY(-2px);
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.alert {
padding: 15px;
border-radius: 10px;
margin-bottom: 20px;
background: var(--glass-bg);
backdrop-filter: blur(var(--blur));
border: 1px solid var(--glass-border);
}

.alert-success {
background-color: rgba(77, 255, 136, 0.1);
color: var(--success-color);
border-color: rgba(77, 255, 136, 0.2);
}

.alert-danger {
background-color: rgba(255, 77, 77, 0.1);
color: var(--danger-color);
border-color: rgba(255, 77, 77, 0.2);
}

.alert-info {
background-color: rgba(77, 195, 255, 0.1);
color: var(--info-color);
border-color: rgba(77, 195, 255, 0.2);
}

/* Confirmation Dialog Styling */
.confirmation-dialog {
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%) perspective(1000px) rotateX(0deg);
backdrop-filter: blur(var(--blur));
-webkit-backdrop-filter: blur(var(--blur));
background: var(--glass-bg);
border: 1px solid var(--glass-border);
border-radius: 20px;
box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.36);
padding: 30px;
z-index: 1000;
text-align: center;
max-width: 400px;
opacity: 0;
visibility: hidden;
transition: all 0.3s ease;
}

.confirmation-dialog.active {
opacity: 1;
visibility: visible;
transform: translate(-50%, -50%) perspective(1000px) rotateX(5deg);
}

.confirmation-dialog button {
margin: 10px 5px 0;
}

::-webkit-scrollbar {
width: 8px;
height: 8px;
}

::-webkit-scrollbar-track {
background: rgba(255, 255, 255, 0.05);
}

::-webkit-scrollbar-thumb {
background: rgba(255, 255, 255, 0.1);
border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
background: rgba(255, 255, 255, 0.2);
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
function confirmMarkAsChecked(url, feedbackId) {
  const dialog = document.getElementById('confirmationDialog');
  const message = document.getElementById('confirmationMessage');
  const confirmYes = document.getElementById('confirmYes');
  const confirmNo = document.getElementById('confirmNo');
  
  message.textContent = 'Are you sure you want to mark this feedback as checked?';
  dialog.classList.add('active');
  
  confirmYes.onclick = function() {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = url;
    document.body.appendChild(form);
    form.submit();
    dialog.classList.remove('active');
  };
  
  confirmNo.onclick = function() {
    dialog.classList.remove('active');
  };
}
</script>
</head>
<body>
<div class="container">
  <div class="header-container">
    <a href="${pageContext.request.contextPath}/owner/dashboard" class="back-button">← Back</a>
    <h1>Customer Feedback Management</h1>
  </div>
  <c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
  </c:if>
  <table class="table table-striped">
    <thead>
      <tr>
        <th>Flight</th>
        <th>Airline</th>
        <th>Departure</th>
        <th>Arrival</th>
        <th>Date</th>
        <th>Rating</th>
        <th>Feedback</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${feedbackList}" var="feedback">
        <tr>
          <td>${feedback.flightNumber}</td>
          <td>${feedback.airlineName}</td>
          <td>${feedback.departureAirportName} (${feedback.departureAirportCode})</td>
          <td>${feedback.arrivalAirportName} (${feedback.arrivalAirportCode})</td>
          <td>
            <c:set var="dateTimeString" value="${feedback.feedbackDateTime}" />
            <fmt:parseDate value="${dateTimeString}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
            <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy HH:mm" />
          </td>
          <td>${feedback.rating}</td>
          <td>${feedback.feedbackContent}</td>
          <td>
            <c:if test="${feedback.status eq 'unchecked'}">
              <span class="badge badge-warning">Unchecked</span>
            </c:if>
            <c:if test="${feedback.status eq 'checked'}">
              <span class="badge badge-success">Checked</span>
            </c:if>
          </td>
          <td>
            <c:if test="${feedback.status eq 'unchecked'}">
              <button type="button" class="btn btn-primary btn-sm" onclick="confirmMarkAsChecked('${pageContext.request.contextPath}/owner/feedback/check/${feedback.feedbackId}', ${feedback.feedbackId})">
                <i class="fas fa-check icon"></i> Mark as Checked
              </button>
            </c:if>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  <c:if test="${empty feedbackList}">
    <div class="alert alert-info"> No feedback entries found. </div>
  </c:if>
</div>

<!-- Confirmation Dialog -->
<div id="confirmationDialog" class="confirmation-dialog">
  <p id="confirmationMessage"></p>
  <button id="confirmYes" class="btn btn-primary"><i class="fas fa-check icon"></i> Yes</button>
  <button id="confirmNo" class="btn btn-primary" style="background-color: var(--danger-color);"><i class="fas fa-times icon"></i> No</button>
</div>
</body>
</html>