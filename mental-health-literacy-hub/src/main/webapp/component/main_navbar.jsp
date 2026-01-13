<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Main Navigation Bar for All Pages -->
<nav class="navbar navbar-expand-lg navbar-light">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard/">
      <i class="bi bi-heart-pulse"></i> Mental Health Hub
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <c:choose>
            <c:when test="${param.activePage == 'dashboard'}">
              <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard/">
                <i class="bi bi-house"></i> Dashboard
              </a>
            </c:when>
            <c:otherwise>
              <a class="nav-link" href="${pageContext.request.contextPath}/dashboard/">
                <i class="bi bi-house"></i> Dashboard
              </a>
            </c:otherwise>
          </c:choose>
        </li>
        <li class="nav-item">
          <c:choose>
            <c:when test="${param.activePage == 'challenges'}">
              <a class="nav-link active" href="${pageContext.request.contextPath}/mental-health-challenge/">
                <i class="bi bi-list-task"></i> Challenges
              </a>
            </c:when>
            <c:otherwise>
              <a class="nav-link" href="${pageContext.request.contextPath}/mental-health-challenge/">
                <i class="bi bi-list-task"></i> Challenges
              </a>
            </c:otherwise>
          </c:choose>
        </li>
        <li class="nav-item">
          <c:choose>
            <c:when test="${param.activePage == 'analytics'}">
              <a class="nav-link active" href="${pageContext.request.contextPath}/analytics/">
                <i class="bi bi-graph-up-arrow"></i> Analytics
              </a>
            </c:when>
            <c:otherwise>
              <a class="nav-link" href="${pageContext.request.contextPath}/analytics/">
                <i class="bi bi-graph-up-arrow"></i> Analytics
              </a>
            </c:otherwise>
          </c:choose>
        </li>
        <li class="nav-item">
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
        </li>
        <c:if test="${sessionScope.userRole == 'student' || sessionScope.userRole == 'mhp'}">
          <li class="nav-item">
            <c:choose>
              <c:when test="${param.activePage == 'feedback'}">
                <a class="nav-link active" href="${pageContext.request.contextPath}/feedback/file">
                  <i class="bi bi-chat-left-text"></i> Feedback
                </a>
              </c:when>
              <c:otherwise>
                <a class="nav-link" href="${pageContext.request.contextPath}/feedback/file">
                  <i class="bi bi-chat-left-text"></i> Feedback
                </a>
              </c:otherwise>
            </c:choose>
          </li>
        </c:if>
        <c:if test="${sessionScope.userRole == 'mhp'}">
          <li class="nav-item">
            <c:choose>
              <c:when test="${param.activePage == 'feedback'}">
                <a class="nav-link active" href="${pageContext.request.contextPath}/feedback/view">
                  <i class="bi bi-eye"></i> View Student Feedback
                </a>
              </c:when>
              <c:otherwise>
                <a class="nav-link" href="${pageContext.request.contextPath}/feedback/view">
                  <i class="bi bi-eye"></i> View Student Feedback
                </a>
              </c:otherwise>
            </c:choose>
          </li>
        </c:if>
        <c:if test="${sessionScope.userRole == 'admin'}">
          <li class="nav-item">
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
          </li>
          <li class="nav-item">
            <c:choose>
              <c:when test="${param.activePage == 'feedback'}">
                <a class="nav-link active" href="${pageContext.request.contextPath}/feedback/admin">
                  <i class="bi bi-chat-left-text"></i> Manage Feedback
                </a>
              </c:when>
              <c:otherwise>
                <a class="nav-link" href="${pageContext.request.contextPath}/feedback/admin">
                  <i class="bi bi-chat-left-text"></i> Manage Feedback
                </a>
              </c:otherwise>
            </c:choose>
          </li>
        </c:if>
      </ul>
      <ul class="navbar-nav">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="bi bi-person-circle"></i> ${sessionScope.username}
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user-management/profile">
              <i class="bi bi-person"></i> View Profile
            </a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user-management/profile/edit">
              <i class="bi bi-pencil-square"></i> Edit Profile
            </a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user-management/profile/change-password">
              <i class="bi bi-key"></i> Change Password
            </a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">
              <i class="bi bi-box-arrow-right"></i> Logout
            </a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>





