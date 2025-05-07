<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%-- For formatting dates/times --%>
<!DOCTYPE html>
<html>
<head>
<title>Business Owner Dashboard</title>
<style>
/* Base Styling with color scheme */
:root {
--color-light: #F5EEDC;
--color-primary: #27548A;
--color-dark: #183B4E;
--color-accent: #DDA853;
--glass-bg: rgba(39, 84, 138, 0.15); /* Primary color with transparency for glass */
--glass-border: 1px solid rgba(221, 168, 83, 0.2); /* Accent color with transparency for border */
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
}

/* Navigation with 3D effects */
nav {
display: flex;
justify-content: center;
flex-wrap: nowrap; /* Changed to nowrap to force single line */
padding: 10px 0; /* Added some padding for better spacing */
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
white-space: nowrap; /* Prevent text from wrapping */
}
nav a:hover,
nav a.active {
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
nav a:hover::after,
nav a.active::after {
transform: scaleX(1);
transform-origin: left;
}

/* Content Area */
.content {
max-width: 1200px;
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

/* Stats Cards */
.stats {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
gap: 24px;
margin-bottom: 40px;
perspective: 1000px;
}

.stat-card {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow);
padding: 30px;
text-align: center;
transition: var(--transition);
transform-style: preserve-3d;
position: relative;
}

.stat-card:hover {
transform: translateY(-10px) rotateX(5deg) rotateY(5deg);
box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.stat-card h3 {
margin-top: 0;
font-weight: 500;
font-size: 18px;
letter-spacing: 0.5px;
color: var(--color-light);
}

.stat-card p {
font-size: 36px;
font-weight: 300;
margin: 10px 0 0;
color: var(--color-accent);
text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

/* Recent Activity - Modified to remove floating effects */
.recent-activity {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow);
padding: 30px;
}

.recent-activity h2 {
margin-top: 0;
margin-bottom: 20px;
font-weight: 400;
letter-spacing: 1px;
color: var(--color-light);
}

/* Added scrollbar functionality to action log container */
.action-log-container {
max-height: 400px; /* Adjust height as needed */
overflow-y: auto;
border-radius: 12px;
background: rgba(39, 84, 138, 0.2);
margin-bottom: 20px;
border: var(--glass-border);
}

/* Table Styling */
table {
width: 100%;
border-collapse: separate;
border-spacing: 0;
overflow: hidden;
border-radius: 8px;
}

table thead tr {
background: rgba(24, 59, 78, 0.5);
position: sticky;
top: 0;
z-index: 10;
}

table th, table td {
padding: 16px;
text-align: left;
border-bottom: var(--glass-border);
}

table th {
font-weight: 500;
letter-spacing: 1px;
font-size: 14px;
text-transform: uppercase;
color: var(--color-accent);
}

table td {
color: rgba(245, 238, 220, 0.9);
}

table tbody tr {
background: rgba(255, 255, 255, 0.03);
transition: var(--transition);
}

table tbody tr:hover {
background: rgba(221, 168, 83, 0.1);
}

/* Custom scrollbar styling for action log container */
.action-log-container::-webkit-scrollbar {
width: 8px;
height: 8px;
}

.action-log-container::-webkit-scrollbar-track {
background: rgba(255, 255, 255, 0.05);
border-radius: 4px;
}

.action-log-container::-webkit-scrollbar-thumb {
background: rgba(255, 255, 255, 0.1);
border-radius: 4px;
}

.action-log-container::-webkit-scrollbar-thumb:hover {
background: rgba(255, 255, 255, 0.2);
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

nav a {
margin: 0 10px;
font-size: 14px;
}

.stats {
grid-template-columns: 1fr;
}

.action-log-container {
max-height: 300px;
}
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
// Add interactive 3D effects to stat cards
document.addEventListener('DOMContentLoaded', function() {
const statCards = document.querySelectorAll('.stat-card');

statCards.forEach(card => {
card.addEventListener('mousemove', (e) => {
const xAxis = (window.innerWidth / 2 - e.pageX) / 15;
const yAxis = (window.innerHeight / 2 - e.pageY) / 15;
card.style.transform = `translateY(-10px) rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
});

card.addEventListener('mouseleave', () => {
card.style.transform = 'translateY(0) rotateY(0) rotateX(0)';
});
});
});
</script>
</head>
<body>
<div class="dashboard">
<header>
<h1><i class="fas fa-user-tie icon"></i> Business Owner Dashboard</h1>
<nav>
<a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fas fa-tachometer-alt icon"></i>Dashboard</a>
<a href="${pageContext.request.contextPath}/admin/flights"><i class="fas fa-plane icon"></i>Flights</a>
<a href="${pageContext.request.contextPath}/admin/passengers"><i class="fas fa-users icon"></i>Passengers</a>
<a href="${pageContext.request.contextPath}/owner/reports"><i class="fas fa-chart-bar icon"></i>Reports</a>
<a href="${pageContext.request.contextPath}/admin/airports"><i class="fas fa-map-marked-alt icon"></i>Airports</a>
<a href="${pageContext.request.contextPath}/admin/airlines"><i class="fas fa-building icon"></i>Airlines</a>
<a href="${pageContext.request.contextPath}/owner/dashboard/flightmanager/list"><i class="fas fa-user-tie icon"></i>Flight Manager</a>
<a href="${pageContext.request.contextPath}/owner/feedback"><i class="fas fa-comment-dots icon"></i>Feedback</a>
<a href="${pageContext.request.contextPath}/auth/logout"><i class="fas fa-sign-out-alt icon"></i>Logout</a>
</nav>
</header>

<div class="content">
<div class="stats">
<div class="stat-card">
<h3><i class="fas fa-plane icon"></i> Total Flights</h3>
<p>${not empty totalFlights ? totalFlights : 0}</p>
</div>
<div class="stat-card">
<h3><i class="fas fa-user-plus icon"></i> Registered Users</h3>
<p>${not empty totalUsers ? totalUsers : 0}</p>
</div>
</div>

<div class="recent-activity">
<h2><i class="fas fa-history icon"></i> Recent Activity</h2>
<div class="action-log-container">
<table class="action-log-table">
<thead>
<tr>
<th><i class="fas fa-clock icon"></i> Timestamp</th>
<th><i class="fas fa-bolt icon"></i> Action</th>
</tr>
</thead>
<tbody>
<c:choose>
<c:when test="${not empty actionLog}">
<c:forEach var="log" items="${actionLog}">
<tr>
<td><fmt:formatDate value="${log.timestamp}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
<td>${log.actionPerformed}</td>
</tr>
</c:forEach>
</c:when>
<c:otherwise>
<tr>
<td colspan="3" style="text-align: center;">No recent actions to display.</td>
</tr>
</c:otherwise>
</c:choose>
</tbody>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
