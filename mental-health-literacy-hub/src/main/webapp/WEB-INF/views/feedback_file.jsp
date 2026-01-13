<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>File Feedback</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="feedback"/>
  </jsp:include>

  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-7">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="bi bi-chat-left-text"></i> File Feedback</h4>
            <c:if test="${sessionScope.userRole == 'student'}">
              <a href="${pageContext.request.contextPath}/feedback/my-feedback" class="btn btn-light btn-sm">
                <i class="bi bi-chat-dots"></i> View My Feedback
              </a>
            </c:if>
          </div>
          <div class="card-body p-4">
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

            <p class="text-muted mb-4">Share your thoughts, suggestions, or concerns. Your feedback helps us improve the platform.</p>

            <form method="post" action="${pageContext.request.contextPath}/feedback/file">
              <div class="mb-3">
                <label class="form-label fw-semibold">Feedback Message</label>
                <textarea name="message"
                          class="form-control"
                          rows="8"
                          placeholder="Enter your feedback here..."
                          required></textarea>
                <div class="form-text">Please provide detailed feedback to help us serve you better.</div>
              </div>

              <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">
                  <i class="bi bi-send"></i> Submit Feedback
                </button>
                <a href="${pageContext.request.contextPath}/dashboard/" class="btn btn-outline-secondary">
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

