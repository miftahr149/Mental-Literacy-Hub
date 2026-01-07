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

  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-6">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-primary text-white">
            <h4 class="mb-0"><i class="bi bi-person-circle"></i> My Profile</h4>
          </div>
          <div class="card-body p-4">
            <div class="mb-4 text-center">
              <i class="bi bi-person-circle" style="font-size: 4rem; color: #6c757d;"></i>
            </div>

            <div class="mb-3">
              <label class="form-label fw-semibold text-muted">Full Name</label>
              <div class="form-control-plaintext border-bottom pb-2">${user.name}</div>
            </div>

            <div class="mb-3">
              <label class="form-label fw-semibold text-muted">Email</label>
              <div class="form-control-plaintext border-bottom pb-2">${user.email}</div>
            </div>

            <div class="mb-3">
              <label class="form-label fw-semibold text-muted">Role</label>
              <div class="form-control-plaintext border-bottom pb-2">
                <span class="badge bg-info">${user.role}</span>
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

