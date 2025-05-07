<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header">
    <h1>Flight Reservation System</h1>
    <div class="user-info">
Welcome, ${user.name} (${user.role})
        <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
    </div>
</div>