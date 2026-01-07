<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Change Password</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="profile"/>
  </jsp:include>

  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-6">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-primary text-white">
            <h4 class="mb-0"><i class="bi bi-key"></i> Change Password</h4>
          </div>
          <div class="card-body p-4">
            <c:if test="${not empty error}">
              <div class="alert alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle"></i> ${error}
              </div>
            </c:if>
            <c:if test="${not empty success}">
              <div class="alert alert-success" role="alert">
                <i class="bi bi-check-circle"></i> ${success}
              </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/user-management/profile/change-password">
              <div class="mb-3">
                <label class="form-label fw-semibold">Current Password</label>
                <input type="password"
                       name="currentPassword"
                       class="form-control"
                       placeholder="Enter your current password"
                       required>
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">New Password</label>
                <input type="password"
                       name="newPassword"
                       class="form-control"
                       placeholder="Enter new password (min. 6 characters)"
                       required>
                <small class="text-muted">Password must be at least 6 characters long</small>
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">Confirm New Password</label>
                <input type="password"
                       name="confirmPassword"
                       class="form-control"
                       placeholder="Re-enter new password"
                       required>
              </div>

              <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-primary">
                  <i class="bi bi-check-circle"></i> Change Password
                </button>
                <a href="${pageContext.request.contextPath}/user-management/profile" class="btn btn-outline-secondary">
                  <i class="bi bi-arrow-left"></i> Back to Profile
                </a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

