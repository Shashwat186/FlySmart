<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Profile | Flight Reservation</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
  <style>
    /* Glassmorphism with matching color scheme from login page */
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap');
    :root {
      --glass: rgba(39, 84, 138, 0.15);
      --glass-edge: rgba(221, 168, 83, 0.2);
      --text-primary: #F5EEDC;
      --text-secondary: rgba(245, 238, 220, 0.8);
      --blur: 20px;
      --border-radius: 16px;
      --color-primary: #DDA853;
      --color-secondary: #27548A;
      --color-error: #ff4d4d;
    }
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Inter', sans-serif;
    }
    body {
      min-height: 100vh;
      background: linear-gradient(135deg, rgba(24, 59, 78, 0.85), rgba(39, 84, 138, 0.85)),
                  url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
      background-size: cover;
      display: flex;
      justify-content: center;
      align-items: center;
      color: var(--text-primary);
      padding: 20px;
    }
    .container {
      width: 100%;
      max-width: 700px;
      padding: 0 20px;
      position: relative;
    }
    .glass-card {
      background: var(--glass);
      backdrop-filter: blur(var(--blur));
      -webkit-backdrop-filter: blur(var(--blur));
      border-radius: var(--border-radius);
      border: 1px solid var(--glass-edge);
      padding: 40px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    }
    .profile-header {
      text-align: center;
      margin-bottom: 30px;
    }
    .profile-header h2 {
      font-weight: 500;
      font-size: 26px;
      letter-spacing: 0.5px;
    }
    .profile-img {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      object-fit: cover;
      border: 4px solid var(--color-primary);
      margin: 0 auto 30px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      display: block;
    }
    .profile-detail {
      margin-bottom: 20px;
      padding-bottom: 15px;
      border-bottom: 1px solid rgba(245, 238, 220, 0.2);
    }
    .detail-label {
      font-weight: 500;
      color: var(--color-primary);
      margin-bottom: 8px;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 1px;
    }
    .detail-value {
      color: var(--text-primary);
      font-size: 16px;
      padding-left: 5px;
    }
    .back-to-dashboard {
      position: absolute;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
      background: rgba(0, 0, 0, 0.3);
      backdrop-filter: blur(5px);
      -webkit-backdrop-filter: blur(5px);
      border: 1px solid rgba(255, 255, 255, 0.1);
      padding: 10px 15px;
      border-radius: 30px;
      color: var(--text-primary);
      font-size: 14px;
      transition: all 0.3s ease;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 5px;
      z-index: 1000;
    }
    .back-to-dashboard:hover {
      background: rgba(0, 0, 0, 0.5);
      color: var(--color-primary);
    }
    .no-photo {
      display: flex;
      align-items: center;
      justify-content: center;
      background: rgba(245, 238, 220, 0.1);
      color: var(--text-secondary);
      font-size: 3rem;
      width: 150px;
      height: 150px;
      border-radius: 50%;
      border: 4px solid var(--color-primary);
      margin: 0 auto 30px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }
    .alert {
      background: rgba(255, 77, 77, 0.2);
      border: 1px solid var(--color-error);
      color: var(--text-primary);
      padding: 12px;
      border-radius: 10px;
      margin-bottom: 20px;
      text-align: center;
    }
    @media (max-width: 576px) {
      .glass-card {
        padding: 30px 20px;
      }
      .profile-img, .no-photo {
        width: 120px;
        height: 120px;
      }
    }
  </style>
</head>
<body>
  <a href="${pageContext.request.contextPath}/passenger/dashboard" class="back-to-dashboard">
    <i class="bi bi-arrow-left"></i> Back to Dashboard
  </a>
  
  <div class="container">
    <c:if test="${not empty error}">
      <div class="alert">${error}</div>
    </c:if>
    
    <div class="glass-card">
      <div class="profile-header">
        <h2>My Profile</h2>
      </div>
      
      <div class="text-center">
        <c:choose>
          <c:when test="${not empty profilePhotoBase64}">
            <img src="data:image/jpeg;base64,${profilePhotoBase64}"
                 class="profile-img"
                 alt="Profile Image">
          </c:when>
          <c:otherwise>
            <div class="profile-img no-photo">
              <i class="bi bi-person"></i>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
      
      <div class="profile-details">
        <div class="profile-detail">
          <div class="detail-label">Name</div>
          <div class="detail-value"><c:out value="${user.name}" default="Not provided"/></div>
        </div>
        
        <div class="profile-detail">
          <div class="detail-label">Email</div>
          <div class="detail-value"><c:out value="${user.email}" default="Not provided"/></div>
        </div>
        
        <div class="profile-detail">
          <div class="detail-label">Date of Birth</div>
          <div class="detail-value">
            <c:choose>
              <c:when test="${not empty user.dob}">
                <fmt:formatDate value="${user.dob}" pattern="MMMM d, yyyy"/>
              </c:when>
              <c:otherwise>Not provided</c:otherwise>
            </c:choose>
          </div>
        </div>
        
        <c:if test="${not empty user.phone}">
          <div class="profile-detail">
            <div class="detail-label">Phone</div>
            <div class="detail-value"><c:out value="${user.phone}"/></div>
          </div>
        </c:if>
        
        <c:if test="${not empty user.gender}">
          <div class="profile-detail">
            <div class="detail-label">Gender</div>
            <div class="detail-value"><c:out value="${user.gender}"/></div>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</body>
</html>