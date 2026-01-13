<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Dashboard - Mental Health Hub</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body>
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="dashboard"/>
  </jsp:include>

  <div class="container py-4 fade-in">
    <!-- Welcome Section -->
    <div class="page-header">
      <h2>
        <i class="bi bi-house-heart me-2"></i> Welcome back, ${username}!
      </h2>
      <p>Here's an overview of your mental health journey</p>
    </div>

    <c:choose>
      <c:when test="${userRole == 'student'}">
        <!-- Student Dashboard -->
        
        <!-- Stats Cards -->
        <div class="row mb-4">
          <div class="col-md-3 mb-3">
            <div class="stat-card">
              <div class="stat-icon" style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);">
                <i class="bi bi-trophy"></i>
              </div>
              <div class="stat-value">${totalChallenges}</div>
              <div class="stat-label">Total Challenges</div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="stat-card">
              <div class="stat-icon">
                <i class="bi bi-activity"></i>
              </div>
              <div class="stat-value">${activeChallenges}</div>
              <div class="stat-label">Active Challenges</div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="stat-card">
              <div class="stat-icon" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                <i class="bi bi-check-circle"></i>
              </div>
              <div class="stat-value">${completedChallenges}</div>
              <div class="stat-label">Completed</div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="stat-card">
              <div class="stat-icon" style="background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);">
                <i class="bi bi-calendar-check"></i>
              </div>
              <div class="stat-value">${totalProgressDays}</div>
              <div class="stat-label">Days Progressed</div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-4" style="color: #1f2937;"><i class="bi bi-lightning-charge me-2"></i> Quick Actions</h4>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #667eea;">
                    <i class="bi bi-list-task"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">View Challenges</h5>
                  <p class="text-muted small mb-0">Browse and start new challenges</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #10b981;">
                    <i class="bi bi-person-circle"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">My Profile</h5>
                  <p class="text-muted small mb-0">View and edit your profile</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile/edit" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #f59e0b;">
                    <i class="bi bi-pencil-square"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">Update Profile</h5>
                  <p class="text-muted small mb-0">Edit your personal information</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/analytics/" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #3b82f6;">
                    <i class="bi bi-graph-up-arrow"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">View Analytics</h5>
                  <p class="text-muted small mb-0">Reports and statistics</p>
                </div>
              </div>
            </a>
          </div>
        </div>

        <!-- Active Challenges -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-4" style="color: #1f2937;"><i class="bi bi-fire me-2"></i> Active Challenges</h4>
            <c:choose>
              <c:when test="${not empty challenges && challenges.size() > 0}">
                <div class="row">
                  <c:forEach var="challenge" items="${challenges}" varStatus="status">
                    <c:if test="${status.index < 3}">
                      <div class="col-md-4 mb-3">
                        <div class="card h-100">
                          <div class="card-body">
                            <h5 class="card-title fw-bold" style="color: #1f2937;">${challenge.title}</h5>
                            <p class="card-text text-muted small">${challenge.description}</p>
                            <div class="mb-3">
                              <small class="text-muted">Progress: ${challenge.progressDays} / ${challenge.totalDays} days</small>
                              <div class="progress mt-2" style="height: 8px; border-radius: 10px;">
                                <div class="progress-bar" role="progressbar" 
                                     style="width: ${challenge.progressDays * 100 / challenge.totalDays}%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);" 
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
                <div class="text-center mt-4">
                  <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-outline-primary">
                    View All Challenges <i class="bi bi-arrow-right"></i>
                  </a>
                </div>
              </c:when>
              <c:otherwise>
                <div class="card">
                  <div class="card-body text-center py-5">
                    <div class="mb-3" style="font-size: 4rem; color: #9ca3af;">
                      <i class="bi bi-inbox"></i>
                    </div>
                    <p class="text-muted" style="font-size: 1.1rem;">No challenges yet. Start your first challenge!</p>
                    <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-primary mt-3">
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
            <div class="stat-card">
              <div class="stat-icon">
                <i class="bi bi-clipboard-check"></i>
              </div>
              <div class="stat-value">${totalChallenges}</div>
              <div class="stat-label">Challenges Created</div>
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <div class="stat-card">
              <div class="stat-icon" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                <i class="bi bi-people"></i>
              </div>
              <div class="stat-value">Active</div>
              <div class="stat-label">Challenge Management</div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-4" style="color: #1f2937;"><i class="bi bi-lightning-charge me-2"></i> Quick Actions</h4>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #667eea;">
                    <i class="bi bi-plus-circle"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">Manage Challenges</h5>
                  <p class="text-muted small mb-0">Create and manage challenges</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #10b981;">
                    <i class="bi bi-person-circle"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">My Profile</h5>
                  <p class="text-muted small mb-0">View and edit your profile</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile/edit" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #f59e0b;">
                    <i class="bi bi-pencil-square"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">Update Profile</h5>
                  <p class="text-muted small mb-0">Edit your personal information</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/analytics/" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #3b82f6;">
                    <i class="bi bi-graph-up-arrow"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">View Analytics</h5>
                  <p class="text-muted small mb-0">Reports and statistics</p>
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
            <div class="stat-card">
              <div class="stat-icon">
                <i class="bi bi-people"></i>
              </div>
              <div class="stat-value">Admin</div>
              <div class="stat-label">User Management</div>
            </div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
          <div class="col-12">
            <h4 class="fw-bold mb-4" style="color: #1f2937;"><i class="bi bi-lightning-charge me-2"></i> Quick Actions</h4>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/admin/users" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #667eea;">
                    <i class="bi bi-people"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">Manage Users</h5>
                  <p class="text-muted small mb-0">View and manage all users</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #10b981;">
                    <i class="bi bi-person-circle"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">My Profile</h5>
                  <p class="text-muted small mb-0">View and edit your profile</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/user-management/profile/edit" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #f59e0b;">
                    <i class="bi bi-pencil-square"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">Update Profile</h5>
                  <p class="text-muted small mb-0">Edit your personal information</p>
                </div>
              </div>
            </a>
          </div>
          <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/analytics/" class="text-decoration-none">
              <div class="card quick-action-card h-100">
                <div class="card-body text-center">
                  <div class="mb-3" style="font-size: 3rem; color: #3b82f6;">
                    <i class="bi bi-graph-up-arrow"></i>
                  </div>
                  <h5 class="fw-bold" style="color: #1f2937;">View Analytics</h5>
                  <p class="text-muted small mb-0">Reports and statistics</p>
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