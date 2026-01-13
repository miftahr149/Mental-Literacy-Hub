<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Feedback</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="feedback"/>
  </jsp:include>

  <div class="container py-5">
    <div class="row">
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="bi bi-chat-left-text"></i> My Feedback</h4>
            <a href="${pageContext.request.contextPath}/feedback/file" class="btn btn-light btn-sm">
              <i class="bi bi-plus-circle"></i> Submit New Feedback
            </a>
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

            <c:choose>
              <c:when test="${empty feedbacks}">
                <div class="text-center py-5">
                  <i class="bi bi-inbox" style="font-size: 3rem; color: #ccc;"></i>
                  <p class="text-muted mt-3">You haven't submitted any feedback yet.</p>
                  <a href="${pageContext.request.contextPath}/feedback/file" class="btn btn-primary mt-3">
                    <i class="bi bi-plus-circle"></i> Submit Your First Feedback
                  </a>
                </div>
              </c:when>
              <c:otherwise>
                <c:forEach var="feedback" items="${feedbacks}">
                  <div class="card mb-3">
                    <div class="card-header d-flex justify-content-between align-items-center">
                      <div>
                        <strong>Feedback #${feedback.id}</strong>
                        <span class="badge ms-2
                          <c:choose>
                            <c:when test="${feedback.status == 'pending'}">bg-secondary</c:when>
                            <c:when test="${feedback.status == 'in-review'}">bg-warning</c:when>
                            <c:when test="${feedback.status == 'responded'}">bg-success</c:when>
                            <c:otherwise>bg-secondary</c:otherwise>
                          </c:choose>">
                          ${feedback.status}
                        </span>
                      </div>
                      <small class="text-muted">${feedback.createdAtFormatted}</small>
                    </div>
                    <div class="card-body">
                      <div class="mb-3">
                        <strong>Your Message:</strong>
                        <div class="border rounded p-3 mt-2 bg-light">
                          ${feedback.message}
                        </div>
                      </div>

                      <c:choose>
                        <c:when test="${feedback.status == 'responded' && not empty feedback.response}">
                          <div class="mb-0">
                            <strong><i class="bi bi-reply-fill text-primary"></i> Admin Response:</strong>
                            <div class="border rounded p-3 mt-2 bg-info bg-opacity-10 border-primary">
                              ${feedback.response}
                            </div>
                          </div>
                        </c:when>
                        <c:when test="${feedback.status == 'in-review'}">
                          <div class="alert alert-warning mb-0">
                            <i class="bi bi-clock-history"></i> Your feedback is currently being reviewed by the admin.
                          </div>
                        </c:when>
                        <c:otherwise>
                          <div class="alert alert-secondary mb-0">
                            <i class="bi bi-hourglass-split"></i> Your feedback is pending review.
                          </div>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>

            <div class="mt-3">
              <a href="${pageContext.request.contextPath}/feedback/file" class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> Submit New Feedback
              </a>
              <a href="${pageContext.request.contextPath}/dashboard/" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Back to Dashboard
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

