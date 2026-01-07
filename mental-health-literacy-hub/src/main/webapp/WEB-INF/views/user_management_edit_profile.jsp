<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Profile</title>
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
            <h4 class="mb-0"><i class="bi bi-pencil-square"></i> Edit Profile</h4>
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

            <form method="post" action="${pageContext.request.contextPath}/user-management/profile/edit">
              <div class="mb-3">
                <label class="form-label fw-semibold">Full Name</label>
                <input type="text"
                       name="name"
                       class="form-control"
                       placeholder="Enter your full name"
                       value="${user.name}"
                       required>
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">Email</label>
                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="you@example.com"
                       value="${user.email}"
                       required>
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">Role</label>
                <input type="text"
                       class="form-control"
                       value="${user.role}"
                       disabled>
                <small class="text-muted">Role cannot be changed</small>
              </div>

              <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-primary">
                  <i class="bi bi-check-circle"></i> Save Changes
                </button>
                <a href="${pageContext.request.contextPath}/user-management/profile" class="btn btn-outline-secondary">
                  <i class="bi bi-arrow-left"></i> Cancel
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

