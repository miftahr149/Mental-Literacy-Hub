<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Log In - Mental Health Hub</title>
  <jsp:include page="/component/common_head.jsp"/>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      position: relative;
      overflow-x: hidden;
    }

    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: 
        radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
        radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
      pointer-events: none;
    }

    .login-container {
      width: 100%;
      max-width: 480px;
      position: relative;
      z-index: 1;
      animation: fadeInUp 0.6s ease-out;
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .login-header {
      text-align: center;
      margin-bottom: 2.5rem;
      color: white;
    }

    .login-header h1 {
      font-size: 2.5rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
      text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.75rem;
    }

    .login-header h1 i {
      font-size: 2.25rem;
      background: rgba(255, 255, 255, 0.2);
      padding: 0.75rem;
      border-radius: 16px;
      backdrop-filter: blur(10px);
    }

    .login-header p {
      font-size: 1rem;
      opacity: 0.95;
      font-weight: 300;
      letter-spacing: 0.3px;
    }

    .login-card {
      background: rgba(255, 255, 255, 0.98);
      border-radius: 24px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      padding: 3rem;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.3);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .login-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 25px 70px rgba(0, 0, 0, 0.35);
    }

    .welcome-text h2 {
      font-size: 1.75rem;
      font-weight: 700;
      color: #2d3748;
      margin-bottom: 0.5rem;
      text-align: center;
    }

    .welcome-text p {
      color: #718096;
      text-align: center;
      margin-bottom: 2rem;
      font-size: 0.95rem;
    }

    .alert {
      border-radius: 12px;
      border: none;
      padding: 1rem 1.25rem;
      margin-bottom: 1.5rem;
      font-size: 0.9rem;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      animation: slideDown 0.3s ease-out;
    }

    @keyframes slideDown {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .alert-danger {
      background: linear-gradient(135deg, #fee 0%, #fdd 100%);
      color: #c53030;
    }

    .alert-success {
      background: linear-gradient(135deg, #f0fff4 0%, #e6ffed 100%);
      color: #22543d;
    }

    .form-label {
      font-weight: 600;
      color: #2d3748;
      margin-bottom: 0.5rem;
      font-size: 0.9rem;
      display: block;
    }

    .form-control,
    .form-select {
      border: 2px solid #e2e8f0;
      border-radius: 12px;
      padding: 0.875rem 1.125rem;
      font-size: 0.95rem;
      transition: all 0.3s ease;
      background-color: #fff;
    }

    .form-control:focus,
    .form-select:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
      outline: none;
      background-color: #fff;
    }

    .form-control::placeholder {
      color: #a0aec0;
    }

    .mb-3 {
      margin-bottom: 1.5rem;
    }

    .forgot-password-link {
      color: #667eea;
      text-decoration: none;
      font-size: 0.875rem;
      font-weight: 500;
      transition: color 0.2s ease;
    }

    .forgot-password-link:hover {
      color: #764ba2;
      text-decoration: underline;
    }

    .btn-login {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border: none;
      border-radius: 12px;
      padding: 0.875rem 2rem;
      font-size: 1rem;
      font-weight: 600;
      color: white;
      width: 100%;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
      position: relative;
      overflow: hidden;
    }

    .btn-login::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s;
    }

    .btn-login:hover::before {
      left: 100%;
    }

    .btn-login:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
    }

    .btn-login:active {
      transform: translateY(0);
    }

    .register-link-container {
      text-align: center;
      margin-top: 2rem;
      padding-top: 1.5rem;
      border-top: 1px solid #e2e8f0;
    }

    .register-link-container p {
      color: #718096;
      font-size: 0.9rem;
      margin: 0;
    }

    .register-link {
      color: #667eea;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.2s ease;
      margin-left: 0.25rem;
    }

    .register-link:hover {
      color: #764ba2;
      text-decoration: underline;
    }

    @media (max-width: 576px) {
      .login-card {
        padding: 2rem 1.5rem;
      }

      .login-header h1 {
        font-size: 2rem;
      }

      .welcome-text h2 {
        font-size: 1.5rem;
      }
    }

    .input-icon-wrapper {
      position: relative;
    }

    .input-icon-wrapper i {
      position: absolute;
      left: 1rem;
      top: 50%;
      transform: translateY(-50%);
      color: #a0aec0;
      font-size: 1.1rem;
      pointer-events: none;
    }

    .input-icon-wrapper .form-control,
    .input-icon-wrapper .form-select {
      padding-left: 2.75rem;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <div class="login-header">
      <h1>
        <i class="bi bi-shield-lock"></i>
        Mental Health Hub
      </h1>
      <p>Secure access to your mental health resources</p>
    </div>

    <div class="login-card">
      <div class="welcome-text">
        <h2>Welcome back</h2>
        <p>Log in to access your mental health hub</p>
      </div>

      <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
        </div>
      </c:if>
      <c:if test="${not empty success}">
        <div class="alert alert-success" role="alert">
          <i class="bi bi-check-circle-fill me-2"></i>${success}
        </div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/auth/login">
        <div class="mb-3">
          <label class="form-label">
            <i class="bi bi-person-badge me-1"></i>Role
          </label>
          <div class="input-icon-wrapper">
            <i class="bi bi-person-badge"></i>
            <select name="role" class="form-select" required>
              <option value="">Select your role</option>
              <option value="student" <c:if test="${role == 'student'}">selected</c:if>>Student</option>
              <option value="mhp" <c:if test="${role == 'mhp'}">selected</c:if>>Mental Health Professional</option>
              <option value="admin" <c:if test="${role == 'admin'}">selected</c:if>>Admin</option>
            </select>
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label">
            <i class="bi bi-envelope me-1"></i>Email
          </label>
          <div class="input-icon-wrapper">
            <i class="bi bi-envelope"></i>
            <input type="email"
                   name="email"
                   class="form-control"
                   placeholder="you@example.com"
                   value="${email}"
                   required>
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label">
            <i class="bi bi-lock me-1"></i>Password
          </label>
          <div class="input-icon-wrapper">
            <i class="bi bi-lock"></i>
            <input type="password"
                   name="password"
                   class="form-control"
                   placeholder="Enter your password"
                   required>
          </div>
        </div>

        <div class="d-flex justify-content-end align-items-center mb-4">
          <a href="${pageContext.request.contextPath}/auth/reset-password" class="forgot-password-link">
            <i class="bi bi-key me-1"></i>Forgot password?
          </a>
        </div>

        <button type="submit" class="btn btn-login">
          <i class="bi bi-box-arrow-in-right me-2"></i>Log In
        </button>
      </form>

      <div class="register-link-container">
        <p>
          Don't have an account?
          <a href="${pageContext.request.contextPath}/auth/register" class="register-link">Register</a>
        </p>
      </div>
    </div>
  </div>
</body>
</html>


