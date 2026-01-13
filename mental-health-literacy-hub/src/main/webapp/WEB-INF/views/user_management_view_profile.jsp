<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Profile</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="profile"/>
  </jsp:include>

  <div class="container py-5 fade-in">
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-6">
        <div class="card">
          <div class="card-header">
            <h4 class="mb-0"><i class="bi bi-person-circle me-2"></i> My Profile</h4>
          </div>
          <div class="card-body p-4">
            <div class="mb-4 text-center fade-in">
              <c:choose>
                <c:when test="${user.profilePicture != null && !user.profilePicture.isEmpty()}">
                  <img src="${pageContext.request.contextPath}/uploads/profile-pictures/${user.profilePicture}" 
                       alt="Profile Picture" 
                       class="profile-picture">
                </c:when>
                <c:otherwise>
                  <div class="profile-picture d-inline-flex align-items-center justify-content-center bg-light border-4" style="border-color: #667eea;">
                    <i class="bi bi-person-circle" style="font-size: 5rem; color: #9ca3af;"></i>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>

            <div class="mb-4">
              <label class="form-label">Full Name</label>
              <div class="card bg-light border-0 p-3">
                <div class="fw-semibold" style="color: #1f2937; font-size: 1.1rem;">${user.name}</div>
              </div>
            </div>

            <div class="mb-4">
              <label class="form-label">Email</label>
              <div class="card bg-light border-0 p-3">
                <div class="fw-semibold" style="color: #1f2937; font-size: 1.1rem;">${user.email}</div>
              </div>
            </div>

            <div class="mb-4">
              <label class="form-label">Role</label>
              <div class="card bg-light border-0 p-3">
                <span class="badge bg-primary" style="font-size: 1rem; padding: 0.5rem 1rem; text-transform: capitalize;">${user.role}</span>
              </div>
            </div>

            <div class="d-grid gap-2 mt-4">
              <a href="${pageContext.request.contextPath}/user-management/profile/edit" class="btn btn-primary">
                <i class="bi bi-pencil-square"></i> Edit Profile
              </a>
              <a href="${pageContext.request.contextPath}/user-management/profile/change-password" class="btn btn-outline-secondary">
                <i class="bi bi-key"></i> Change Password
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

