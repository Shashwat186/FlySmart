<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Assigned Flights</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/manager/flight-list.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/manager/airline-list.css">
</head>
<body>
<div class="manager-flights">
    <header class="dashboard-header">
        <div class="container">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
                <h1 class="mb-3 mb-md-0">
                    <i class="fas fa-user-tie me-2"></i>Flight Manager Dashboard
                </h1>
            </div>
            <nav class="nav justify-content-center mt-3 mt-md-4">
                <a href="${pageContext.request.contextPath}/manager/dashboard" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/manager/airports" class="nav-link">
                    <i class="fas fa-map-marked-alt"></i>Airports
                </a>
                <a href="${pageContext.request.contextPath}/manager/airlines" class="nav-link">
                    <i class="fas fa-building"></i>Airlines
                </a>
                <a href="${pageContext.request.contextPath}/manager/flights" class="nav-link active">
                    <i class="fas fa-plane"></i>Flights
                </a>
                <a href="${pageContext.request.contextPath}/auth/change-password" class="nav-link">
                    <i class="fas fa-key"></i>Change Password
                </a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i>Logout
                </a>
                <span class="user-badge">
                    <i class="fas fa-user me-2"></i>${user.name}
                </span>
            </nav>
        </div>
    </header>

    <main class="dashboard-content">
        <div class="container-fluid">
            <div class="activity-card">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="h4 mb-0">
                        <i class="fas fa-plane me-2"></i>My Assigned Flights
                    </h2>
                    <div class="input-group" style="max-width: 300px;">
                        <input type="text" id="flightSearch" class="form-control" placeholder="Search by Flight #, Airline, or Airport">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${not empty flights}">
                        <div class="flights-table-container">
                            <table class="table flights-table">
                                <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag me-2"></i>Flight #</th>
                                    <th><i class="fas fa-building me-2"></i>Airline</th>
                                    <th><i class="fas fa-plane-departure me-2"></i>Departure</th>
                                    <th><i class="fas fa-plane-arrival me-2"></i>Arrival</th>
                                    <th><i class="fas fa-clock me-2"></i>Departure Time</th>
                                    <th><i class="fas fa-clock me-2"></i>Arrival Time</th>
                                    <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                    <th><i class="fas fa-cogs me-2"></i>Actions</th>
                                </tr>
                                </thead>
                                <tbody id="flightsTableBody">
                                <c:forEach items="${flights}" var="flight">
                                    <tr>
                                        <td>${flight.flightNumber}</td>
                                        <td>${flight.airline.name} (${flight.airline.code})</td>
                                        <td>
                                            ${flight.departureAirport.name}<br>
                                            <small class="text-muted">${flight.departureAirport.code}</small>
                                        </td>
                                        <td>
                                            ${flight.arrivalAirport.name}<br>
                                            <small class="text-muted">${flight.arrivalAirport.code}</small>
                                        </td>
                                        <td><fmt:formatDate value="${flight.departureDateTime}" pattern="MMM dd, yyyy HH:mm"/></td>
                                        <td><fmt:formatDate value="${flight.arrivalDateTime}" pattern="MMM dd, yyyy HH:mm"/></td>
                                        <td>
                                            <span class="status-badge status-${flight.status.toLowerCase()}">
                                                ${flight.status}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="actions-box">
                                                <a href="${pageContext.request.contextPath}/manager/flights/edit/${flight.flightId}"
                                                   class="btn btn-action btn-edit" title="Edit">
                                                    <i class="fas fa-edit me-1"></i>Edit
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info glass-alert">
                            <i class="fas fa-info-circle me-2"></i>You currently have no assigned flights.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('flightSearch');
        const tableBody = document.getElementById('flightsTableBody');

        searchInput.addEventListener('input', function() {
            const searchValue = this.value.trim().toLowerCase();
            const rows = tableBody.querySelectorAll('tr');

            rows.forEach(row => {
                const flightNumber = row.cells[0].textContent.toLowerCase();
                const airlineName = row.cells[1].textContent.toLowerCase();
                const airlineCode = row.cells[1].textContent.match(/\(([^)]+)\)/)?.[1]?.toLowerCase() || '';
                const departureAirportName = row.cells[2].childNodes[0].textContent.toLowerCase().trim();
                const departureAirportCode = row.cells[2].querySelector('small')?.textContent.toLowerCase().trim() || '';
                const arrivalAirportName = row.cells[3].childNodes[0].textContent.toLowerCase().trim();
                const arrivalAirportCode = row.cells[3].querySelector('small')?.textContent.toLowerCase().trim() || '';

                if (
                    searchValue === '' ||
                    flightNumber.includes(searchValue) ||
                    airlineName.includes(searchValue) ||
                    airlineCode.includes(searchValue) ||
                    departureAirportName.includes(searchValue) ||
                    departureAirportCode.includes(searchValue) ||
                    arrivalAirportName.includes(searchValue) ||
                    arrivalAirportCode.includes(searchValue)
                ) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    });
</script>
</body>
</html>
