<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Airport</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
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

@import url('https://fonts.googleapis.com/css2?family=Segoe+UI:wght@300;400;500;600;700&display=swap');

body {
  margin: 0;
  padding: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)),
              url('https://images.unsplash.com/photo-1556388158-158ea5ccacbd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
  background-size: cover;
  background-attachment: fixed;
  background-position: center;
  color: var(--color-light);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.03); }
}

@keyframes fadeInDown {
  from { opacity: 0; transform: translateY(-20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes slideIn {
  from { opacity: 0; transform: translateX(-20px); }
  to { opacity: 1; transform: translateX(0); }
}

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

header {
  backdrop-filter: var(--glass-blur);
  -webkit-backdrop-filter: var(--glass-blur);
  background: var(--glass-bg);
  border-bottom: var(--glass-border);
  box-shadow: var(--glass-shadow),
              0 4px 30px rgba(221, 168, 83, 0.1);
  color: var(--color-light);
  text-align: center;
  padding: 20px;
  position: relative;
  z-index: 10;
  transform-style: preserve-3d;
  transition: var(--transition);
}

header:hover {
  transform: perspective(1000px) rotateX(5deg);
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4),
              0 4px 30px rgba(221, 168, 83, 0.2);
}

header h1 {
  margin: 0;
  font-size: 2.5rem;
  font-weight: 400;
  letter-spacing: 1px;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  animation: pulse 6s infinite;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

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
  background: rgba(39, 84, 138, 0.3);
  border: var(--glass-border);
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

nav a:hover, nav a.active {
  background: var(--color-accent);
  color: var(--color-dark);
  transform: translateY(-3px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
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

.form-group {
  margin-bottom: 25px;
  position: relative;
  animation: slideIn 0.5s ease-out;
  animation-fill-mode: both;
}

.form-group:nth-child(2) { animation-delay: 0.1s; }
.form-group:nth-child(3) { animation-delay: 0.2s; }
.form-group:nth-child(4) { animation-delay: 0.3s; }
.form-group:nth-child(5) { animation-delay: 0.4s; }

label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 500;
  margin-bottom: 8px;
  color: var(--color-light);
  font-size: 15px;
}

input[type="text"], input[type="email"] {
  width: 100%;
  padding: 12px 15px;
  font-size: 16px;
  background: rgba(24, 59, 78, 0.3);
  border: var(--glass-border);
  border-radius: 8px;
  color: var(--color-light);
  transition: var(--transition);
  box-sizing: border-box;
}

input[type="text"]:focus, input[type="email"]:focus {
  border-color: var(--color-accent);
  background: rgba(39, 84, 138, 0.3);
  outline: none;
  box-shadow: 0 0 15px rgba(221, 168, 83, 0.3);
}

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
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.btn-primary {
  background: rgba(221, 168, 83, 0.3);
  color: var(--color-light);
  border: var(--glass-border);
}

.btn-secondary {
  background: rgba(39, 84, 138, 0.3);
  color: var(--color-light);
  border: var(--glass-border);
}

.btn:hover {
  background: rgba(221, 168, 83, 0.4);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
  transform: translateY(-3px) translateZ(10px);
}

.validation-error {
  color: #ff6b6b;
  font-size: 13px;
  margin-top: 5px;
  display: flex;
  align-items: center;
}

.validation-error::before {
  content: '⚠️';
  margin-right: 5px;
  font-size: 14px;
}

input.error {
  border-color: #ff6b6b;
  background: rgba(244, 67, 54, 0.1);
}

.red-text {
    	color: red;
    	font-weight: bold;
		}
 
.form-icon {
  text-align: center;
  font-size: 50px;
  margin-bottom: 20px;
  color: var(--color-accent);
  animation: pulse 6s infinite;
}

@media (max-width: 768px) {
  .content {
    padding: 20px;
    margin: 20px;
  }

  nav {
    flex-direction: column;
    align-items: center;
    gap: 10px;
  }

  nav a {
    width: 80%;
    text-align: center;
  }
}
</style>
</head>
<body>
<div class="floating-symbol symbol-1">✈️</div>
<div class="floating-symbol symbol-2">🛫</div>
<div class="floating-symbol symbol-3">🛬</div>
<div class="floating-symbol symbol-4">🌐</div>
<div class="floating-symbol symbol-5">🛩</div>

<div class="dashboard">
<header>
<h1><i class="fas fa-map-marked-alt icon"></i> Edit Airport</h1>
</header>
<div class="content">
<c:if test="${not empty error}">
<div class="error-banner red-text">
 ${error}
</div>
</c:if>
<div class="form-icon">✈️</div>
<form method="post" action="${pageContext.request.contextPath}/admin/airports/edit/${airport.airportId}" onsubmit="return validateEditForm()">
<div class="form-group">
<label for="name"><i class="fas fa-building icon"></i> Name:</label>
<input type="text" id="name" name="name" value="${airport.name}" required placeholder="Enter airport name">
</div>
<div class="form-group">
<label for="code"><i class="fas fa-barcode icon"></i> Code:</label>
<input type="text" id="code" name="code" value="${airport.code}" maxlength="3" required placeholder="3-letter code (e.g., JFK)">
</div>
<div class="form-group">
<label for="location"><i class="fas fa-map-marker-alt icon"></i> Location:</label>
<input type="text" id="location" name="location" value="${airport.location}" required placeholder="City, Country">
</div>
<div class="form-group">
<label for="contactInfo"><i class="fas fa-phone-alt icon"></i> Contact Info:</label>
<input type="text" id="contactInfo" name="contactInfo" value="${airport.contactInfo}" placeholder="10-digit phone number" maxlength="10">
</div>
<div style="text-align: center; margin-top: 30px;">
<button type="submit" class="btn btn-primary"><i class="fas fa-save icon"></i> Update Airport</button>
<a href="${pageContext.request.contextPath}/admin/airports" class="btn btn-secondary cancel"><i class="fas fa-times icon"></i> Cancel</a>
</div>
</form>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function validateEditForm() {
  let isValid = true;
  const name = document.getElementById('name');
  const code = document.getElementById('code');
  const location = document.getElementById('location');
  const contactInfo = document.getElementById('contactInfo');
  
  // Clear previous validation
  document.querySelectorAll('.validation-error').forEach(el => el.remove());
  document.querySelectorAll('.valid-feedback').forEach(el => el.remove());
  name.classList.remove('error', 'valid');
  code.classList.remove('error', 'valid');
  location.classList.remove('error', 'valid');
  contactInfo.classList.remove('error', 'valid');
  
  // Validate Name
  if (!name.value.trim()) {
    showError(name, 'Name is required ✈️');
    isValid = false;
  }
  
  // Validate Code
  if (!code.value.trim()) {
    showError(code, 'Code is required (3 letters)');
    isValid = false;
  } else if (code.value.trim().length !== 3) {
    showError(code, 'Code must be exactly 3 characters');
    isValid = false;
  }
  
  // Validate Location
  if (!location.value.trim()) {
    showError(location, 'Location is required 🌍');
    isValid = false;
  }
  
  // Validate Contact Info (optional, but exactly 10 digits if provided)
  const contactValue = contactInfo.value.trim();
  if (contactValue && !contactValue.match(/^\d{10}$/)) {
    showError(contactInfo, 'Contact info must be exactly 10 digits 📞');
    isValid = false;
  }
  
  // Only show valid feedback if the form is completely valid
  if (isValid) {
    showValid(name, 'Looks good!');
    showValid(code, 'Perfect airport code!');
    showValid(location, 'Great location!');
    if (contactValue) {
      showValid(contactInfo, 'Valid contact info!');
    } else {
      showValid(contactInfo, 'Optional field left blank.');
    }
  }
  
  return isValid;
}

function showError(input, message) {
  input.classList.add('error');
  const error = document.createElement('div');
  error.className = 'validation-error';
  error.textContent = message;
  input.parentNode.appendChild(error);
  input.focus();
}

function showValid(input, message) {
  input.classList.add('valid');
  const valid = document.createElement('div');
  valid.className = 'valid-feedback';
  valid.textContent = message;
  input.parentNode.appendChild(valid);
}
</script>
</body>
</html>