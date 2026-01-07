<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Dashboard - Mental Health Hub</title>
  <jsp:include page="/component/common_head.jsp"/>
  <style>
    .stat-card {
      transition: transform 0.2s;
    }
    .stat-card:hover {
      transform: translateY(-5px);
    }
    .quick-action-card {
      transition: all 0.2s;
      cursor: pointer;
    }
    .quick-action-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.15) !important;
    }
  </style>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="dashboard"/>
  </jsp:include>

  <div class="container py-4">
    <!-- Welcome Section -->
    <div class="row mb-4">
      <div class="col-12">
        <h2 class="fw-bold text-primary">
          <i class="bi bi-house-heart"></i> Welcome back, ${username}!
        </h2>
        <p class="text-muted">Here's an overview of your mental health journey</p>
      </div>
    </div>

    <c:choose>
      <c:when test="${userRole == 'student'}">
        <!-- Student Dashboard -->
        
        <!-- Stats Cards -->
        <div class="row mb-4">
          <div class="col-md-3 mb-3">
            <div class="card stat-card shadow-sm border-0 h-100">
              <div class="card-body text-center">
                <i class="bi bi-trophy text-warning" style="font-size: 2.5rem;"></i>
                <h3 class="mt-2 mb-0">${totalChallenges}</h3>
                <p class="text-muted mb-0">Total Challenges</p>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card stat-card shadow-sm border-0 h-100 bg-primary text-white">
              <div class="card-body text-center">
                <i class="bi bi-activity" style="font-size: 2.5rem;"></i>
                <h3 class="mt-2 mb-0">${activeChallenges}</h3>
                <p class="mb-0">Active Challenges</p>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card stat-card shadow-sm border-0 h-100 bg-success text-white">
              <div class="card-body text-center">
                <i class="bi bi-check-circle" style="font-size: 2.5rem;"></i>
                <h3 class="mt-2 mb-0">${completedChallenges}</h3>
                <p class="mb-0">Completed</p>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card stat-card shadow-sm border-0 h-100 bg-info text-white">
              <div class="card-body text-center">
                <i class="bi bi-calendar-check" style="font-size: 2.5rem;"></i>
                <h3 class="mt-2 mb-0">${totalProgressDays}</h3>
                <p class="mb-0">Days Progressed</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-3"><i class="bi bi-lightning-charge"></i> Quick Actions</h4>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-list-task text-primary" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">View Challenges</h5>
                  <p class="text-muted small">Browse and start new challenges</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-person-circle text-success" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">My Profile</h5>
                  <p class="text-muted small">View and edit your profile</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile/edit" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-pencil-square text-warning" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">Update Profile</h5>
                  <p class="text-muted small">Edit your personal information</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/analytics/" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-graph-up-arrow text-info" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">View Analytics</h5>
                  <p class="text-muted small">Reports and statistics</p>
                </div>
              </div>
            </a>
          </div>
        </div>

        <!-- Active Challenges -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-3"><i class="bi bi-fire"></i> Active Challenges</h4>
            <c:choose>
              <c:when test="${not empty challenges && challenges.size() > 0}">
                <div class="row">
                  <c:forEach var="challenge" items="${challenges}" varStatus="status">
                    <c:if test="${status.index < 3}">
                      <div class="col-md-4 mb-3">
                        <div class="card shadow-sm border-0 h-100">
                          <div class="card-body">
                            <h5 class="card-title">${challenge.title}</h5>
                            <p class="card-text text-muted small">${challenge.description}</p>
                            <div class="mb-2">
                              <small class="text-muted">Progress: ${challenge.progressDays} / ${challenge.totalDays} days</small>
                              <div class="progress mt-1" style="height: 6px;">
                                <div class="progress-bar" role="progressbar" 
                                     style="width: ${challenge.progressDays * 100 / challenge.totalDays}%;" 
                                     aria-valuenow="${challenge.progressDays}" 
                                     aria-valuemin="0" 
                                     aria-valuemax="${challenge.totalDays}"></div>
                              </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}" 
                               class="btn btn-primary btn-sm w-100">
                              <c:choose>
                                <c:when test="${challenge.progressDays == 0}">
                                  Start Challenge
                                </c:when>
                                <c:otherwise>
                                  Continue Challenge
                                </c:otherwise>
                              </c:choose>
                            </a>
                          </div>
                        </div>
                      </div>
                    </c:if>
                  </c:forEach>
                </div>
                <div class="text-center mt-3">
                  <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-outline-primary">
                    View All Challenges <i class="bi bi-arrow-right"></i>
                  </a>
                </div>
              </c:when>
              <c:otherwise>
                <div class="card shadow-sm border-0">
                  <div class="card-body text-center py-5">
                    <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                    <p class="text-muted mt-3">No challenges yet. Start your first challenge!</p>
                    <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-primary">
                      Browse Challenges
                    </a>
                  </div>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

      </c:when>
      <c:when test="${userRole == 'mhp'}">
        <!-- MHP Dashboard -->
        
        <!-- Stats Cards -->
        <div class="row mb-4">
          <div class="col-md-6 mb-3">
            <div class="card stat-card shadow-sm border-0 h-100 bg-primary text-white">
              <div class="card-body text-center">
                <i class="bi bi-clipboard-check" style="font-size: 2.5rem;"></i>
                <h3 class="mt-2 mb-0">${totalChallenges}</h3>
                <p class="mb-0">Challenges Created</p>
              </div>
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <div class="card stat-card shadow-sm border-0 h-100 bg-success text-white">
              <div class="card-body text-center">
                <i class="bi bi-people" style="font-size: 2.5rem;"></i>
                <h3 class="mt-2 mb-0">Active</h3>
                <p class="mb-0">Challenge Management</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-3"><i class="bi bi-lightning-charge"></i> Quick Actions</h4>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-plus-circle text-primary" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">Manage Challenges</h5>
                  <p class="text-muted small">Create and manage challenges</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-person-circle text-success" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">My Profile</h5>
                  <p class="text-muted small">View and edit your profile</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile/edit" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-pencil-square text-warning" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">Update Profile</h5>
                  <p class="text-muted small">Edit your personal information</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/analytics/" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-graph-up-arrow text-info" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">View Analytics</h5>
                  <p class="text-muted small">Reports and statistics</p>
                </div>
              </div>
            </a>
          </div>
        </div>
      </c:when>
      <c:when test="${userRole == 'admin'}">
        <!-- Admin Dashboard -->
        <div class="row mb-4">
          <div class="col-md-4 mb-3">
            <div class="card stat-card shadow-sm border-0 h-100 bg-primary text-white">
              <div class="card-body text-center">
                <i class="bi bi-people" style="font-size: 2.5rem;"></i>
                <h3 class="mt-2 mb-0">Admin</h3>
                <p class="mb-0">User Management</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-3"><i class="bi bi-lightning-charge"></i> Quick Actions</h4>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/admin/users" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-people text-primary" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">Manage Users</h5>
                  <p class="text-muted small">View and manage all users</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-person-circle text-success" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">My Profile</h5>
                  <p class="text-muted small">View and edit your profile</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile/edit" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-pencil-square text-warning" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">Update Profile</h5>
                  <p class="text-muted small">Edit your personal information</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/analytics/" class="text-decoration-none">
              <div class="card quick-action-card shadow-sm border-0 h-100">
                <div class="card-body text-center">
                  <i class="bi bi-graph-up-arrow text-info" style="font-size: 3rem;"></i>
                  <h5 class="mt-3">View Analytics</h5>
                  <p class="text-muted small">Reports and statistics</p>
                </div>
              </div>
            </a>
          </div>
        </div>
      </c:when>
    </c:choose>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>





