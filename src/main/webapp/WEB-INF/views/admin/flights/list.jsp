<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Flights</title>
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
        url('https://images.unsplash.com/photo-1556388158-158ea5ccacbd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
    background-size: cover;
    background-attachment: fixed;
    background-position: center;
    min-height: 100vh;
}

/* Glassmorphism Header */
header {
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    background: var(--glass-bg);
    border-bottom: var(--glass-border);
    box-shadow: var(--glass-shadow);
    color: var(--color-light);
    text-align: center;
    padding: 24px;
    position: sticky;
    top: 0;
    z-index: 100;
}

header h1 {
    margin: 0 0 16px 0;
    font-weight: 300;
    letter-spacing: 2px;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}

/* Navigation with hover effects */
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
    white-space: nowrap;
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
    box-shadow: var(--glass-shadow);
}

/* Search Bar and Add Flight Container */
.controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
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
}

.search-bar::placeholder {
    color: rgba(245, 238, 220, 0.8);
}

.search-bar:focus {
    outline: none;
    border-color: var(--color-accent);
    background: rgba(39, 84, 138, 0.25);
}

.search-icon {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--color-accent);
    font-size: 1rem;
}

/* Add Flight Button / General Button Styling */
.add-flight {
    text-align: right;
}

.btn {
    padding: 0.6rem 1.2rem;
    border: 1px solid rgba(221, 168, 83, 0.2);
    border-radius: 6px;
    cursor: pointer;
    transition: var(--transition);
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    text-decoration: none;
    display: inline-block;
    background: rgba(221, 168, 83, 0.1);
    color: var(--color-light);
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.btn:hover {
    background: rgba(221, 168, 83, 0.2);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
    color: var(--color-light);
}

.btn-primary {
    background: var(--color-accent);
    color: var(--color-dark);
    border: none;
}

.btn-primary:hover {
    background: #C59447;
    box-shadow: 0 4px 15px rgba(221, 168, 83, 0.3);
}

/* Table Styling */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin-top: 1.5rem;
    background: rgba(245, 238, 220, 0.1);
    border-radius: 12px;
    overflow: hidden;
}

th, td {
    padding: 1.2rem;
    text-align: center;
    border-bottom: 1px solid rgba(245, 238, 220, 0.1);
    color: var(--color-light);
}

th {
    background: rgba(39, 84, 138, 0.3);
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: var(--color-accent);
}

tr:hover {
    background: rgba(221, 168, 83, 0.05);
}

/* Status Badges */
.status {
    padding: 0.4rem 0.8rem;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 500;
    display: inline-block;
}

