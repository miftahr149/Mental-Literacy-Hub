<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Student Feedback</title>
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
            <h4 class="mb-0"><i class="bi bi-chat-left-text"></i> Student Feedback</h4>
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
                  <p class="text-muted mt-3">No student feedback available.</p>
                </div>
              </c:when>
              <c:otherwise>
                <div class="table-responsive">
                  <table class="table table-hover">
                    <thead class="table-light">
                      <tr>
                        <th>ID</th>
                        <th>Student Name</th>
                        <th>Email</th>
                        <th>Message</th>
                        <th>Status</th>
                        <th>Submitted</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="feedback" items="${feedbacks}">
                        <tr>
                          <td>${feedback.id}</td>
                          <td>${feedback.userName}</td>
                          <td>${feedback.userEmail}</td>
                          <td>
                            <div style="max-width: 400px; word-wrap: break-word;">
                              ${feedback.message}
                            </div>
                          </td>
                          <td>
                            <span class="badge 
                              <c:choose>
                                <c:when test="${feedback.status == 'pending'}">bg-secondary</c:when>
                                <c:when test="${feedback.status == 'in-review'}">bg-warning</c:when>
                                <c:when test="${feedback.status == 'responded'}">bg-success</c:when>
                                <c:otherwise>bg-secondary</c:otherwise>
                              </c:choose>">
                              ${feedback.status}
                            </span>
                          </td>
                          <td>${feedback.createdAtFormatted}</td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
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

