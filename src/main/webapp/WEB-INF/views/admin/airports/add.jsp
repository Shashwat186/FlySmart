<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Airport</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --color-light: #F5EEDC;
            --color-primary: #27548A;
            --color-dark: #183B4E;
            --color-accent: #DDA853;
            --glass-bg: rgba(37, 84, 138, 0.15);
            --glass-border: 1px solid rgba(221, 168, 83, 0.2);
            --glass-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            --glass-blur: blur(12px);
            --glass-radius: 16px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            color: var(--color-light);
            background: linear-gradient(135deg, var(--color-dark), var(--color-primary)), 
                        url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            min-height: 100vh;
            animation: gradientShift 15s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .dashboard header {
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
            transition: all 0.5s ease;
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
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
            position: relative;
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

        .content {
            max-width: 600px;
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
            transform: perspective(1000px) translateY(0);
            transition: all 0.5s ease;
        }

        .content:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4), 
                        0 10px 20px rgba(221, 168, 83, 0.2);
            transform: perspective(1000px) translateY(-5px);
        }

        h1 {
            text-align: center;
            color: var(--color-light);
            font-weight: 300;
            letter-spacing: 1px;
            text-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .form-group {
            margin-bottom: 24px;
            transform-style: preserve-3d;
            perspective: 500px;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--color-light);
            transform: translateZ(20px);
        }

        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            font-size: 16px;
            background: rgba(24, 59, 78, 0.3);
            border: var(--glass-border);
            border-radius: 8px;
            color: var(--color-light);
            transition: all 0.3s ease;
            box-sizing: border-box;
            transform-style: preserve-3d;
            transform: translateZ(10px);
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        input[type="text"]:focus {
            border-color: var(--color-accent);
            background: rgba(24, 59, 78, 0.5);
            outline: none;
            box-shadow: 0 0 15px rgba(221, 168, 83, 0.2),
                        inset 0 2px 5px rgba(0, 0, 0, 0.2);
            transform: translateZ(20px);
        }

        .error-message {
            color: rgba(255, 99, 71, 0.9);
            font-size: 14px;
            margin-top: 5px;
            transform: translateZ(10px);
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .btn {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: rgba(221, 168, 83, 0.1);
            color: var(--color-light);
            border: var(--glass-border);
            padding: 12px 0;
            font-size: 15px;
            font-weight: 500;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
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

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(221, 168, 83, 0.2), transparent);
            transition: all 0.5s ease;
        }

        .btn:hover {
            background: rgba(221, 168, 83, 0.2);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            transform: perspective(500px) translateZ(20px) rotateX(5deg);
            color: var(--color-light);
        }

        .btn:hover::before {
            left: 100%;
        }

        .icon {
            display: inline-block;
            margin-right: 8px;
            color: var(--color-accent);
            transform: translateZ(10px);
        }

        .airport-symbol {
            text-align: center;
            margin: 20px 0;
            perspective: 1000px;
        }

        .airport-symbol i {
            font-size: 48px;
            color: var(--color-accent);
            display: inline-block;
            animation: planeFloat 4s ease-in-out infinite;
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        .red-text {
    	color: red;
    	font-weight: bold;
		}
 

        @keyframes planeFloat {
            0% { transform: translateY(0) translateZ(20px); }
            50% { transform: translateY(-10px) translateZ(30px); }
            100% { transform: translateY(0) translateZ(20px); }
        }
      

        @media (max-width: 768px) {
            .content {
                margin: 20px;
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
    </style>
    <script>
        function validateForm() {
            let valid = true;
            
            // Get input elements and error containers
            const nameInput = document.getElementById('name');
            const codeInput = document.getElementById('code');
            const locationInput = document.getElementById('location');
            const contactInput = document.getElementById('contactInfo');
            const nameError = document.getElementById('nameError');
            const codeError = document.getElementById('codeError');
            const locationError = document.getElementById('locationError');
            const contactError = document.getElementById('contactError');

            // Reset error messages
            nameError.textContent = '';
            codeError.textContent = '';
            locationError.textContent = '';
            contactError.textContent = '';

            // Validate Name
            if (!nameInput.value.trim()) {
                nameError.textContent = '✖ Name is required!';
                valid = false;
            }

            // Validate Code
            if (!codeInput.value.trim()) {
                codeError.textContent = '✖ Code is required!';
                valid = false;
            } else if (codeInput.value.length !== 3) {
                codeError.textContent = '✖ Code must be exactly 3 characters!';
                valid = false;
            }

            // Validate Location
            if (!locationInput.value.trim()) {
                locationError.textContent = '✖ Location is required!';
                valid = false;
            }

            // Validate Contact Info (optional, but must be 10 digits if provided)
            const contactValue = contactInput.value.trim();
            if (contactValue && !contactValue.match(/^\d{10}$/)) {
                contactError.textContent = '✖ Contact info must be exactly 10 digits!';
                valid = false;
            }

            // Add shake animation to invalid fields
            if (!valid) {
                const invalidFields = [];
                if (nameError.textContent) invalidFields.push(nameInput);
                if (codeError.textContent) invalidFields.push(codeInput);
                if (locationError.textContent) invalidFields.push(locationInput);
                if (contactError.textContent) invalidFields.push(contactInput);

                invalidFields.forEach(field => {
                    field.style.animation = 'shake 0.5s';
                    setTimeout(() => {
                        field.style.animation = '';
                    }, 500);
                });
            }

            return valid;
        }

        // Add shake animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes shake {
                0%, 100% { transform: perspective(500px) translateZ(10px) translateX(0); }
                20%, 60% { transform: perspective(500px) translateZ(10px) translateX(-5px); }
                40%, 80% { transform: perspective(500px) translateZ(10px) translateX(5px); }
            }
        `;
        document.head.appendChild(style);
    </script>
</head>
<body>
    <div class="dashboard">
        <header>
            <h1><i class="fas fa-plane-departure icon"></i>Add Airport</h1>
        </header>
        <div class="content">
        
    <!-- Add this error message display -->
    <c:if test="${not empty error}">
        <div class="error-banner red-text">
             ${error}
        </div>
    </c:if>
            <div class="airport-symbol">
                <i class="fas fa-plane-arrival"></i>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/admin/airports/add" onsubmit="return validateForm()">
                <div class="form-group">
    <label for="name"><i class="fas fa-signature icon"></i>Name:</label>
    <input type="text" id="name" name="name" placeholder="Enter airport name" required
value="${airport.name}">
    <div class="error-message" id="nameError"></div>
</div>
<div class="form-group">
    <label for="code"><i class="fas fa-code icon"></i>Code:</label>
    <input type="text" id="code" name="code" maxlength="3" placeholder="3-letter code (e.g., JFK)" required
           value="${airport.code}">
    <div class="error-message" id="codeError"></div>
</div>
<div class="form-group">
    <label for="location"><i class="fas fa-map-marker-alt icon"></i>Location:</label>
    <input type="text" id="location" name="location" placeholder="City and country" required
           value="${airport.location}">
    <div class="error-message" id="locationError"></div>
</div>
<div class="form-group">
    <label for="contactInfo"><i class="fas fa-phone-alt icon"></i>Contact Info:</label>
    <input type="text" id="contactInfo" name="contactInfo" placeholder="10-digit phone number (optional)" maxlength="10"
           value="${airport.contactInfo}">
    <div class="error-message" id="contactError"></div>
</div>
                <div class="button-container">
                    <button type="submit" class="btn"><i class="fas fa-save icon"></i>Save</button>
                    <a href="${pageContext.request.contextPath}/admin/airports" class="btn"><i class="fas fa-times icon"></i>Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
