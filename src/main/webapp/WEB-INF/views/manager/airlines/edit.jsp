<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Airline</title>
    <%-- Use Bootstrap and Font Awesome for icons and potentially some base styling --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Styles copied from Edit Airport example */
        :root {
            --color-light: #F5EEDC;
            --color-primary: #27548A; /* Primary color from original Airline */
            --color-dark: #183B4E; /* Secondary color from original Airline */
            --color-accent: #DDA853; /* Accent color from original Airline */
            --glass-bg: rgba(39, 84, 138, 0.15); /* Glass BG from original Airline */
            --glass-border: 1px solid rgba(221, 168, 83, 0.2); /* Glass Edge from original Airline */
            --glass-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3); /* Shadow from Airport */
            --glass-blur: blur(12px); /* Blur from Airport */
            --glass-radius: 16px; /* Radius from Airport */
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @import url('https://fonts.googleapis.com/css2?family=Segoe+UI:wght@300;400;500;600;700&display=swap'); /* Font from Airport */

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Font from Airport */
            /* Background from original Airline */
            background: linear-gradient(rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)),
                        url('https://images.unsplash.com/photo-1556388158-158ea5ccacbd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
            background-attachment: fixed; /* Ensure background stays fixed */
            color: var(--color-light);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Animations from Airport */
        @keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
        @keyframes pulse { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.03); } }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes slideIn { from { opacity: 0; transform: translateX(-20px); } to { opacity: 1; transform: translateX(0); } }

        /* Floating symbols from Airport */
        .floating-symbol {
            position: fixed;
            font-size: 24px;
            opacity: 0.1;
            color: var(--color-accent);
            animation: float 15s infinite linear;
            z-index: -1;
        }
        .symbol-1 { top: 10%; left: 5%; animation-delay: 0s; }
        .symbol-2 { top: 25%; left: 80%; animation-delay: 2s; }
        .symbol-3 { top: 60%; left: 15%; animation-delay: 4s; }
        .symbol-4 { top: 75%; left: 70%; animation-delay: 6s; }
        .symbol-5 { top: 40%; left: 50%; animation-delay: 8s; }

        /* Header styling adapted from Airport */
        header {
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border-bottom: var(--glass-border);
            box-shadow: var(--glass-shadow), 0 4px 30px rgba(221, 168, 83, 0.1);
            color: var(--color-light);
            text-align: center;
            padding: 20px;
            position: relative;
            z-index: 10;
            transform-style: preserve-3d;
            transition: var(--transition);
        }
        header:hover {
            transform: perspective(1000px) rotateX(2deg); /* Reduced rotation */
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.35), 0 4px 30px rgba(221, 168, 83, 0.15);
        }
        header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 400; /* Adjusted weight */
            letter-spacing: 1px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            animation: pulse 7s infinite; /* Slightly slower pulse */
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px; /* Increased gap */
        }

        /* Nav styling adapted from Airport */
        nav {
            margin-top: 15px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        nav a {
            color: rgba(245, 238, 220, 0.8);
            text-decoration: none;
            padding: 8px 20px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 30px;
            transition: var(--transition);
            background: rgba(39, 84, 138, 0.3); /* Use primary color tone */
            border: var(--glass-border);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        nav a:hover, nav a.active { /* Keep active class styling */
            background: var(--color-accent);
            color: var(--color-dark);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }

        /* Content area styling from Airport */
        .content {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            background: var(--glass-bg);
            border: var(--glass-border);
            border-radius: var(--glass-radius);
            box-shadow: var(--glass-shadow);
            animation: fadeInUp 0.8s ease-out;
            position: relative;
            transform-style: preserve-3d;
            transition: var(--transition);
        }
        .content:hover {
            transform: translateY(-5px) rotateX(1deg) rotateY(1deg);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
        }

        /* Form group styling from Airport */
        .form-group {
            margin-bottom: 25px;
            position: relative;
            animation: slideIn 0.5s ease-out;
            animation-fill-mode: both;
        }
        .form-group:nth-child(1) { animation-delay: 0s; } /* Start delay from 0 */
        .form-group:nth-child(2) { animation-delay: 0.1s; }
        .form-group:nth-child(3) { animation-delay: 0.2s; }
        .form-group:nth-child(4) { animation-delay: 0.3s; } /* For buttons */

        /* Label styling from Airport */
        label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--color-light);
            font-size: 15px;
        }

        /* Input styling from Airport */
        input[type="text"], input[type="email"] { /* Added email just in case */
            width: 100%;
            padding: 12px 15px;
            font-size: 16px;
            background: rgba(24, 59, 78, 0.3); /* Darker input background */
            border: var(--glass-border);
            border-radius: 8px;
            color: var(--color-light);
            transition: var(--transition);
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="email"]:focus {
            border-color: var(--color-accent);
            background: rgba(39, 84, 138, 0.3); /* Lighter focus background */
            outline: none;
            box-shadow: 0 0 15px rgba(221, 168, 83, 0.3);
        }

        /* Button styling from Airport */
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin: 5px;
            transform-style: preserve-3d;
            display: inline-flex; /* Use inline-flex */
            align-items: center; /* Align icon and text */
            gap: 8px; /* Gap between icon and text */
        }
        .btn-primary { /* Update button */
            background: rgba(221, 168, 83, 0.3); /* Accent color based */
            color: var(--color-light);
            border: var(--glass-border);
        }
        .btn-secondary { /* Cancel button */
            background: rgba(39, 84, 138, 0.3); /* Primary color based */
            color: var(--color-light);
            border: var(--glass-border);
        }
        .btn:hover {
            background: rgba(221, 168, 83, 0.4); /* Slightly brighter accent on hover */
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            transform: translateY(-3px) translateZ(10px);
        }
         /* Specific hover for secondary button if needed */
        .btn-secondary:hover {
            background: rgba(39, 84, 138, 0.5);
        }
        .red-text {
    	color: red;
    	font-weight: bold;
		}

        /* Validation styles from Airport */
       
       

        /* Form icon styling from Airport (optional) */
        .form-icon {
            text-align: center;
            font-size: 50px;
            margin-bottom: 20px;
            color: var(--color-accent);
            animation: pulse 6s infinite;
        }

        /* Responsive adjustments from Airport */
        @media (max-width: 768px) {
            .content { padding: 20px; margin: 20px; }
            nav { flex-direction: column; align-items: center; gap: 10px; }
            nav a { width: 80%; text-align: center; justify-content: center; }
            header h1 { font-size: 2rem; }
        }
    </style>
