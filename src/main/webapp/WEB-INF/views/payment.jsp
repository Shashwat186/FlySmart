<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment Details</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/booking/payment.css">

<script>
// Make sure DOM is fully loaded before attaching event handlers
document.addEventListener('DOMContentLoaded', function() {
    // Add initial call to showPaymentFields() to handle any pre-selected values
    showPaymentFields();
    
    // Add event listener to the payment mode select
    const paymentModeSelect = document.getElementById('paymentMode');
    if (paymentModeSelect) {
        paymentModeSelect.addEventListener('change', showPaymentFields);
    }
});

function showPaymentFields() {
    console.log("showPaymentFields called"); // Debug log
    const paymentMode = document.getElementById('paymentMode').value;
    console.log("Payment mode:", paymentMode); // Debug log
    
    const cardDetails = document.getElementById('cardDetails');
    const upiDetails = document.getElementById('upiDetails');
    
    // Hide all sections first
    if (cardDetails) cardDetails.style.display = 'none';
    if (upiDetails) upiDetails.style.display = 'none';
    
    // Show the appropriate section based on payment mode
    if (paymentMode === 'Credit Card' || paymentMode === 'Debit Card') {
        if (cardDetails) {
            cardDetails.style.display = 'block';
            console.log("Card details shown"); // Debug log
        } else {
            console.error("cardDetails element not found!"); // Debug log
        }
    } else if (paymentMode === 'UPI') {
        if (upiDetails) upiDetails.style.display = 'block';
    }
}

// Format card number as user types
function formatCardNumber(input) {
    // Remove all non-digit characters
    let value = input.value.replace(/\D/g, '');
    
    // Truncate if longer than 16 digits
    if (value.length > 16) {
        value = value.substring(0, 16);
    }
    
    // Add spaces after every 4 digits
    let formatted = '';
    for (let i = 0; i < value.length; i++) {
        if (i > 0 && i % 4 === 0) {
            formatted += ' ';
        }
        formatted += value[i];
    }
    
    input.value = formatted;
}

