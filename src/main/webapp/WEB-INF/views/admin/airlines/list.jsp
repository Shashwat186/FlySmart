<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<title>Airlines List</title>
<style>
/* Base Styling with new color scheme */
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
background: linear-gradient(135deg, var(--color-dark), var(--color-primary)),
url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');
background-size: cover;
background-attachment: fixed;
background-position: center;
min-height: 100vh;
animation: gradientShift 15s ease infinite;
}

@keyframes gradientShift {
0% { background-position: 0% 50%; }
50% { background-position: 100% 50%; }
100% { background-position: 0% 50%; }
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
transition: all 0.5s ease;
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
flex-wrap: wrap;
}

nav a {
color: rgba(245, 238, 220, 0.8);
text-decoration: none;
margin: 0 18px;
font-size: 16px;
font-weight: 500;
padding: 6px 2px;
border-bottom: 2px solid transparent;
transition: all 0.3s ease;
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

/* 3D Content Area */
.content {
max-width: 1100px;
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
transform: perspective(1000px) translateY(0);
transition: all 0.5s ease;
animation: float 6s ease-in-out infinite;
}

.content:hover {
box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4),
0 10px 20px rgba(221, 168, 83, 0.2);
transform: perspective(1000px) translateY(-5px);
}

/* Action Bar Styling */
.actions {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 30px;
transform: translateZ(20px);
}

.search-container {
position: relative;
max-width: 300px;
width: 100%;
}

.search-bar {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: 8px;
color: var(--color-light);
padding: 0.6rem 2.5rem 0.6rem 1rem;
font-size: 0.9rem;
width: 100%;
transform-style: preserve-3d;
transform: perspective(500px) translateZ(0);
transition: all 0.3s ease;
}

.search-bar:focus {
outline: none;
border-color: var(--color-accent);
background: rgba(39, 84, 138, 0.25);
transform: perspective(500px) translateZ(10px);
}

.search-bar::placeholder {
color: rgba(245, 238, 220, 0.8);
}

.search-icon {
position: absolute;
right: 12px;
top: 50%;
transform: translateY(-50%);
color: var(--color-accent);
font-size: 1rem;
}

/* 3D Button Effects */
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

/* 3D Table Styling */
table {
width: 100%;
border-collapse: separate;
border-spacing: 0;
margin-top: 20px;
overflow: hidden;
border-radius: 12px;
transform-style: preserve-3d;
transform: perspective(1000px) translateZ(0);
transition: all 0.5s ease;
}

table:hover {
transform: perspective(1000px) translateZ(10px);
}

table thead tr {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: rgba(24, 59, 78, 0.3);
transform: translateZ(20px);
}

table th, table td {
padding: 16px;
text-align: center;
border-bottom: var(--glass-border);
transform-style: preserve-3d;
}

table th {
font-weight: 500;
letter-spacing: 1px;
font-size: 14px;
text-transform: uppercase;
color: var(--color-accent);
transform: translateZ(30px);
}

table tbody tr {
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: rgba(255, 255, 255, 0.03);
transition: all 0.3s ease;
transform-style: preserve-3d;
transform: translateZ(10px);
}

table tbody tr:hover {
background: rgba(221, 168, 83, 0.1);
transform: translateZ(20px);
box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

/* Button Variations */
.btn.danger {
background: rgba(220, 53, 69, 0.2);
}

.btn.danger:hover {
background: rgba(220, 53, 69, 0.3);
}

.btn-primary {
margin-right: 8px;
}

.actions-container {
display: flex;
justify-content: center;
gap: 8px;
transform-style: preserve-3d;
}

/* Icons and Symbols */
.icon {
display: inline-block;
margin-right: 8px;
color: var(--color-accent);
transform: translateZ(10px);
}

/* Confirmation Dialog */
.confirmation-dialog {
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%) perspective(1000px) rotateX(0deg);
backdrop-filter: var(--glass-blur);
-webkit-backdrop-filter: var(--glass-blur);
background: var(--glass-bg);
border: var(--glass-border);
border-radius: var(--glass-radius);
box-shadow: var(--glass-shadow);
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
table {
display: block;
overflow-x: auto;
}
.actions {
flex-direction: column;
align-items: flex-start;
gap: 1rem;
}
.search-container {
max-width: 200px;
}
}

