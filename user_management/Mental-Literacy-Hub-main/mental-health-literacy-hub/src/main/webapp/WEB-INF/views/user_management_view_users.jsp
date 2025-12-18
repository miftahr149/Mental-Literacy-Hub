<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Users</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/user_management_navbar.jsp">
    <jsp:param name="activePage" value="users"/>
  </jsp:include>

  <div class="container py-5">
    <div class="row">
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-primary text-white">
            <h4 class="mb-0"><i class="bi bi-people"></i> User Management</h4>
          </div>
          <div class="card-body p-4">
            <!-- TODO: Add ban/unban success/error messages when backend is implemented -->

            <div class="table-responsive">
              <table class="table table-hover">
                <thead class="table-light">
                  <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="user" items="${users}">
                    <tr>
                      <td>${user.id}</td>
                      <td>${user.name}</td>
                      <td>${user.email}</td>
                      <td>
                        <span class="badge 
                          <c:choose>
                            <c:when test="${user.role == 'admin'}">bg-danger</c:when>
                            <c:when test="${user.role == 'mhp'}">bg-info</c:when>
                            <c:otherwise>bg-secondary</c:otherwise>
                          </c:choose>">
                          ${user.role}
                        </span>
                      </td>
                      <td>
                        <span class="badge bg-success">Active</span>
                      </td>
                      <td>
                        <c:if test="${user.id != sessionScope.userId}">
                          <!-- TODO: Add ban/unban functionality in backend -->
                          <button type="button" class="btn btn-sm btn-danger" disabled title="Ban functionality - to be implemented">
                            <i class="bi bi-lock"></i> Ban
                          </button>
                        </c:if>
                        <c:if test="${user.id == sessionScope.userId}">
                          <span class="text-muted small">(You)</span>
                        </c:if>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>

            <div class="mt-3">
              <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Back to Home
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>

