<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Passenger Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
 
.content h1 {
  text-align: center;
  margin-bottom: 30px;
  font-weight: 300;
  letter-spacing: 1px;
  color: var(--color-light);
  text-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}
 
/* Table Styling */
table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  margin-top: 20px;
  overflow: hidden;
  border-radius: 8px;
  transform-style: preserve-3d;
  transform: perspective(1000px) translateZ(0);
  transition: var(--transition);
}
 
table:hover {
  transform: perspective(1000px) translateZ(10px);
}
 
table thead tr {
  background: rgba(24, 59, 78, 0.5);
  transform: translateZ(20px);
}
 
table th,
table td {
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
 
table td {
  color: rgba(245, 238, 220, 0.9);
  transform: translateZ(10px);
}
 
table tbody tr {
  background: rgba(255, 255, 255, 0.03);
  transition: var(--transition);
  transform-style: preserve-3d;
}
 
table tbody tr:hover {
  background: rgba(221, 168, 83, 0.1);
  transform: translateZ(20px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}
 
/* Status Styling */
.status-registered {
  color: #4CAF50;
  font-weight: 500;
}
 
.status-unregistered {
  color: #F44336;
  font-weight: 500;
}
 
/* Loyalty Points */
.loyalty-high {
  color: var(--color-accent);
  font-weight: 600;
}
 
.loyalty-low {
  color: #FF9800;
  font-weight: 500;
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
 
  table th,
  table td {
    padding: 10px 5px;
    font-size: 12px;
  }
 
  nav a {
    margin: 0 10px;
    font-size: 14px;
  }
}
</style>
 
</head>
<body>
    <header>
        <h1><i class="fas fa-users icon"></i> Passenger Management</h1>
        <nav>
            <a href="${pageContext.request.contextPath}/admin/dashboard" ><i class="fas fa-tachometer-alt icon"></i>Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/flights"><i class="fas fa-plane icon" class="active"></i>Flights</a>
            <a href="${pageContext.request.contextPath}/admin/passengers"class="active"><i class="fas fa-users icon"></i>Passengers</a>
            <a href="${pageContext.request.contextPath}/owner/reports"><i class="fas fa-chart-bar icon"></i>Reports</a>
            <a href="${pageContext.request.contextPath}/admin/airports"><i class="fas fa-map-marked-alt icon"></i>Airports</a>
            <a href="${pageContext.request.contextPath}/admin/airlines"><i class="fas fa-building icon"></i>Airlines</a>
            <a href="${pageContext.request.contextPath}/owner/dashboard/flightmanager/list"><i class="fas fa-user-tie icon"></i>Flight Manager</a>
            <a href="${pageContext.request.contextPath}/owner/feedback"><i class="fas fa-comment-dots icon"></i>Feedback</a>
            <a href="${pageContext.request.contextPath}/auth/logout"><i class="fas fa-sign-out-alt icon"></i>Logout</a>
        </nav>
    </header>

    <div class="content">
        <h1><i class="fas fa-user-cog icon"></i> Manage Passengers</h1>
        <table>
            <thead>
                <tr>
                    <th><i class="fas fa-user icon"></i> Name</th>
                    <th><i class="fas fa-envelope icon"></i> Email</th>
                    <th><i class="fas fa-phone icon"></i> Phone</th>
                    <th><i class="fas fa-user-check icon"></i> Status</th>
                    
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${passengers}" var="passenger">
                    <tr>
                        <td>${passenger.name}</td>
                        <td>${passenger.email}</td>
                        <td>${passenger.phone}</td>
                        <td class="status-${passenger.registered ? 'registered' : 'unregistered'}">
                            <i class="fas ${passenger.registered ? 'fa-check-circle' : 'fa-times-circle'} icon"></i>
                            ${passenger.registered ? 'Registered' : 'Unregistered'}
                        </td>
                       
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        // Add interactive 3D effects to table rows
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('table tbody tr');
            
            tableRows.forEach(row => {
                row.addEventListener('mousemove', (e) => {
                    const xAxis = (window.innerWidth / 2 - e.pageX) / 25;
                    const yAxis = (window.innerHeight / 2 - e.pageY) / 25;
                    row.style.transform = `translateZ(20px) rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
                });
                
                row.addEventListener('mouseleave', () => {
                    row.style.transform = 'translateZ(0) rotateY(0) rotateX(0)';
                });
            });
        });
    </script>
</body>
</html>