.status-scheduled { background: rgba(72, 187, 120, 0.2); color: #48BB78; }
.status-delayed { background: rgba(237, 137, 54, 0.2); color: #ED8936; }
.status-cancelled { background: rgba(229, 62, 62, 0.2); color: #E53E3E; }
.status-completed { background: rgba(66, 153, 225, 0.2); color: #4299E1; }

/* Actions Box */
.actions-box {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
}

/* Styling for action buttons inside the box */
.btn-action {
    padding: 0.5rem 1rem;
    font-size: 0.9rem;
}

.btn-edit {
    background: var(--color-accent);
    color: var(--color-dark);
    border: none;
}

.btn-edit:hover {
    background: #C59447;
}

.btn-delete {
    background: rgba(220, 53, 69, 0.6);
    color: var(--color-light);
    border: 1px solid rgba(220, 53, 69, 0.3);
}

.btn-delete:hover {
    background: rgba(220, 53, 69, 0.8);
}

/* Icon Styling */
.icon {
    display: inline-block;
    margin-right: 8px;
}

/* Danger Button */
.btn.danger {
    background: rgba(220, 53, 69, 0.2);
    border-color: rgba(220, 53, 69, 0.3);
}

.btn.danger:hover {
    background: rgba(220, 53, 69, 0.4);
}

/* Custom Confirmation Dialog */
.confirmation-dialog {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.9);
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
    transform: translate(-50%, -50%) scale(1);
}

.confirmation-dialog button {
    margin: 10px 5px 0 5px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .content {
        margin: 20px;
        padding: 20px;
    }

    nav {
        white-space: normal;
    }

    nav a {
        margin: 0 8px 8px 8px;
        font-size: 14px;
        display: inline-block;
        white-space: nowrap;
    }

    table {
        font-size: 0.9rem;
    }

    th, td {
        padding: 0.8rem;
    }

    .actions-box {
        flex-direction: column;
        gap: 0.3rem;
    }

    .btn-action {
        padding: 0.4rem 0.8rem;
        font-size: 0.8rem;
    }

    .controls {
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

    if (!dialog || !message || !confirmYes || !confirmNo) {
        console.error('Confirmation dialog elements not found!');
        if (window.confirm(`Are you sure you want to delete this ${entityType}? (Dialog Error)`)) {
            submitDeleteForm(url);
        }
        return;
    }

    message.textContent = `Are you sure you want to delete this ${entityType}?`;
    dialog.classList.add('active');

    const newConfirmYes = confirmYes.cloneNode(true);
    confirmYes.parentNode.replaceChild(newConfirmYes, confirmYes);

    const newConfirmNo = confirmNo.cloneNode(true);
    confirmNo.parentNode.replaceChild(newConfirmNo, confirmNo);

    newConfirmYes.onclick = function() {
        submitDeleteForm(url);
        dialog.classList.remove('active');
    };

    newConfirmNo.onclick = function() {
        dialog.classList.remove('active');
    };
}

function submitDeleteForm(url) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = url;
    document.body.appendChild(form);
    form.submit();
}
</script>
</head>
<body>
<header>
    <h1><i class="fas fa-plane icon"></i> Manage Flights</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt icon"></i>Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/flights" class="active"><i class="fas fa-plane icon"></i>Flights</a>
        <a href="${pageContext.request.contextPath}/admin/passengers"><i class="fas fa-users icon"></i>Passengers</a>
        <a href="${pageContext.request.contextPath}/owner/reports"><i class="fas fa-chart-bar icon"></i>Reports</a>
        <a href="${pageContext.request.contextPath}/admin/airports"><i class="fas fa-map-marked-alt icon"></i>Airports</a>
        <a href="${pageContext.request.contextPath}/admin/airlines"><i class="fas fa-building icon"></i>Airlines</a>
        <a href="${pageContext.request.contextPath}/owner/dashboard/flightmanager/list"><i class="fas fa-user-tie icon"></i>Flight Manager</a>
        <a href="${pageContext.request.contextPath}/owner/feedback"><i class="fas fa-comment-dots icon"></i>Feedback</a>
    </nav>
</header>

<div class="content">
    <div class="controls">
        <div class="search-container">
            <input type="text" id="flightSearch" class="search-bar" placeholder="Search by Flight No or Airline">
            <i class="fas fa-search search-icon"></i>
        </div>
        <div class="add-flight">
            <a href="${pageContext.request.contextPath}/admin/flights/add" class="btn btn-primary">
                <i class="fas fa-plus icon"></i> Add Flight
            </a>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th><i class="fas fa-hashtag icon"></i> Flight No</th>
                <th><i class="fas fa-building icon"></i> Airline</th>
                <th><i class="fas fa-plane-departure icon"></i> Departure</th>
                <th><i class="fas fa-plane-arrival icon"></i> Arrival</th>
                <th><i class="fas fa-calendar-alt icon"></i> Departure Date</th>
                <th><i class="fas fa-calendar-alt icon"></i> Arrival Date</th>
                <th><i class="fas fa-info-circle icon"></i> Status</th>
                <th><i class="fas fa-cogs icon"></i> Actions</th>
            </tr>
        </thead>
        <tbody id="flightsTableBody">
            <c:forEach items="${flights}" var="flight">
                <tr>
                    <td>${flight.flightNumber}</td>
                    <td>${flight.airline.name}</td>
                    <td>${flight.departureAirport.code}</td>
                    <td>${flight.arrivalAirport.code}</td>
                    <td>
                        <fmt:formatDate value="${flight.departureDateTime}" pattern="d MMM yy HH:mm" />
                    </td>
                    <td>
                        <fmt:formatDate value="${flight.arrivalDateTime}" pattern="d MMM yy HH:mm" />
                    </td>
                    <td>
                        <c:set var="statusClass" value="${flight.status.toLowerCase()}" />
                        <div class="status status-${statusClass}">
                            ${flight.status}
                        </div>
                    </td>
                    <td>
                        <div class="actions-box">
                            <a href="${pageContext.request.contextPath}/admin/flights/edit/${flight.flightId}"
                               class="btn btn-action btn-edit" title="Edit">
                                <i class="fas fa-edit icon"></i> Edit
                            </a>
                            <a href="#" onclick="event.preventDefault(); confirmDelete('${pageContext.request.contextPath}/admin/flights/delete/${flight.flightId}', 'flight')"
                               class="btn btn-action btn-delete" title="Delete">
                                <i class="fas fa-trash icon"></i> Delete
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div id="confirmationDialog" class="confirmation-dialog">
    <p id="confirmationMessage" style="margin-bottom: 1.5em;"></p>
    <button id="confirmYes" class="btn"><i class="fas fa-check icon"></i> Yes</button>
    <button id="confirmNo" class="btn danger"><i class="fas fa-times icon"></i> No</button>
</div>

<script>
    // Dynamic search functionality
    document.getElementById('flightSearch').addEventListener('input', function() {
        const searchValue = this.value.trim().toLowerCase();
        const rows = document.querySelectorAll('#flightsTableBody tr');

        rows.forEach(row => {
            const flightNumber = row.cells[0].textContent.toLowerCase();
            const airline = row.cells[1].textContent.toLowerCase();

            if (searchValue === '') {
                row.style.display = '';
            } else if (flightNumber.startsWith(searchValue) || airline.startsWith(searchValue)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>