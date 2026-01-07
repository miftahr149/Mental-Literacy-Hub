<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Log In</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
<div class="container py-5">
  <jsp:include page="/component/auth_header.jsp"/>
  <div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
      <div class="card shadow-sm border-0">
        <div class="card-body p-4">
          <h2 class="fw-bold mb-1 text-center">Welcome back</h2>
          <p class="text-muted mb-4 text-center">Log in to access your mental health hub</p>

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

          <form method="post" action="${pageContext.request.contextPath}/auth/login">
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
              <label class="form-label fw-semibold">Password</label>
              <input type="password"
                     name="password"
                     class="form-control"
                     placeholder="Enter your password"
                     required>
            </div>

            <div class="d-flex justify-content-between align-items-center mb-3">
              <a href="${pageContext.request.contextPath}/auth/reset-password" class="small">Forgot password?</a>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2">
              Log In
            </button>
          </form>

          <p class="text-center mt-3 mb-0">
            <span class="text-muted">Don't have an account?</span>
            <a href="${pageContext.request.contextPath}/auth/register">Register</a>
          </p>

          <hr class="my-4">
          <p class="text-center text-muted small mb-0">
            Demo accounts:<br>
            student@example.com / password<br>
            mhp@example.com / password<br>
            admin@example.com / password
          </p>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>


