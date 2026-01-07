<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- User Management Module Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/mental-health-challenge/">
      <i class="bi bi-heart-pulse"></i> Mental Health Hub
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <div class="navbar-nav ms-auto">
        <a class="nav-link" href="${pageContext.request.contextPath}/mental-health-challenge/">
          <i class="bi bi-house"></i> Home
        </a>
        <c:choose>
          <c:when test="${param.activePage == 'profile'}">
            <a class="nav-link active" href="${pageContext.request.contextPath}/user-management/profile">
              <i class="bi bi-person-circle"></i> Profile
            </a>
          </c:when>
          <c:otherwise>
            <a class="nav-link" href="${pageContext.request.contextPath}/user-management/profile">
              <i class="bi bi-person-circle"></i> Profile
            </a>
          </c:otherwise>
        </c:choose>
        <c:if test="${sessionScope.userRole == 'admin'}">
          <c:choose>
            <c:when test="${param.activePage == 'users'}">
              <a class="nav-link active" href="${pageContext.request.contextPath}/user-management/admin/users">
                <i class="bi bi-people"></i> Manage Users
              </a>
            </c:when>
            <c:otherwise>
              <a class="nav-link" href="${pageContext.request.contextPath}/user-management/admin/users">
                <i class="bi bi-people"></i> Manage Users
              </a>
            </c:otherwise>
          </c:choose>
        </c:if>
        <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">
          <i class="bi bi-box-arrow-right"></i> Logout
        </a>
      </div>
    </div>
  </div>
</nav>

