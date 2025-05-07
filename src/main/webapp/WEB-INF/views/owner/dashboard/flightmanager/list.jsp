<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Managers Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Color Scheme and Variables */
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

        /* Base Styling */
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
            display: flex;
            flex-direction: column;
        }

        /* Header */
        header {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border-bottom: var(--glass-border);
            box-shadow: var(--glass-shadow), 0 4px 30px rgba(221, 168, 83, 0.1);
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
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4), 0 4px 30px rgba(221, 168, 83, 0.2);
        }

        header h1 {
            margin: 0 0 16px 0;
            font-weight: 300;
            letter-spacing: 2px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        header h1 i {
            font-size: 1.8rem;
        }

        /* Navigation */
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
            transition: var(--transition);
            letter-spacing: 0.5px;
            position: relative;
            display: flex;
            align-items: center;
            gap: 8px;
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

        /* Main Content */
        main {
            padding: 30px;
            flex-grow: 1;
        }

        /* Container */
        .container {
            width: 95%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            border-radius: var(--glass-radius);
            box-shadow: var(--glass-shadow), 0 10px 20px rgba(221, 168, 83, 0.1);
            transform-style: preserve-3d;
            transform: perspective(1000px);
            transition: var(--transition);
        }

        .container:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4), 0 10px 20px rgba(221, 168, 83, 0.2);
            transform: perspective(1000px) translateY(-5px);
        }

        /* Header Section */
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            border-bottom: var(--glass-border);
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .header-section h2 {
            color: var(--color-light);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.8rem;
            margin: 0;
        }

        /* Card Styling */
        .card {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            border-radius: var(--glass-radius);
            box-shadow: var(--glass-shadow);
            color: var(--color-light);
            transform-style: preserve-3d;
            transition: var(--transition);
        }

        .card:hover {
            transform: perspective(1000px) translateY(-5px) rotateX(1deg) rotateY(1deg);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
        }

        .card-header {
            border-bottom: var(--glass-border);
            background: rgba(39, 84, 138, 0.2);
            color: var(--color-light);
            font-weight: 500;
            padding: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.2rem;
        }

        .card-body {
            padding: 20px;
        }

        /* Table Styling */
        .table {
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

        .table:hover {
            transform: perspective(1000px) translateZ(10px);
        }

        .table thead tr {
            background: rgba(24, 59, 78, 0.5);
            transform: translateZ(20px);
        }

        .table th, .table td {
            padding: 16px;
            text-align: left;
            border-bottom: var(--glass-border);
            transform-style: preserve-3d;
        }

        .table th {
            font-weight: 500;
            letter-spacing: 1px;
            font-size: 14px;
            text-transform: uppercase;
            color: var(--color-accent);
            transform: translateZ(30px);
        }

        .table td {
            color: rgba(245, 238, 220, 0.9);
            transform: translateZ(10px);
        }

        .table tbody tr {
            background: rgba(255, 255, 255, 0.03);
            transition: var(--transition);
            transform-style: preserve-3d;
            cursor: pointer;
        }

        .table tbody tr:hover {
            background: rgba(221, 168, 83, 0.1);
            transform: translateZ(20px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Button Styling */
        .btn {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(221, 168, 83, 0.2);
            color: var(--color-light);
            border: var(--glass-border);
            padding: 8px 16px;
            font-size: 13px;
            font-weight: 500;
            border-radius: 30px;
            cursor: pointer;
            transition: var(--transition);
            letter-spacing: 0.5px;
            text-align: center;
            text-decoration: none;
            transform-style: preserve-3d;
            transform: perspective(500px) translateZ(0);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            display: inline-flex;
            align-items: center;
            gap: 6px;
            position: relative;
            overflow: hidden;
        }

        .btn:hover {
            background: rgba(221, 168, 83, 0.3);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            transform: perspective(500px) translateZ(10px);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(221, 168, 83, 0.2), transparent);
            transition: var(--transition);
        }

        .btn:hover::before {
            left: 100%;
        }

        /* No Data Message */
        .no-data-message {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(220, 53, 69, 0.2);
            border: var(--glass-border);
            border-radius: var(--glass-radius);
            padding: 15px;
            color: var(--color-light);
            font-size: 16px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transform-style: preserve-3d;
            transform: translateZ(10px);
        }

        /* Scrollbar Styling */
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 20px;
            }

            nav {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }

            .header-section {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            .table th, .table td {
                padding: 12px 8px;
                font-size: 14px;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <header>
            <h1><i class="fas fa-plane icon"></i> Flight Management</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt icon"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/flights"><i class="fas fa-plane icon"></i> Flights</a>
                <a href="${pageContext.request.contextPath}/admin/passengers"><i class="fas fa-users icon"></i> Passengers</a>
                <a href="${pageContext.request.contextPath}/owner/reports"><i class="fas fa-chart-bar icon"></i> Reports</a>
                <a href="${pageContext.request.contextPath}/admin/airports"><i class="fas fa-map-marked-alt icon"></i> Airports</a>
                <a href="${pageContext.request.contextPath}/admin/airlines"><i class="fas fa-briefcase icon"></i> Airlines</a>
                <a href="${pageContext.request.contextPath}/owner/dashboard/flightmanager/list" class="active"><i class="fas fa-user-tie icon"></i> Flight Manager</a>
                <a href="${pageContext.request.contextPath}/owner/feedback"><i class="fas fa-comment-dots icon"></i>Feedback</a>
            </nav>
        </header>

        <main role="main">
            <div class="container">
                <div class="header-section">
                    <h2><i class="fas fa-user-tie icon"></i> Flight Managers Dashboard</h2>
                    <div class="btn-toolbar">
                        <a href="<c:url value='/owner/dashboard/flightmanager/add'/>" class="btn"><i class="fas fa-plus icon"></i> Add New Manager</a>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-users icon"></i> Assigned Flight Managers
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty flightManagers}">
                                <div class="no-data-message">
                                    <i class="fas fa-exclamation-circle icon"></i> No flight managers found. Please add a new manager.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            
                                            <th><i class="fas fa-user icon"></i> Name</th>
                                            <th><i class="fas fa-envelope icon"></i> Email</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="manager" items="${flightManagers}">
                                            <tr class="manager-row" data-manager-id="${manager.fmId}">
                                                
                                                <td>${manager.user.name}</td>
                                                <td>${manager.user.email}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Dynamic nav link highlighting
        document.addEventListener('DOMContentLoaded', function() {
            const currentPath = window.location.pathname;
            const navLinks = document.querySelectorAll('nav a');
            navLinks.forEach(link => {
                if (link.getAttribute('href').includes(currentPath)) {
                    link.classList.add('active');
                } else {
                    link.classList.remove('active');
                }
            });

            // Add 3D effects to table rows
            const tableRows = document.querySelectorAll('.table tbody tr');
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

        // Table row click handler
        document.querySelectorAll('.manager-row').forEach(row => {
            row.addEventListener('click', function() {
                const managerId = this.getAttribute('data-manager-id');
                alert('Viewing details for Manager ID: ' + managerId);
                // Future enhancement: Redirect to a details page, e.g., `/owner/dashboard/flightmanager/details/${managerId}`
            });
        });

        // Validate table data
        function validateTable() {
            const tableRows = document.querySelectorAll('.manager-row');
            if (tableRows.length === 0) {
                console.log('No managers found in table.');
                // No-data message is already handled by JSTL
            } else {
                tableRows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    if (!cells[0].textContent || !cells[1].textContent || !cells[2].textContent) {
                        row.style.background = 'rgba(220, 53, 69, 0.2)';
                        row.title = 'Incomplete manager data';
                    }
                });
            }
        }

        // Run validation on load
        validateTable();
    </script>
</body>
</html>
