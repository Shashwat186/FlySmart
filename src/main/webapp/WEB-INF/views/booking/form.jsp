<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/booking/form.css">

    <script>
        function validateForm() {
            let valid = true;

            // Validate Lead Adult (Passenger 1)
            const leadNameInput = document.getElementById('adults[0].name');
            const leadEmailInput = document.getElementById('adults[0].email');
            const seatClassSelect = document.getElementById('seatClassId');
            const leadNameError = document.getElementById('leadNameError');
            const leadEmailError = document.getElementById('leadEmailError');
            const seatClassError = document.getElementById('seatClassError');

            // Reset error messages
            leadNameError.textContent = '';
            leadEmailError.textContent = '';
            seatClassError.textContent = '';

            // Validate Lead Adult Name
            if (!leadNameInput.value.trim()) {
                leadNameError.textContent = 'Name is required!';
                valid = false;
            } else if (leadNameInput.value.length > 100) {
                leadNameError.textContent = 'Name cannot exceed 100 characters!';
                valid = false;
            }

            // Validate Lead Adult Email (optional but validated if provided)
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (leadEmailInput.value.trim() && !emailRegex.test(leadEmailInput.value)) {
                leadEmailError.textContent = 'Please enter a valid email address!';
                valid = false;
            } else if (leadEmailInput.value.length > 255) {
                leadEmailError.textContent = 'Email cannot exceed 255 characters!';
                valid = false;
            }

            // Validate Seat Class
            if (!seatClassSelect.value) {
                seatClassError.textContent = 'Please select a seat class!';
                valid = false;
            }

            // Validate dynamically generated fields (additional adults and children)
            const adultNameInputs = document.querySelectorAll('input[name*="adults["][name$=".name"]');
            const childNameInputs = document.querySelectorAll('input[name*="children["][name$=".name"]');
            const childAgeInputs = document.querySelectorAll('input[name*="children["][name$=".age"]');

            // Validate additional adult names
            adultNameInputs.forEach((input, index) => {
                const errorDiv = input.nextElementSibling || document.createElement('div');
                errorDiv.className = 'error-message text-danger';
                errorDiv.id = `adultNameError${index}`;
                if (!input.nextElementSibling) input.parentNode.appendChild(errorDiv);
                errorDiv.textContent = '';
                if (!input.value.trim()) {
                    errorDiv.textContent = 'Name is required!';
                    valid = false;
                } else if (input.value.length > 100) {
                    errorDiv.textContent = 'Name cannot exceed 100 characters!';
                    valid = false;
                }
            });

            // Validate child names and ages
            childNameInputs.forEach((input, index) => {
                const errorDiv = input.nextElementSibling || document.createElement('div');
                errorDiv.className = 'error-message text-danger';
                errorDiv.id = `childNameError${index}`;
                if (!input.nextElementSibling) input.parentNode.appendChild(errorDiv);
                errorDiv.textContent = '';
                if (!input.value.trim()) {
                    errorDiv.textContent = 'Name is required!';
                    valid = false;
                } else if (input.value.length > 100) {
                    errorDiv.textContent = 'Name cannot exceed 100 characters!';
                    valid = false;
                }
            });

            childAgeInputs.forEach((input, index) => {
                const errorDiv = input.nextElementSibling || document.createElement('div');
                errorDiv.className = 'error-message text-danger';
                errorDiv.id = `childAgeError${index}`;
                if (!input.nextElementSibling) input.parentNode.appendChild(errorDiv);
                errorDiv.textContent = '';
                const age = parseInt(input.value);
                if (!input.value) {
                    errorDiv.textContent = 'Age is required!';
                    valid = false;
                } else if (isNaN(age) || age < 1 || age > 11) {
                    errorDiv.textContent = 'Age must be between 1 and 11!';
                    valid = false;
                }
            });

            return valid;
        }

        document.addEventListener('DOMContentLoaded', function () {
            const numberOfAdultsHidden = document.getElementById('numberOfAdults');
            const numberOfChildrenHidden = document.getElementById('numberOfChildren');
            const seatClassSelect = document.getElementById('seatClassId');
            const additionalPassengerFieldsContainer = document.getElementById('additional-passenger-fields-container');
            const totalPriceSpan = document.getElementById('price');
            const hiddenPriceInput = document.getElementById('hiddenPrice');

            const numAdults = parseInt(numberOfAdultsHidden.value);
            const numChildren = parseInt(numberOfChildrenHidden.value);

            // Initialize with default values
            const departureDateTime = new Date('${flight.departureDateTime}');
            const arrivalDateTime = new Date('${flight.arrivalDateTime}');
            const durationMs = arrivalDateTime.getTime() - departureDateTime.getTime();
            const durationMinutes = Math.floor(durationMs / (1000 * 60));
            const priceMultiplier = 10;

            function updateTotalPrice() {
                const selectedSeatClassOption = seatClassSelect.options[seatClassSelect.selectedIndex];
                const seatPrice = parseFloat(selectedSeatClassOption ? selectedSeatClassOption.dataset.seatPrice : 0);
                const flightDurationPrice = durationMinutes * priceMultiplier;
                const totalPrice = (seatPrice + flightDurationPrice) * (numAdults + numChildren);
                totalPriceSpan.textContent = totalPrice.toFixed(2);
                hiddenPriceInput.value = totalPrice.toFixed(2);
            }

            function generatePassengerForms() {
                // Clear container
                additionalPassengerFieldsContainer.innerHTML = '';

                // Create additional adult forms (starting from index 1, as the first is already there)
                for (let i = 1; i < numAdults; i++) {
                    const adultContainer = document.createElement('div');
                    const heading = document.createElement('h2');
                    heading.className = 'mt-3';
                    heading.textContent = 'Additional Adult ' + (i + 1);
                    adultContainer.appendChild(heading);
                    const nameContainer = document.createElement('div');
                    nameContainer.className = 'mb-3';
                    const nameLabel = document.createElement('label');
                    nameLabel.className = 'form-label';
                    nameLabel.textContent = 'Name';
                    nameContainer.appendChild(nameLabel);
                    const nameInput = document.createElement('input');
                    nameInput.type = 'text';
                    nameInput.className = 'form-control';
                    nameInput.name = 'adults[' + i + '].name';
                    nameContainer.appendChild(nameInput);
                    adultContainer.appendChild(nameContainer);
                    const emailContainer = document.createElement('div');
                    emailContainer.className = 'mb-3';
                    const emailLabel = document.createElement('label');
                    emailLabel.className = 'form-label';
                    emailLabel.textContent = 'Email (Optional)';
                    emailContainer.appendChild(emailLabel);
                    const emailInput = document.createElement('input');
                    emailInput.type = 'email';
                    emailInput.className = 'form-control';
                    emailInput.name = 'adults[' + i + '].email';
                    emailContainer.appendChild(emailInput);
                    adultContainer.appendChild(emailContainer);
                    additionalPassengerFieldsContainer.appendChild(adultContainer);
                }

                // Create child forms
                for (let i = 0; i < numChildren; i++) {
                    const childContainer = document.createElement('div');
                    const heading = document.createElement('h2');
                    heading.className = 'mt-3';
                    heading.textContent = 'Child Passenger ' + (i + 1) + ' (Under 12)';
                    childContainer.appendChild(heading);
                    const nameContainer = document.createElement('div');
                    nameContainer.className = 'mb-3';
                    const nameLabel = document.createElement('label');
                    nameLabel.className = 'form-label';
                    nameLabel.textContent = 'Name';
                    nameContainer.appendChild(nameLabel);
                    const nameInput = document.createElement('input');
                    nameInput.type = 'text';
                    nameInput.className = 'form-control';
                    nameInput.name = 'children[' + i + '].name';
                    nameContainer.appendChild(nameInput);
                    childContainer.appendChild(nameContainer);
                    const ageContainer = document.createElement('div');
                    ageContainer.className = 'mb-3';
                    const ageLabel = document.createElement('label');
                    ageLabel.className = 'form-label';
                    ageLabel.textContent = 'Age';
                    ageContainer.appendChild(ageLabel);
                    const ageInput = document.createElement('input');
                    ageInput.type = 'number';
                    ageInput.className = 'form-control';
                    ageInput.name = 'children[' + i + '].age';
                    ageInput.min = '1';
                    ageInput.max = '11';
                    ageContainer.appendChild(ageInput);
                    childContainer.appendChild(ageContainer);
                    additionalPassengerFieldsContainer.appendChild(childContainer);
                }

                updateTotalPrice(); // Initial total price calculation after generating forms
            }

            // Initial call to generate passenger forms based on the values from the search
            generatePassengerForms();
            updateTotalPrice(); // Initial total price calculation

            // Event listener for seat class change
            seatClassSelect.addEventListener('change', updateTotalPrice);
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1><i class="fas fa-ticket-alt me-2"></i>Booking Details</h1>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty flight}">
                <h2>Flight Information</h2>
                <p><strong>Flight Number:</strong> ${flight.flightNumber}</p>
                <p><strong>Departure:</strong> ${flight.departureAirport.location} (${flight.departureAirport.code}) -
                    <fmt:formatDate value="${flight.departureDateTime}" pattern="dd-MM-yyyy HH:mm"/></p>
                <p><strong>Arrival:</strong> ${flight.arrivalAirport.location} (${flight.arrivalAirport.code}) -
                    <fmt:formatDate value="${flight.arrivalDateTime}" pattern="dd-MM-yyyy HH:mm"/></p>
            </c:if>
            <form id="bookingForm" action="${pageContext.request.contextPath}/booking/payment" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="flightId" value="${flight.flightId}">
                <input type="hidden" id="hiddenPrice" name="price" value="0">
                <input type="hidden" id="numberOfAdults" name="numberOfAdults" value="${bookingRequest.numberOfAdults}">
                <input type="hidden" id="numberOfChildren" name="numberOfChildren" value="${bookingRequest.numberOfChildren}">

                <div id="passenger-fields-container">
                    <h2>Passenger 1 (Lead Adult)</h2>
                    <div class="mb-3">
                        <label for="adults[0].name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="adults[0].name" name="adults[0].name">
                        <div id="leadNameError" class="error-message text-danger"></div>
                    </div>
                    <div class="mb-3">
                        <label for="adults[0].email" class="form-label">Email (Optional)</label>
                        <input type="email" class="form-control" id="adults[0].email" name="adults[0].email">
                        <div id="leadEmailError" class="error-message text-danger"></div>
                    </div>
                </div>

                <div id="additional-passenger-fields-container"></div>

                <h2>Booking Options</h2>
                <div class="mb-3">
                    <label for="seatClassId" class="form-label">Seat Class</label>
                    <select class="form-select" id="seatClassId" name="seatClassId" onchange="updateTotalPrice()">
                        <option value="">Select Seat Class</option>
                        <c:forEach items="${seatClasses}" var="seatClass">
                            <option value="${seatClass.seatClassId}" data-seat-price="${seatClass.price}"
                                    ${seatClass.seatClassId == selectedSeatClassId ? 'selected' : ''}>
                                ${seatClass.name}
                            </option>
                        </c:forEach>
                    </select>
                    <div id="seatClassError" class="error-message text-danger"></div>
                </div>

                <h2 class="mt-3">Total Price: <span id="price">0</span></h2>
                <div class="d-flex justify-content-between mt-3">
                    <a href="${pageContext.request.contextPath}/booking/search" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Proceed to Payment</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>