@media (max-width: 576px) {
.search-container {
max-width: 150px;
}
.search-bar {
font-size: 0.85rem;
padding: 0.5rem 2rem 0.5rem 0.8rem;
}
.search-icon {
font-size: 0.9rem;
right: 8px;
}
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
function confirmDelete(url, entityType) {
const dialog = document.getElementById('confirmationDialog');
const message = document.getElementById('confirmationMessage');
const confirmYes = document.getElementById('confirmYes');
const confirmNo = document.getElementById('confirmNo');
message.textContent = `Are you sure you want to delete this ${entityType}?`;
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

// Dynamic search functionality
document.addEventListener('DOMContentLoaded', function() {
const searchInput = document.getElementById('airlineSearch');
const tableBody = document.getElementById('airlinesTableBody');

searchInput.addEventListener('input', function() {
const searchValue = this.value.trim().toLowerCase();
const rows = tableBody.querySelectorAll('tr');

rows.forEach(row => {
const name = row.cells[0].textContent.toLowerCase();
const code = row.cells[1].textContent.toLowerCase();

if (searchValue === '') {
row.style.display = '';
} else if (name.startsWith(searchValue) || code.startsWith(searchValue)) {
row.style.display = '';
} else {
row.style.display = 'none';
}
});
});
});
</script>
</head>
<body>
<div class="dashboard">
<header>
<h1><i class="fas fa-building icon"></i> Airlines</h1>
<nav>
<a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt icon"></i>Dashboard</a>
<a href="${pageContext.request.contextPath}/admin/flights"><i class="fas fa-plane icon"></i>Flights</a>
<a href="${pageContext.request.contextPath}/admin/passengers"><i class="fas fa-users icon"></i>Passengers</a>
<a href="${pageContext.request.contextPath}/owner/reports"><i class="fas fa-chart-bar icon"></i>Reports</a>
<a href="${pageContext.request.contextPath}/admin/airports"><i class="fas fa-map-marked-alt icon"></i>Airports</a>
<a href="${pageContext.request.contextPath}/admin/airlines" class="active"><i class="fas fa-building icon"></i>Airlines</a>
<a href="${pageContext.request.contextPath}/owner/dashboard/flightmanager/list"><i class="fas fa-user-tie icon"></i>Flight Manager</a>
<a href="${pageContext.request.contextPath}/owner/feedback"><i class="fas fa-comment-dots icon"></i>Feedback</a>
</nav>
</header>
<div class="content">
<div class="actions">
<div class="search-container">
<input type="text" id="airlineSearch" class="search-bar" placeholder="Search by Name or Code">
<i class="fas fa-search search-icon"></i>
</div>
<a href="${pageContext.request.contextPath}/admin/airlines/add" class="btn"><i class="fas fa-plus icon"></i> Add Airline</a>
</div>
<table>
<thead>
<tr>
<th><i class="fas fa-building icon"></i> Name</th>
<th><i class="fas fa-code icon"></i> Code</th>
<th><i class="fas fa-phone icon"></i> Contact Info</th>
<th><i class="fas fa-cogs icon"></i> Actions</th>
</tr>
</thead>
<tbody id="airlinesTableBody">
<c:forEach items="${airlines}" var="airline">
<tr>
<td>${airline.name}</td>
<td>${airline.code}</td>
<td>${airline.contactInfo}</td>
<td>
<div class="actions-container">
<a href="${pageContext.request.contextPath}/admin/airlines/edit/${airline.airlineId}" class="btn"><i class="fas fa-edit icon"></i> Edit</a>
<a href="#" onclick="confirmDelete('${pageContext.request.contextPath}/admin/airlines/delete/${airline.airlineId}', 'airline')" class="btn danger"><i class="fas fa-trash-alt icon"></i> Delete</a>
</div>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>

<!-- 3D Confirmation Dialog -->
<div id="confirmationDialog" class="confirmation-dialog">
<p id="confirmationMessage"></p>
<button id="confirmYes" class="btn"><i class="fas fa-check icon"></i> Yes</button>
<button id="confirmNo" class="btn danger"><i class="fas fa-times icon"></i> No</button>
</div>
</body>
</html>