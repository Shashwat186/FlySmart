<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passenger Dashboard</title>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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

        /* Glassmorphism Header without 3D effects */
        .dashboard-header {
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
            transition: all 0.3s ease;
        }

        .dashboard-header h1 {
            margin: 0 0 16px 0;
            font-weight: 300;
            letter-spacing: 2px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        /* Navigation without 3D effects */
        nav {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        nav .nav-link {
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

        nav .nav-link:hover, nav .nav-link.active {
            color: var(--color-light);
            border-bottom: 2px solid var(--color-accent);
        }

        nav .nav-link::after {
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

        nav .nav-link:hover::after, nav .nav-link.active::after {
            transform: scaleX(1);
            transform-origin: left;
        }

        /* Content Area */
        .dashboard-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 15px;
        }

        .activity-card {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            border-radius: var(--glass-radius);
            box-shadow: var(--glass-shadow),
                        0 10px 20px rgba(221, 168, 83, 0.1);
            padding: 30px;
            transition: all 0.3s ease;
        }

        /* Quick Actions */
        .quick-actions {
            margin-bottom: 30px;
        }

        .quick-actions h2 {
            margin-top: 0;
            font-weight: 400;
            letter-spacing: 1px;
            color: var(--color-light);
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
        }

        .btn-action {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            border-radius: 8px;
            color: var(--color-light);
            padding: 12px 24px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
            box-shadow: var(--glass-shadow);
        }

        .btn-action:hover {
            color: var(--color-accent);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.3);
        }

        .btn-primary {
            background: rgba(221, 168, 83, 0.2);
        }

        .btn-secondary {
            background: rgba(39, 84, 138, 0.3);
        }

        .btn-details {
            padding: 6px 12px;
            font-size: 14px;
            background: rgba(221, 168, 83, 0.15);
        }

        /* Recent Bookings */
        .recent-bookings h2 {
            margin-top: 0;
            font-weight: 400;
            letter-spacing: 1px;
            color: var(--color-light);
        }

        /* Table Styling */
        .bookings-table-container {
            overflow-x: auto;
        }

        .bookings-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border-radius: 8px;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .bookings-table thead tr {
            background: rgba(24, 59, 78, 0.5);
        }

        .bookings-table th, .bookings-table td {
            padding: 16px;
            text-align: left;
            border-bottom: var(--glass-border);
        }

        .bookings-table th {
            font-weight: 500;
            letter-spacing: 1px;
            font-size: 14px;
            text-transform: uppercase;
            color: var(--color-accent);
        }

        .bookings-table td {
            color: rgba(245, 238, 220, 0.9);
        }

        .bookings-table tbody tr {
            background: rgba(255, 255, 255, 0.03);
            transition: all 0.3s ease;
        }

        .bookings-table tbody tr:hover {
            background: rgba(221, 168, 83, 0.1);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Status colors */
        .status-scheduled {
            color: #4caf50;
        }

        .status-delayed {
            color: #ff9800;
        }

        .status-cancelled {
            color: #f44336;
        }

        .status-completed {
            color: #2196f3;
        }

        /* No bookings message */
        .glass-alert {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(221, 168, 83, 0.1);
            border: var(--glass-border);
            border-radius: 8px;
            padding: 15px;
            display: inline-block;
            margin-top: 10px;
        }

        /* Icons and Symbols */
        .icon {
            display: inline-block;
            margin-right: 8px;
            color: var(--color-accent);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-header h1 {
                font-size: 24px;
            }

            nav .nav-link {
                margin: 0 10px;
                font-size: 14px;
            }

            .activity-card {
                padding: 20px;
                margin: 20px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .bookings-table th, .bookings-table td {
                padding: 10px;
            }
            .user-badge {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 20px;
    padding: 5px 15px;
    margin-left: 10px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    transition: all 0.3s ease;
    color: #fff !important;
    font-weight: 500;
}

.user-badge:hover {
    background: rgba(255, 255, 255, 0.2);
    border-color: rgba(255, 255, 255, 0.3);
    transform: none;
    color: #fff !important;
}


        }
        .user-badge i {
    color: #DDA853; /* Gold color for the icon */
}

/* Remove underline on hover */
.user-badge:hover {
    text-decoration: none;
}

/* Make it slightly different on active state */
.user-badge:active {
    transform: scale(0.98);
}
    </style>
</head>
<body>
    <div class="passenger-dashboard">
        <header class="dashboard-header">
            <div class="container">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
                    <h1 class="mb-3 mb-md-0">
                        <i class="fas fa-user icon"></i>Welcome, ${passenger.name}!
                    </h1>
                </div>
                
                <nav class="nav justify-content-center mt-3 mt-md-4">
                    <a href="${pageContext.request.contextPath}/passenger/dashboard" class="nav-link active">
                        <i class="fas fa-tachometer-alt icon"></i>Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/passenger/bookings" class="nav-link">
                        <i class="fas fa-ticket icon"></i>My Bookings
                    </a>
                   
                    
                    <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link">
                        <i class="fas fa-sign-out-alt icon"></i>Logout
                    </a>
                    <a href="${pageContext.request.contextPath}/passenger/profile/${passenger.userId}" class="nav-link user-badge">
                        <i class="fas fa-user me-2"></i>${user.name}
                    </a>
                    
                </nav>
            </div>
        </header>

        <main class="dashboard-content">
            <div class="activity-card">
                <div class="quick-actions">
                    <h2 class="h4 mb-3">
                        <i class="fas fa-bolt icon"></i>Quick Actions
                    </h2>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/booking/search" class="btn-action btn-primary">
                            <i class="fas fa-plane icon"></i>Book a Flight
                        </a>
                        <a href="${pageContext.request.contextPath}/passenger/bookings" class="btn-action btn-secondary">
                            <i class="fas fa-eye icon"></i>View Bookings
                        </a>
                    </div>
                </div>

                
            </div>
        </main>
    </div>
</body>
</html>
