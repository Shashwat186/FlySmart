<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Manager Dashboard</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Montserrat for headings, Open Sans for body -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/manager/manager-dashboard.css">
</head>
<body>
    <div class="manager-dashboard">
        <header class="dashboard-header">
            <div class="container">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
                    <h1 class="mb-3 mb-md-0">
                        <i class="fas fa-user-tie me-2"></i>Flight Manager Dashboard
                    </h1>
                </div>
                
                <nav class="nav justify-content-center mt-3 mt-md-4">
                    <a href="${pageContext.request.contextPath}/manager/dashboard" class="nav-link active">
                        <i class="fas fa-tachometer-alt"></i>Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/manager/airports" class="nav-link">
                        <i class="fas fa-map-marked-alt"></i>Airports
                    </a>
                    <a href="${pageContext.request.contextPath}/manager/airlines" class="nav-link">
                        <i class="fas fa-building"></i>Airlines
                    </a>
                    <a href="${pageContext.request.contextPath}/manager/flights" class="nav-link">
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
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="stat-card">
                            <h3><i class="fas fa-plane me-2"></i>Assigned Flights</h3>
                            <p>${totalFlights}</p>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="stat-card">
                            <h3><i class="fas fa-clock me-2"></i>Scheduled</h3>
                            <p>${scheduledCount}</p>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="stat-card">
                            <h3><i class="fas fa-exclamation-triangle me-2"></i>Delayed</h3>
                            <p>${delayedCount}</p>
                        </div>
                    </div>
                </div>

                <div class="activity-card mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="h4 mb-0">
                            <i class="fas fa-list me-2"></i>Recent Activity
                        </h2>
                    </div>
                    
                    <div class="activity-table-container">
                        <table class="table activity-table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-clock me-2"></i>Timestamp</th>
                                    <th><i class="fas fa-tasks me-2"></i>Action</th>
                                    
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
                                            <td colspan="3" class="text-center py-4">No recent actions to display</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // JavaScript validation for form inputs
        function validateUrgentTasksForm() {
            const flightNumber = document.getElementById('flightNumber').value;
            const issueDescription = document.getElementById('issueDescription').value;

            if (!flightNumber) {
                alert('Flight Number is required!');
                return false;
            }

            if (!issueDescription || issueDescription.trim() === '') {
                alert('Issue Description cannot be empty!');
                return false;
            }

            return true; // Allow submission if all validations pass
        }
    </script>
</body>
</html>
