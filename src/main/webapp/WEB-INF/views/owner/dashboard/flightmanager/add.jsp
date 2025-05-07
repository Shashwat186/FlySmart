<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Flight Manager</title>
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
            line-height: 1.6;
        }

        /* Container */
        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 0 20px;
            perspective: 1000px;
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

        /* Form Container */
        .content {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            border-radius: var(--glass-radius);
            box-shadow: var(--glass-shadow);
            padding: 30px;
            margin-bottom: 30px;
            transition: var(--transition);
            transform-style: preserve-3d;
            transform: perspective(1000px);
        }

        .content:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4), 0 10px 20px rgba(221, 168, 83, 0.2);
            transform: perspective(1000px) translateY(-5px);
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 24px;
            transform-style: preserve-3d;
            perspective: 500px;
        }

        .form-label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--color-light);
            transform: translateZ(20px);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 12px 15px;
            font-size: 16px;
            background: rgba(24, 59, 78, 0.3);
            border: var(--glass-border);
            border-radius: 8px;
            color: var(--color-light);
            transition: var(--transition);
            box-sizing: border-box;
            transform-style: preserve-3d;
            transform: translateZ(10px);
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--color-accent);
            background: rgba(39, 84, 138, 0.3);
            outline: none;
            box-shadow: 0 0 10px rgba(221, 168, 83, 0.2);
            transform: translateZ(20px);
        }

        /* Button Container */
        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        /* Button Styling */
        .btn {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(221, 168, 83, 0.2);
            color: var(--color-light);
            border: var(--glass-border);
            padding: 12px 0;
            font-size: 15px;
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
            width: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
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

        /* Error and Success Messages */
        .text-danger {
            color: rgba(255, 99, 71, 0.9);
            font-size: 14px;
            margin-top: 5px;
            transform: translateZ(10px);
        }

        .alert {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            box-shadow: var(--glass-shadow);
            border-radius: var(--glass-radius);
            padding: 15px;
            margin-top: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--color-light);
            transform-style: preserve-3d;
            transform: translateZ(10px);
        }

        .alert-success {
            background: rgba(40, 167, 69, 0.2);
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.2);
        }

        /* Icons */
        .icon {
            display: inline-block;
            margin-right: 8px;
            color: var(--color-accent);
            transform: translateZ(10px);
        }

        /* Date Picker */
        input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1);
        }

        /* Select Options */
        option {
            background-color: var(--color-dark);
            color: var(--color-light);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 0 10px;
            }

            .content {
                padding: 20px;
            }

            nav a {
                margin: 0 10px;
                font-size: 14px;
            }

            .button-container {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }

            .btn {
                width: 100%;
                max-width: 200px;
            }
        }

        /* Shake Animation for Invalid Fields */
        @keyframes shake {
            0%, 100% { transform: perspective(500px) translateZ(10px) translateX(0); }
            20%, 60% { transform: perspective(500px) translateZ(10px) translateX(-5px); }
            40%, 80% { transform: perspective(500px) translateZ(10px) translateX(5px); }
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <header>
            <h1><i class="fas fa-user-tie icon"></i> Add New Flight Manager</h1>
            
        </header>
        <div class="container">
        
            <div class="content">
               <c:if test="${not empty success}">
                    <div class="alert alert-success"><i class="fas fa-check-circle icon"></i> ${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger"><i class="fas fa-exclamation-circle icon"></i> ${error}</div>
                </c:if>
                <form:form method="post" modelAttribute="managerForm" action="/owner/dashboard/flightmanager/add" id="addManagerForm">
                    <div class="form-group">
                        <form:label path="name" class="form-label"><i class="fas fa-signature icon"></i> Full Name:</form:label>
                        <form:input path="name" class="form-control" required="true" placeholder="Enter full name"/>
                        <form:errors path="name" class="text-danger"/>
                    </div>
                    <div class="form-group">
                        <form:label path="email" class="form-label"><i class="fas fa-envelope icon"></i> Email:</form:label>
                        <form:input path="email" type="email" class="form-control" required="true" placeholder="Enter email address"/>
                        <form:errors path="email" class="text-danger"/>
                    </div>
                    <div class="form-group">
                        <form:label path="phone" class="form-label"><i class="fas fa-phone-alt icon"></i> Phone:</form:label>
                        <form:input path="phone" class="form-control" required="true" placeholder="Enter phone number"/>
                        <form:errors path="phone" class="text-danger"/>
                    </div>
                    <div class="form-group">
                        <form:label path="gender" class="form-label"><i class="fas fa-venus-mars icon"></i> Gender:</form:label>
                        <form:select path="gender" class="form-select" required="true">
                            <form:option value="">-- Select Gender --</form:option>
                            <form:option value="MALE">Male</form:option>
                            <form:option value="FEMALE">Female</form:option>
                            <form:option value="OTHER">Other</form:option>
                        </form:select>
                        <form:errors path="gender" class="text-danger"/>
                    </div>
                    <div class="form-group">
                        <form:label path="dob" class="form-label"><i class="fas fa-calendar-alt icon"></i> Date of Birth:</form:label>
                        <form:input path="dob" type="date" class="form-control" required="true"/>
                        <form:errors path="dob" class="text-danger"/>
                    </div>
                    <div class="form-group">
                        <form:label path="password" class="form-label"><i class="fas fa-lock icon"></i> Password:</form:label>
                        <form:password path="password" class="form-control" required="true" placeholder="Enter password"/>
                        <form:errors path="password" class="text-danger"/>
                    </div>
                    <div class="button-container">
                        <a href="/owner/dashboard/flightmanager/list" class="btn"><i class="fas fa-times icon"></i> Cancel</a>
                        <button type="submit" class="btn"><i class="fas fa-save icon"></i> Create Manager</button>
                    </div>
                </form:form>

             
            </div>
        </div>
    </div>

    <script>
        // Client-side validation with shake animation
        document.getElementById('addManagerForm').addEventListener('submit', function(e) {
            let valid = true;
            const inputs = document.querySelectorAll('.form-control, .form-select');
            const invalidFields = [];

            inputs.forEach(input => {
                const errorElement = input.nextElementSibling;
                if (errorElement && errorElement.classList.contains('text-danger') && errorElement.textContent) {
                    valid = false;
                    invalidFields.push(input);
                }
            });

            if (!valid) {
                e.preventDefault();
                invalidFields.forEach(field => {
                    field.style.animation = 'shake 0.5s';
                    setTimeout(() => {
                        field.style.animation = '';
                    }, 500);
                });
            }
        });

        // Label color change on focus
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('.form-control, .form-select');
            inputs.forEach(input => {
                input.addEventListener('focus', () => {
                    const label = input.parentElement.querySelector('.form-label');
                    if (label) {
                        label.style.color = 'var(--color-accent)';
                        label.style.transform = 'translateZ(30px)';
                    }
                });

                input.addEventListener('blur', () => {
                    const label = input.parentElement.querySelector('.form-label');
                    if (label) {
                        label.style.color = 'var(--color-light)';
                        label.style.transform = 'translateZ(20px)';
                    }
                });
            });
        });
    </script>
</body>
</html>