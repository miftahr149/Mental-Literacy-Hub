<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Challenges - Mental Health Hub</title>
  <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="challenges"/>
  </jsp:include>
  <div class="container py-5">
      <section>
        <div class="py-2 mb-4">
          <h2 class="fw-bold text-primary">Available Challenges</h2>
          <p class="text-muted">Choose a challenge to start your mental wellness journey</p>
        </div>

        <c:choose>
          <c:when test="${not empty challenges && challenges.size() > 0}">
            <div class="row">
              <c:forEach var="challenge" items="${challenges}">
                <div class="col-md-6 mb-4">
                  <div class="card shadow-sm border-0 h-100">
                    <div class="card-body">
                      <h5 class="card-title fw-bold">${challenge.title}</h5>
                      <p class="card-text text-muted">${challenge.description}</p>
                      <p class="card-text">
                        <small class="text-muted">
                          <i class="bi bi-person"></i> Created by ${challenge.creator} | 
                          <i class="bi bi-calendar"></i> ${challenge.totalDays} days
                        </small>
                      </p>
                      
                      <c:choose>
                        <c:when test="${challenge.progressDays == 0}">
                          <a class="btn btn-primary" href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}">
                            <i class="bi bi-play-circle"></i> Start Challenge
                          </a>
                        </c:when>
                        <c:otherwise>
                          <div class="mb-2">
                            <small class="text-muted">Your Progress: ${challenge.progressDays} / ${challenge.totalDays} days</small>
                            <div class="progress mt-1" style="height: 6px;">
                              <div class="progress-bar" role="progressbar" 
                                   style="width: ${challenge.progressDays * 100 / challenge.totalDays}%;" 
                                   aria-valuenow="${challenge.progressDays}" 
                                   aria-valuemin="0" 
                                   aria-valuemax="${challenge.totalDays}"></div>
                            </div>
                          </div>
                          <a class="btn btn-primary" href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}">
                            <i class="bi bi-arrow-right-circle"></i> Continue Challenge
                          </a>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="card shadow-sm border-0">
              <div class="card-body text-center py-5">
                <i class="bi bi-inbox text-muted" style="font-size: 4rem;"></i>
                <h4 class="mt-3 text-muted">No Challenges Available</h4>
                <p class="text-muted">Check back later for new mental health challenges.</p>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </section>
    </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>