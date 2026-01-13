<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Feedback Management</title>
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
          <div class="card-header bg-primary text-white">
            <h4 class="mb-0"><i class="bi bi-chat-left-text"></i> Feedback Management</h4>
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
                  <p class="text-muted mt-3">No feedback available.</p>
                </div>
              </c:when>
              <c:otherwise>
                <c:forEach var="feedback" items="${feedbacks}">
                  <div class="card mb-3">
                    <div class="card-header d-flex justify-content-between align-items-center">
                      <div>
                        <strong>Feedback #${feedback.id}</strong> - ${feedback.userName} (${feedback.userEmail})
                        <span class="badge ms-2
                          <c:choose>
                            <c:when test="${feedback.userRole == 'student'}">bg-secondary</c:when>
                            <c:when test="${feedback.userRole == 'mhp'}">bg-info</c:when>
                            <c:otherwise>bg-dark</c:otherwise>
                          </c:choose>">
                          ${feedback.userRole}
                        </span>
                      </div>
                      <div>
                        <span class="badge 
                          <c:choose>
                            <c:when test="${feedback.status == 'pending'}">bg-secondary</c:when>
                            <c:when test="${feedback.status == 'in-review'}">bg-warning</c:when>
                            <c:when test="${feedback.status == 'responded'}">bg-success</c:when>
                            <c:otherwise>bg-secondary</c:otherwise>
                          </c:choose>">
                          ${feedback.status}
                        </span>
                      </div>
                    </div>
                    <div class="card-body">
                      <div class="mb-3">
                        <strong>Submitted:</strong> ${feedback.createdAtFormatted}
                      </div>
                      <div class="mb-3">
                        <strong>Message:</strong>
                        <div class="border rounded p-3 mt-2 bg-light">
                          ${feedback.message}
                        </div>
                      </div>

                      <c:if test="${not empty feedback.response}">
                        <div class="mb-3">
                          <strong>Response:</strong>
                          <div class="border rounded p-3 mt-2 bg-info bg-opacity-10">
                            ${feedback.response}
                          </div>
                        </div>
                      </c:if>

                      <div class="row g-3">
                        <div class="col-md-4">
                          <form method="post" action="${pageContext.request.contextPath}/feedback/admin/update-status" class="d-inline">
                            <input type="hidden" name="feedbackId" value="${feedback.id}">
                            <div class="input-group">
                              <select name="status" class="form-select" required>
                                <option value="pending" <c:if test="${feedback.status == 'pending'}">selected</c:if>>Pending</option>
                                <option value="in-review" <c:if test="${feedback.status == 'in-review'}">selected</c:if>>In Review</option>
                                <option value="responded" <c:if test="${feedback.status == 'responded'}">selected</c:if>>Responded</option>
                              </select>
                              <button type="submit" class="btn btn-outline-primary">
                                <i class="bi bi-check-circle"></i> Update Status
                              </button>
                            </div>
                          </form>
                        </div>
                        <div class="col-md-8">
                          <form method="post" action="${pageContext.request.contextPath}/feedback/admin/respond" class="d-inline">
                            <input type="hidden" name="feedbackId" value="${feedback.id}">
                            <div class="input-group">
                              <textarea name="response" 
                                        class="form-control" 
                                        rows="2" 
                                        placeholder="Enter your response...">${feedback.response}</textarea>
                              <button type="submit" class="btn btn-primary">
                                <i class="bi bi-reply"></i> Respond
                              </button>
                            </div>
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>

            <div class="mt-3">
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

