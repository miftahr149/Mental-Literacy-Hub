<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
<div class="container py-5">
  <jsp:include page="/component/auth_header.jsp"/>
  <div class="row justify-content-center">
    <div class="col-md-7 col-lg-6">
      <div class="card shadow-sm border-0">
        <div class="card-body p-4">
          <h2 class="fw-bold mb-1 text-center">Create your account</h2>
          <p class="text-muted mb-4 text-center">Register as a student, mental health professional or admin</p>

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

          <form method="post" action="${pageContext.request.contextPath}/auth/register">
            <div class="mb-3">
              <label class="form-label fw-semibold">Full name</label>
              <input type="text"
                     name="name"
                     class="form-control"
                     placeholder="e.g., Alex Tan"
                     value="${name}"
                     required>
            </div>

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
              <label class="form-label fw-semibold">Role</label>
              <select name="role" class="form-select" required>
                <option value="">Select your role</option>
                <option value="student" <c:if test="${role == 'student'}">selected</c:if>>Student</option>
                <option value="mhp" <c:if test="${role == 'mhp'}">selected</c:if>>Mental Health Professional</option>
                <option value="admin" <c:if test="${role == 'admin'}">selected</c:if>>Admin</option>
              </select>
            </div>

            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-semibold">Password</label>
                  <input type="password"
                         name="password"
                         class="form-control"
                         placeholder="Create a password"
                         required>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label class="form-label fw-semibold">Confirm password</label>
                  <input type="password"
                         name="confirmPassword"
                         class="form-control"
                         placeholder="Re-enter password"
                         required>
                </div>
              </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2">
              Register
            </button>
          </form>

          <p class="text-center mt-3 mb-0">
            <span class="text-muted">Already have an account?</span>
            <a href="${pageContext.request.contextPath}/auth/login">Log in</a>
          </p>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>