function validateForm() {
    let valid = true;

    // Get input elements and error containers
    const paymentModeSelect = document.getElementById('paymentMode');
    const cardNumberInput = document.getElementById('cardNumber');
    const cardHolderNameInput = document.getElementById('cardHolderName');
    const expiryDateInput = document.getElementById('expiryDate');
    const upiIdInput = document.getElementById('upiId');
    const paymentModeError = document.getElementById('paymentModeError');
    const cardNumberError = document.getElementById('cardNumberError');
    const cardHolderNameError = document.getElementById('cardHolderNameError');
    const expiryDateError = document.getElementById('expiryDateError');
    const upiIdError = document.getElementById('upiIdError');

    // Reset error messages
    if (paymentModeError) paymentModeError.textContent = '';
    if (cardNumberError) cardNumberError.textContent = '';
    if (cardHolderNameError) cardHolderNameError.textContent = '';
    if (expiryDateError) expiryDateError.textContent = '';
    if (upiIdError) upiIdError.textContent = '';

    // Validate Payment Mode
    if (!paymentModeSelect.value) {
        if (paymentModeError) paymentModeError.textContent = 'Please select a payment mode!';
        valid = false;
    }

    // Validate Card Details if Credit/Debit Card is selected
    if (paymentModeSelect.value === 'Credit Card' || paymentModeSelect.value === 'Debit Card') {
        // Card Number (enhanced validation for 16 digits)
        const cardNumberValue = cardNumberInput.value.replace(/\s/g, ''); // Remove spaces
        if (!cardNumberValue) {
            if (cardNumberError) cardNumberError.textContent = 'Card number is required!';
            valid = false;
        } else if (!/^\d{16}$/.test(cardNumberValue)) {
            if (cardNumberError) cardNumberError.textContent = 'Please enter a valid 16-digit card number!';
            valid = false;
        }

        // Card Holder Name
        if (!cardHolderNameInput.value.trim()) {
            if (cardHolderNameError) cardHolderNameError.textContent = 'Card holder name is required!';
            valid = false;
        } else if (cardHolderNameInput.value.length > 100) {
            if (cardHolderNameError) cardHolderNameError.textContent = 'Name cannot exceed 100 characters!';
            valid = false;
        }

        // Expiry Date (enhanced validation)
        const expiryDateRegex = /^(0[1-9]|1[0-2])\/[0-9]{2}$/;
        if (!expiryDateInput.value.trim()) {
            if (expiryDateError) expiryDateError.textContent = 'Expiry date is required!';
            valid = false;
        } else if (!expiryDateRegex.test(expiryDateInput.value)) {
            if (expiryDateError) expiryDateError.textContent = 'Please enter a valid expiry date (MM/YY)!';
            valid = false;
        } else {
            // Check if card is expired
            const [month, year] = expiryDateInput.value.split('/');
            const expiryMonth = parseInt(month, 10);
            const expiryYear = parseInt(year, 10) + 2000; // Convert YY to full year
            
            const now = new Date();
            const currentMonth = now.getMonth() + 1; // getMonth() is 0-indexed
            const currentYear = now.getFullYear();
            
            if (expiryYear < currentYear || 
                (expiryYear === currentYear && expiryMonth < currentMonth)) {
                if (expiryDateError) expiryDateError.textContent = 'Card has expired!';
                valid = false;
            }
        }
    }

    // Validate UPI Details if UPI is selected
    if (paymentModeSelect.value === 'UPI') {
        const upiRegex = /^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$/;
        if (!upiIdInput.value.trim()) {
            if (upiIdError) upiIdError.textContent = 'UPI ID is required!';
            valid = false;
        } else if (!upiRegex.test(upiIdInput.value)) {
            if (upiIdError) upiIdError.textContent = 'Please enter a valid UPI ID (e.g., name@bank)!';
            valid = false;
        }
    }

    return valid;
}
</script>
</head>
<body>
<div class="container">
<div class="form-container">
<h1><i class="fas fa-credit-card me-2"></i>Payment Details</h1>
<form action="${pageContext.request.contextPath}/booking/processPayment" method="post" onsubmit="return validateForm()">
<div class="mb-3">
<label for="paymentMode" class="form-label">Payment Mode</label>
<select class="form-select" id="paymentMode" name="paymentMode">
<option value="">Select Payment Mode</option>
<option value="Credit Card">Credit Card</option>
<option value="Debit Card">Debit Card</option>
<option value="UPI">UPI</option>
</select>
<div id="paymentModeError" class="error-message text-danger"></div>
</div>

<div id="cardDetails" style="display: none;">
<h2>Card Details</h2>
<div class="mb-3">
<label for="cardNumber" class="form-label">Card Number</label>
<input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="Enter Card Number" maxlength="19" oninput="formatCardNumber(this)">
<div id="cardNumberError" class="error-message text-danger"></div>
</div>
<div class="mb-3">
<label for="cardHolderName" class="form-label">Card Holder Name</label>
<input type="text" class="form-control" id="cardHolderName" name="cardHolderName" placeholder="Enter Card Holder Name">
<div id="cardHolderNameError" class="error-message text-danger"></div>
</div>
<div class="mb-3">
<label for="expiryDate" class="form-label">Expiry Date (MM/YY)</label>
<input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" maxlength="5">
<div id="expiryDateError" class="error-message text-danger"></div>
</div>
</div>

<div id="upiDetails" style="display: none;">
<h2>UPI Details</h2>
<div class="mb-3">
<label for="upiId" class="form-label">UPI ID</label>
<input type="text" class="form-control" id="upiId" name="upiId" placeholder="Enter UPI ID">
<div id="upiIdError" class="error-message text-danger"></div>
</div>
</div>

<div class="d-flex justify-content-between">
<button type="submit" class="btn btn-primary">Complete Booking</button>
</div>
</form>
</div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>