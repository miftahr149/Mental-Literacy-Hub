<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Reset Password</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
<div class="container py-5">
  <jsp:include page="/component/auth_header.jsp"/>
  <div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
      <div class="card shadow-sm border-0">
        <div class="card-body p-4">
          <h2 class="fw-bold mb-1 text-center">Reset your password</h2>
          <p class="text-muted mb-4 text-center">Enter your email and a new password</p>

          <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
              ${error}
            </div>
          </c:if>
          <c:if test="${not empty success}">
            <div class="alert alert-success" role="alert">
              ${success}
            </div>
          </c:if>

          <form method="post" action="${pageContext.request.contextPath}/auth/reset-password">
            <div class="mb-3">
              <label class="form-label fw-semibold">Email</label>
              <input type="email"
                     name="email"
                     class="form-control"
                     placeholder="you@example.com"
                     value="${email}"
                     required>
            </div>

            <div class="mb-3">
              <label class="form-label fw-semibold">New password</label>
              <input type="password"
                     name="newPassword"
                     class="form-control"
                     placeholder="Create a new password"
                     required>
            </div>

            <div class="mb-3">
              <label class="form-label fw-semibold">Confirm new password</label>
              <input type="password"
                     name="confirmPassword"
                     class="form-control"
                     placeholder="Re-enter new password"
                     required>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2">
              Reset Password
            </button>
          </form>

          <p class="text-center mt-3 mb-0">
            <a href="${pageContext.request.contextPath}/auth/login">Back to login</a>
          </p>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>


