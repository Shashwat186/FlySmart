<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Airlines</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts - Montserrat for headings, Open Sans for body -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/manager/airline-list.css">
</head>
<body>
    <div class="manager-airlines">
        <header class="dashboard-header">
            <div class="container">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
                    <h1 class="mb-3 mb-md-0">
                        <i class="fas fa-user-tie me-2"></i>Flight Manager Dashboard
                    </h1>
                </div>
                
                <nav class="nav justify-content-center mt-3 mt-md-4">
                    <a href="${pageContext.request.contextPath}/manager/dashboard" class="nav-link">
                        <i class="fas fa-tachometer-alt"></i>Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/manager/airports" class="nav-link">
                        <i class="fas fa-map-marked-alt"></i>Airports
                    </a>
                    <a href="${pageContext.request.contextPath}/manager/airlines" class="nav-link active">
                        <i class="fas fa-building"></i>Airlines
                    </a>
                    <a href="${pageContext.request.contextPath}/manager/flights" class="nav-link">
                        <i class="fas fa-plane"></i>Flights
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/change-password" class="nav-link">
                        <i class="fas fa-key"></i>Change Password
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link">
                        <i class="fas fa-sign-out-alt"></i>Logout
                    </a>
                    <span class="user-badge">
                        <i class="fas fa-user me-2"></i>${user.name}
                    </span>
                </nav>
            </div>
        </header>

        <main class="dashboard-content">
            <div class="container-fluid">
                <div class="activity-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="h4 mb-0">
                            <i class="fas fa-building me-2"></i>Manage Airlines
                        </h2>
                        <div class="input-group" style="max-width: 300px;">
                            <input type="text" id="airlineSearch" class="form-control" placeholder="Search by Name or Code">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                        </div>
                    </div>
                    
                    <div class="airlines-table-container">
                        <table class="table airlines-table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-building me-2"></i>Name</th>
                                    <th><i class="fas fa-code me-2"></i>Code</th>
                                    <th><i class="fas fa-phone me-2"></i>Contact Info</th>
                                    <th><i class="fas fa-cogs me-2"></i>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="airlinesTableBody">
                                <c:choose>
                                    <c:when test="${not empty airlines}">
                                        <c:forEach items="${airlines}" var="airline">
                                            <tr>
                                                <td>${airline.name}</td>
                                                <td>${airline.code}</td>
                                                <td>${airline.contactInfo}</td>
                                                <td>
                                                    <div class="actions-box">
                                                        <a href="${pageContext.request.contextPath}/manager/airlines/edit/${airline.airlineId}" 
                                                           class="btn btn-action btn-edit" title="Edit">
                                                            <i class="fas fa-edit me-1"></i>Edit
                                                        </a>
                                                        <%-- <button onclick="showDeleteConfirm('${pageContext.request.contextPath}/manager/airlines/delete/${airline.airlineId}')" 
                                                                class="btn btn-action btn-delete" title="Delete">
                                                            <i class="fas fa-trash me-1"></i>Delete
                                                        </button>--%>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" class="text-center py-4">No airlines to display</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Delete Confirmation Modal (for potential uncommenting) -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h5>Confirm Deletion</h5>
                <span class="modal-close">×</span>
            </div>
            <div class="modal-body">
                <p><i class="fas fa-exclamation-triangle me-2"></i>Are you sure you want to delete this airline? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-modal btn-cancel">Cancel</button>
                <button id="confirmDeleteBtn" class="btn btn-modal btn-confirm">Delete</button>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // JavaScript for delete confirmation (for potential uncommenting)
        function confirmDelete(url, entity) {
            const confirmation = confirm(`Are you sure you want to delete this ${entity}?`);
            if (confirmation) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = url;
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Modal logic (for potential uncommenting)
        const modal = document.getElementById('deleteModal');
        const closeModal = document.querySelector('.modal-close');
        const cancelBtn = document.querySelector('.btn-cancel');
        const confirmBtn = document.getElementById('confirmDeleteBtn');

        function showDeleteConfirm(url) {
            modal.style.display = 'flex';
            confirmBtn.onclick = function() {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = url;
                document.body.appendChild(form);
                form.submit();
            };
        }

        if (closeModal) {
            closeModal.onclick = function() {
                modal.style.display = 'none';
            };
        }

        if (cancelBtn) {
            cancelBtn.onclick = function() {
                modal.style.display = 'none';
            };
        }

        window.onclick = function(event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };

        // Dynamic search functionality
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('airlineSearch');
            const tableBody = document.getElementById('airlinesTableBody');

            searchInput.addEventListener('input', function() {
                const searchValue = this.value.trim().toLowerCase();
                const rows = tableBody.querySelectorAll('tr:not(.text-center)'); // Exclude "No airlines" row

                rows.forEach(row => {
                    const name = row.cells[0].textContent.toLowerCase();
                    const code = row.cells[1].textContent.toLowerCase();

                    if (searchValue === '' || name.startsWith(searchValue) || code.startsWith(searchValue)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>
