<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Search - Book Your Journey</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/booking/search.css">

    <script>
        function validateForm() {
            let valid = true;

            // Get input elements and error containers
            const fromSelect = document.getElementById('from');
            const toSelect = document.getElementById('to');
            const dateInput = document.getElementById('date');
            const adultsSelect = document.getElementById('adults');
            const childrenSelect = document.getElementById('children');
            const fromError = document.getElementById('fromError');
            const toError = document.getElementById('toError');
            const dateError = document.getElementById('dateError');
            const adultsError = document.getElementById('adultsError');
            const childrenError = document.getElementById('childrenError');

            // Reset error messages
            fromError.textContent = '';
            toError.textContent = '';
            dateError.textContent = '';
            adultsError.textContent = '';
            childrenError.textContent = '';

            // Validate From
            if (!fromSelect.value) {
                fromError.textContent = 'Please select a departure location!';
                valid = false;
            }

            // Validate To
            if (!toSelect.value) {
                toError.textContent = 'Please select an arrival location!';
                valid = false;
            } else if (fromSelect.value && fromSelect.value === toSelect.value) {
                toError.textContent = 'Departure and arrival locations cannot be the same!';
                valid = false;
            }

            // Validate Date
            if (!dateInput.value) {
                dateError.textContent = 'Departure date is required!';
                valid = false;
            } else {
                const selectedDate = new Date(dateInput.value);
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                if (selectedDate < today) {
                    dateError.textContent = 'Departure date cannot be in the past!';
                    valid = false;
                }
            }

            // Validate Adults
            if (!adultsSelect.value || adultsSelect.value < 1) {
                adultsError.textContent = 'At least one adult is required!';
                valid = false;
            }

            // Validate Children
            if (childrenSelect.value < 0) {
                childrenError.textContent = 'Number of children cannot be negative!';
                valid = false;
            }

            return valid;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <a href="/passenger/dashboard" class="btn btn-outline">
                <i class="bi bi-arrow-left"></i>Dashboard
            </a>
            <div class="search-header text-center">
                <h1><i class="bi bi-airplane me-2"></i>Find Your Perfect Flight</h1>
                <p class="mb-0">Search and compare flights from hundreds of airlines</p>
            </div>
            <div></div> <!-- Empty div for balance -->
        </div>
        <div class="search-container">
            <form action="${pageContext.request.contextPath}/booking/search" method="get" class="search-form" onsubmit="return validateForm()">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label for="from" class="form-label">From</label>
                        <select class="form-select" id="from" name="from">
                            <option value="">Select departure location</option>
                            <c:forEach items="${airports}" var="airport">
                                <option value="${airport.airportId}" ${searchParams['from'] == airport.airportId ? 'selected' : ''}>
                                    ${airport.location} (${airport.code})
                                </option>
                            </c:forEach>
                        </select>
                        <div id="fromError" class="error-message text-danger"></div>
                        <button type="button" class="btn btn-sm btn-outline-secondary mt-2 swap-btn">
                            <i class="bi bi-arrow-left-right"></i> Swap
                        </button>
                    </div>
                    <div class="col-md-3">
                        <label for="to" class="form-label">To</label>
                        <select class="form-select" id="to" name="to">
                            <option value="">Select arrival location</option>
                            <c:forEach items="${airports}" var="airport">
                                <option value="${airport.airportId}" ${searchParams['to'] == airport.airportId ? 'selected' : ''}>
                                    ${airport.location} (${airport.code})
                                </option>
                            </c:forEach>
                        </select>
                        <div id="toError" class="error-message text-danger"></div>
                    </div>
                    <div class="col-md-3">
                        <label for="date" class="form-label">Departure Date</label>
                        <input type="date" class="form-control" id="date" name="date"
                               value="${not empty searchParams['date'] ? searchParams['date'] : currentDate}" min="${currentDate}">
                        <div id="dateError" class="error-message text-danger"></div>
                    </div>
                    <div class="col-md-3">
                        <label for="seatClass" class="form-label">Seat Class</label>
                        <select class="form-select" id="seatClass" name="seatClass">
                            <option value="">Any Class</option>
                            <c:forEach items="${seatClasses}" var="seatClass">
                                <option value="${seatClass.seatClassId}" ${searchParams['seatClass'] == seatClass.seatClassId ? 'selected' : ''}>
                                    ${seatClass.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="adults" class="form-label">Adults</label>
                        <select class="form-select" id="adults" name="adults">
                            <option value="1" selected>1</option>
                            <c:forEach begin="2" end="9" var="i">
                                <option value="${i}">${i}</option>
                            </c:forEach>
                        </select>
                        <div id="adultsError" class="error-message text-danger"></div>
                    </div>
                    <div class="col-md-3">
                        <label for="children" class="form-label">Children (Under 12)</label>
                        <select class="form-select" id="children" name="children">
                            <option value="0" selected>0</option>
                            <c:forEach begin="1" end="8" var="i">
                                <option value="${i}">${i}</option>
                            </c:forEach>
                        </select>
                        <div id="childrenError" class="error-message text-danger"></div>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-search"></i> Search Flights
                        </button>
                    </div>
                </div>
            </form>
            <div class="p-4">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:choose>
                    <c:when test="${not empty flights}">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="mb-0">
                                <i class="bi bi-list-ul"></i> ${flights.size()} Flights Found
                            </h4>
                           
                        </div>
                        <c:forEach items="${flights}" var="flight">
                            <div class="flight-card">
                                <div class="flight-header d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-airplane-fill airline-icon"></i>
                                        <div>
                                            <h5 class="mb-0">${flight.airline.name}</h5>
                                            <small class="text-muted">${flight.flightNumber}</small>
                                        </div>
                                    </div>
                                    <div>
                                        <span class="duration-badge">
                                            <i class="bi bi-clock"></i>
                                            <fmt:formatNumber value="${flight.duration / 60}" maxFractionDigits="0"/>h
                                            <fmt:formatNumber value="${flight.duration % 60}" minIntegerDigits="2"/>m
                                        </span>
                                    </div>
                                </div>
                                <div class="flight-body">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <div class="time-display">
                                                        <fmt:formatDate value="${flight.departureDate}" pattern="HH:mm"/>
                                                    </div>
                                                    <div class="location-display">
                                                        ${flight.departureAirport.location} (${flight.departureAirport.code})
                                                    </div>
                                                    <div class="text-muted small">
                                                        <fmt:formatDate value="${flight.departureDate}" pattern="EEE, d MMM"/>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="flight-divider">
                                                        <div class="flight-divider-line"></div>
                                                        <div class="flight-divider-icon">
                                                            <i class="bi bi-airplane"></i>
                                                        </div>
                                                        <div class="flight-divider-line"></div>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="time-display">
                                                        <fmt:formatDate value="${flight.arrivalDate}" pattern="HH:mm"/>
                                                    </div>
                                                    <div class="location-display">
                                                        ${flight.arrivalAirport.location} (${flight.arrivalAirport.code})
                                                    </div>
                                                    <div class="text-muted small">
                                                        <fmt:formatDate value="${flight.arrivalDate}" pattern="EEE, d MMM"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 d-flex flex-column align-items-end justify-content-between">
                                            <div class="flight-price mb-3">
                                                ${flight.price}
                                            </div>
                                            <a href="${pageContext.request.contextPath}/booking/new?flightId=${flight.flightId}&seatClassId=${searchParams['seatClass']}&adults=${searchParams['adults']}&children=${searchParams['children']}"
                                               class="btn btn-primary">
                                                <i class="bi bi-ticket-perforated"></i> Book Now
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:when test="${not empty searchParams['from'] && not empty searchParams['to'] && empty flights}">
                        <div class="no-flights text-center">
                            <i class="bi bi-emoji-frown"></i>
                            <h3 class="mt-3">No flights found</h3>
                            <p class="text-muted">We couldn't find any flights matching your criteria.</p>
                            <a href="${pageContext.request.contextPath}/booking/search" class="btn btn-primary">
                                <i class="bi bi-arrow-left"></i> Modify Search
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-flights text-center">
                            <i class="bi bi-search"></i>
                            <h3 class="mt-3">Search for flights</h3>
                            <p class="text-muted">Enter your travel details to find available flights.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function () {
            const today = new Date().toISOString().split('T')[0];
            const dateInput = document.getElementById('date');
            if (!dateInput.value) {
                dateInput.value = today;
            }

            // Swap from and to locations
            const swapButton = document.querySelector('.swap-btn');
            swapButton.onclick = function () {
                const fromSelect = document.getElementById('from');
                const toSelect = document.getElementById('to');
                const tempValue = fromSelect.value;
                fromSelect.value = toSelect.value;
                toSelect.value = tempValue;
            };
        });
    </script>
</body>
</html>