</head>
<body>
    <%-- Floating symbols from Airport --%>
    
        </header>

        <div class="content">
        <c:if test="${not empty error}">
        <div class="error-banner red-text">
             ${error}
        </div>
    </c:if>
            <%-- Optional form icon --%>
            <div class="form-icon">✏️</div>
            <%-- Updated form using Airport's structure and validation function --%>
            <form method="post" action="${pageContext.request.contextPath}/manager/airlines/edit/${airline.airlineId}" onsubmit="return validateAirlineForm()">
                <div class="form-group">
                    <%-- Label with icon --%>
                    <label for="name"><i class="fas fa-signature"></i> Name:</label>
                    <%-- Input with placeholder --%>
                    <input type="text" id="name" name="name" value="${airline.name}" required placeholder="Enter airline name">
                    <%-- Validation messages will be added by JS --%>
                </div>
                <div class="form-group">
                    <label for="code"><i class="fas fa-barcode"></i> Code:</label>
                    <%-- Corrected maxlength and placeholder --%>
                    <input type="text" id="code" name="code" value="${airline.code}" maxlength="2" required placeholder="2-letter code (e.g., DC)">
                </div>
                <div class="form-group">
                    <label for="contactInfo"><i class="fas fa-phone-alt"></i> Contact Info:</label>
                    <%-- Placeholder and maxlength for contact --%>
                    <input type="text" id="contactInfo" name="contactInfo" value="${airline.contactInfo}" placeholder="10-digit phone number (optional)" maxlength="10">
                </div>
                <div style="text-align: center; margin-top: 30px;" class="form-group"> <%-- Added form-group for animation --%>
                    <%-- Buttons with icons and classes --%>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-sync-alt"></i> Update Airline</button>
                    <a href="${pageContext.request.contextPath}/manager/airlines" class="btn btn-secondary"><i class="fas fa-times"></i> Cancel</a>
                </div>
            </form>
        </div>
    </div>

    <%-- Bootstrap JS Bundle (optional, but good practice if using Bootstrap components) --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <%-- JavaScript validation logic adapted from Airport --%>
    <script>
        function validateAirlineForm() {
            let isValid = true;
            // Get elements
            const nameInput = document.getElementById('name');
            const codeInput = document.getElementById('code');
            const contactInput = document.getElementById('contactInfo');

            // Clear previous validation states and messages
            clearValidation(nameInput);
            clearValidation(codeInput);
            clearValidation(contactInput);

            // Validate Name
            if (!nameInput.value.trim()) {
                showError(nameInput, 'Airline Name is required 🏷️');
                isValid = false;
            } else {
                showValid(nameInput, 'Looks good!');
            }

            // Validate Code
            const codeValue = codeInput.value.trim();
            if (!codeValue) {
                showError(codeInput, 'Airline Code is required ✈️');
                isValid = false;
            } else if (codeValue.length !== 2) { // Correct length check
                showError(codeInput, 'Code must be exactly 2 characters');
                isValid = false;
            } else {
                showValid(codeInput, 'Valid airline code!');
            }

            // Validate Contact Info (Optional, but must be 10 digits if provided)
            const contactValue = contactInput.value.trim();
            if (contactValue && !contactValue.match(/^\d{10}$/)) { // Regex for exactly 10 digits
                showError(contactInput, 'Contact info must be exactly 10 digits 📞 (if provided)');
                isValid = false;
            } else if (contactValue) {
                showValid(contactInput, 'Valid contact info!');
            } else {
                 // Optionally show valid state even if empty as it's optional
                 showValid(contactInput, 'Contact info (Optional)');
            }

            return isValid;
        }

        // Helper function to clear previous validation
        function clearValidation(inputElement) {
            inputElement.classList.remove('error', 'valid');
            const parent = inputElement.parentNode;
            const errorMsg = parent.querySelector('.validation-error');
            const validMsg = parent.querySelector('.valid-feedback');
            if (errorMsg) errorMsg.remove();
            if (validMsg) validMsg.remove();
        }

        // Helper function to show error messages (from Airport)
        function showError(input, message) {
            clearValidation(input); // Clear previous state first
            input.classList.add('error');
            const errorDiv = document.createElement('div');
            errorDiv.className = 'validation-error';
            errorDiv.textContent = message;
            // Insert after the input element
            input.parentNode.insertBefore(errorDiv, input.nextSibling);
             // Optionally focus the first invalid field
             if (!document.querySelector('.error:focus')) {
                input.focus();
             }
        }

        // Helper function to show valid feedback (from Airport)
        function showValid(input, message) {
             clearValidation(input); // Clear previous state first
             input.classList.add('valid');
             const validDiv = document.createElement('div');
             validDiv.className = 'valid-feedback';
             validDiv.textContent = message;
             // Insert after the input element
             input.parentNode.insertBefore(validDiv, input.nextSibling);
        }
    </script>
</body>
</html>