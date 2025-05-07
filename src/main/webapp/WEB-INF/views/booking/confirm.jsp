<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- jsPDF library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/booking/confirm.css">
    
    <script>
        // Function to generate PDF
        function generatePDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            
            // Add logo/title
            doc.setFontSize(20);
            doc.setTextColor(39, 84, 138);
            doc.text('Flight Booking Confirmation', 105, 20, { align: 'center' });
            
            // Flight Details section
            doc.setFontSize(14);
            doc.setTextColor(0, 0, 0);
            doc.text('Flight Details', 14, 35);
            
            doc.setFontSize(12);
            doc.text(`Flight Number: ${flightNumber}`, 14, 45);
            doc.text(`Airline: ${airlineName} (${airlineCode})`, 14, 55);
            doc.text(`Departure: ${departureAirportName} (${departureAirportCode}) - ${departure_date}`, 14, 65);
            doc.text(`Arrival: ${arrivalAirportName} (${arrivalAirportCode}) - ${Arrival_Date_Time}`, 14, 75);
            doc.text(`Flight Status: ${flightStatus}`, 14, 85);
            
            // Booking Details section
            doc.setFontSize(14);
            doc.text('Booking Details', 14, 100);
            
            doc.setFontSize(12);
            doc.text(`Number of Seats: ${numberOfSeats}`, 14, 110);
            doc.text(`Total Price: ${totalPrice}`, 14, 120);
            doc.text(`Payment Mode: ${paymentMode}`, 14, 130);
            
            // Passenger Details section
            doc.setFontSize(14);
            doc.text('Passenger Details', 14, 145);
            
            const passengers = [
                <c:forEach var="passenger" items="${passengers}" varStatus="loop">
                    ['${passenger.name}', '${passenger.email != null ? passenger.email : "N/A"}' ]<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            
            doc.autoTable({
                startY: 155,
                head: [['Name', 'Email']],
                body: passengers,
                theme: 'grid',
                headStyles: {
                    fillColor: [39, 84, 138],
                    textColor: [255, 255, 255]
                },
                alternateRowStyles: {
                    fillColor: [245, 245, 245]
                }
            });
            
            // Footer
            doc.setFontSize(10);
            doc.setTextColor(100);
            doc.text('Thank you for your booking!', 105, doc.lastAutoTable.finalY + 15, { align: 'center' });
            doc.text('Booking Date: ' + new Date().toLocaleDateString(), 105, doc.lastAutoTable.finalY + 25, { align: 'center' });
            
            // Save the PDF
            doc.save('BookingConfirmation_${flightNumber}.pdf');
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="confirmation-container">
            <h1><i class="fas fa-check-circle me-2"></i>Booking Confirmation</h1>
            
            <div class="section">
                <h2>Flight Details</h2>
                <p><strong>Flight Number:</strong> ${flightNumber}</p>
                <p><strong>Airline:</strong> ${airlineName} (${airlineCode})</p>
                <p><strong>Departure:</strong> ${departureAirportName} (${departureAirportCode}) - ${departure_date}</p>
                <p><strong>Arrival:</strong> ${arrivalAirportName} (${arrivalAirportCode}) - ${Arrival_Date_Time}</p>
                
            </div>
            
            <div class="section">
                <h2>Booking Details</h2>
                <p><strong>Number of Seats:</strong> ${numberOfSeats}</p>
                <p><strong>Total Price:</strong> ${totalPrice}</p>
                <p><strong>Payment Mode:</strong> ${paymentMode}</p>
            </div>
            
            <div class="section">
                <h2>Passenger Details</h2>
                <ul class="list-unstyled">
                    <c:forEach var="passenger" items="${passengers}">
                        <li>
                            <strong>Name:</strong> ${passenger.name}
                            <c:if test="${passenger.email != null}">
                                , <strong>Email:</strong> ${passenger.email}
                            </c:if>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            
            <div class="thank-you">
                <p><i class="fas fa-heart me-1"></i>Thank you for your booking!</p>
            </div>
            
            <div class="d-flex justify-content-between mt-3">
                <a href="${pageContext.request.contextPath}/booking/search" class="btn btn-primary">Book Another Flight</a>
                <button onclick="generatePDF()" class="btn btn-secondary">
                    <i class="fas fa-file-pdf me-1"></i>Download PDF
                </button>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>