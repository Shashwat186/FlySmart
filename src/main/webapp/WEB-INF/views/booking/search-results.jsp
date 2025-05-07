<%@ page contentType="text/html;charset=UTF-8" %>
 <%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Available Flights</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header class="search-header">
            <h1>Available Flights</h1>
            <a href="${pageContext.request.contextPath}/passenger/dashboard" class="btn btn-back">Back to Dashboard</a>
        </header>
 
        <div class="search-results">
            <div class="search-filters">
                <form action="${pageContext.request.contextPath}/booking/search" method="get" class="filter-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label>From:</label>
                            <input type="text" name="from" value="${param.from}" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>To:</label>
<input type="text" name="to" value="${param.to}" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Date:</label>
<input type="date? name="date? value="${param.date}" class="form-control">
                        </div>
                        <button type="submit" class="btn btn-primary">Search</button>
                    </div>
                </form>
            </div>
 
            <c:if test="${not empty flights}">
                <table class="flight-table">
                    <thead>
                        <tr>
                            <th>Flight</th>
                            <th>Departure</th>
                            <th>Arrival</th>
                            <th>Duration</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${flights}" var="flight">
                            <tr>
                                <td>
                                    <strong>${flight.flightNumber}</strong><br>
${flight.airline.name}</small>
                                </td>
                                <td>
                                    <strong>${flight.departureDateTime}</strong><br>
${flight.departureAirport.code} (${flight.departureAirport.name})
                                </td>
                                <td>
                                    <strong>${flight.arrivalDateTime}</strong><br>
${flight.arrivalAirport.code} (${flight.arrivalAirport.name})
                                </td>
                                <td>${flight.duration}</td>
                                <td>$${flight.price}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/booking/new?flightId=${flight.flightId}"
                                       class="btn btn-book">Book Now</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty flights}">
                <div class="no-results">
                    <p>No flights found matching your criteria.</p>
                    <a href="${pageContext.request.contextPath}/booking/search" class="btn btn-primary">Try Again</a>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>