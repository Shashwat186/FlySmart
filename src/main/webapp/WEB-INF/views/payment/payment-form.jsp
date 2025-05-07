<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Form</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<div class="container">
    <h1>Payment Details</h1>
    <form action="${pageContext.request.contextPath}/payment/process" method="post">
        <div class="form-group">
            <label for="cardNumber">Card Number:</label>
            <input type="text" id="cardNumber" name="cardNumber" required class="form-control">
        </div>
        
        <div class="form-group">
            <label for="cardHolderName">Card Holder Name:</label>
            <input type="text" id="cardHolderName" name="cardHolderName" required class="form-control">
        </div>
        
        <div class="form-group">
            <label for="expiryDate">Expiry Date:</label>
            <input type="date" id="expiryDate" name="expiryDate" required class="form-control">
        </div>
        
        <div class="form-group">
            <label for="paymentMode">Payment Mode:</label>
            <select id="paymentMode" name="paymentMode" required class="form-control">
                <option value="CREDIT">Credit Card</option>
                <option value="DEBIT">Debit Card</option>
                <option value="UPI">UPI</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" required class="form-control">
        </div>
        
        <button type="submit" class="btn btn-primary">Submit Payment</button>
    </form>
    
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
</div>
</body>
</html>