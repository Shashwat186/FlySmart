<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Reports</title>
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
    padding: 20px;
    color: var(--color-light);
    background: linear-gradient(rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)),
        url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=3840&q=80');
    background-size: cover;
    background-attachment: fixed;
    background-position: center;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.dashboard-header {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: flex-start;
    width: 90%;
    max-width: 1200px;
    margin-bottom: 20px;
}

h1 {
    color: var(--color-light);
    margin: 0 0 0 15px;
    font-weight: 300;
    letter-spacing: 2px;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    background: var(--glass-bg);
    border: var(--glass-border);
    border-radius: var(--glass-radius);
    box-shadow: var(--glass-shadow),
        0 10px 20px rgba(221, 168, 83, 0.1);
    padding: 20px;
    flex-grow: 1;
    text-align: center;
}

.back-button {
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    background: var(--glass-bg);
    border: var(--glass-border);
    border-radius: 50%;
    box-shadow: var(--glass-shadow);
    color: var(--color-light);
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.back-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        90deg,
        transparent,
        rgba(221, 168, 83, 0.3),
        transparent
    );
    transition: var(--transition);
}

.back-button:hover::before {
    left: 100%;
}

.back-button:hover {
    background: rgba(221, 168, 83, 0.25);
    transform: translateY(-4px) scale(1.1);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
    color: var(--color-accent);
}

.back-button:active {
    transform: translateY(-2px) scale(0.98);
}

.back-button svg {
    width: 24px;
    height: 24px;
    transition: var(--transition);
}

.back-button:hover svg {
    transform: translateX(-3px);
}

.report-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 24px;
    width: 90%;
    max-width: 1200px;
    margin-bottom: 30px;
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

.availability-section {
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    background: var(--glass-bg);
    border: var(--glass-border);
    border-radius: var(--glass-radius);
    box-shadow: var(--glass-shadow);
    padding: 30px;
    width: 90%;
    max-width: 1200px;
}

.availability-section-header {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
}

.availability-section h2 {
    color: var(--color-light);
    margin: 0;
    font-weight: 400;
    letter-spacing: 1px;
}

.search-container {
    position: relative;
    max-width: 250px;
    width: 100%;
}

.search-bar {
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    background: var(--glass-bg);
    border: var(--glass-border);
    border-radius: 8px;
    color: var(--color-light);
    padding: 0.5rem 2.5rem 0.5rem 1rem;
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

.availability-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    overflow: hidden;
    border-radius: 8px;
}

.availability-table thead tr {
    background: rgba(24, 59, 78, 0.5);
}

.availability-table th, .availability-table td {
    padding: 16px;
    text-align: left;
    border-bottom: var(--glass-border);
}

.availability-table th {
    font-weight: 500;
    letter-spacing: 1px;
    font-size: 14px;
    text-transform: uppercase;
    color: var(--color-accent);
}

.availability-table td {
    color: rgba(245, 238, 220, 0.9);
}

.availability-table tbody tr {
    background: rgba(255, 255, 255, 0.03);
    transition: var(--transition);
}

.availability-table tbody tr:hover {
    background: rgba(221, 168, 83, 0.1);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

/* Responsive Adjustments */
@media (max-width: 768px) {
    .availability-section-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }

    .search-container {
        max-width: 200px;
    }

    .availability-table th, .availability-table td {
        padding: 12px;
        font-size: 0.9rem;
    }
}

@media (max-width: 576px) {
    .search-container {
        max-width: 150px;
    }

    .search-bar {
        font-size: 0.85rem;
        padding: 0.4rem 2rem 0.4rem 0.8rem;
    }

    .search-icon {
        font-size: 0.9rem;
    }

    .availability-table th, .availability-table td {
        padding: 10px;
        font-size: 0.8rem;
    }
}
</style>
</head>
<body>
<div class="dashboard-header">
    <a href="/owner/dashboard" class="back-button" title="Back to Dashboard">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M19 12H5M12 19l-7-7 7-7"/>
        </svg>
    </a>
    <h1>Reports Dashboard</h1>
</div>

<div class="report-container">
    <div class="stat-card">
        <h3>Total Airports</h3>
        <p>${airport}</p>
    </div>
    <div class="stat-card">
        <h3>Total Airlines</h3>
        <p>${airline}</p>
    </div>
    <div class="stat-card">
        <h3>Registered Passengers</h3>
        <p>${user}</p>
    </div>
    <div class="stat-card">
        <h3>Total Passengers (All Flights)</h3>
        <p>${passenger}</p>
    </div>
    <div class="stat-card">
        <h3>Total Flights</h3>
        <p>${flights}</p>
    </div>
    <div class="stat-card">
        <h3>Revenue Generated</h3>
        <p>${totalPrice}</p>
    </div>
    <div class="stat-card">
        <h3>Scheduled Flights</h3>
        <p>${scheduledFlights}</p>
    </div>
    <div class="stat-card">
        <h3>Delayed Flights</h3>
        <p>${delayedFlights}</p>
    </div>
</div>

<div class="availability-section">
    <div class="availability-section-header">
        <h2>Flight Seat Availability</h2>
        <div class="search-container">
            <input type="text" id="flightSearch" class="search-bar" placeholder="Search by Flight Number">
            <i class="fas fa-search search-icon"></i>
        </div>
    </div>
    <c:if test="${not empty flightsAvailability}">
        <table class="availability-table">
            <thead>
                <tr>
                    <th>Flight Number</th>
                    <th>Departure</th>
                    <th>Arrival</th>
                    <th>Airline</th>
                    <th>Status</th>
                    <th>Seat Class</th>
                    <th>Available Seats</th>
                    <th>Total Seats</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody id="availabilityTableBody">
                <c:forEach var="availability" items="${flightsAvailability}">
                    <tr>
                        <td>${availability.flightNumber}</td>
                        <td>${availability.departureAirport} </td>
                        <td>${availability.arrivalAirport} </td>
                        <td>${availability.airlineName}</td>
                        <td>${availability.status}</td>
                        <td>${availability.seatClassName}</td>
                        <td>${availability.availableSeats}</td>
                        <td>${availability.totalSeats}</td>
                        <td>${availability.seatPrice}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty flightsAvailability}">
        <p style="color: var(--color-light); text-align: center;">No flight seat availability data found.</p>
    </c:if>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
    // Dynamic search functionality
    document.getElementById('flightSearch').addEventListener('input', function() {
        const searchValue = this.value.trim().toLowerCase();
        const rows = document.querySelectorAll('#availabilityTableBody tr');

        rows.forEach(row => {
            const flightNumber = row.cells[0].textContent.toLowerCase();

            if (searchValue === '') {
                row.style.display = '';
            } else if (flightNumber.startsWith(searchValue)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>
