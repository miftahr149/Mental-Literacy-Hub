<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Challenges - Mental Health Hub</title>
    <jsp:include page="/component/common_head.jsp" />
  </head>
  <body class="bg-light">
    <jsp:include page="/component/main_navbar.jsp">
      <jsp:param name="activePage" value="challenges" />
    </jsp:include>
    <div class="container py-5">
      <section>
        <div class="py-2 mb-4">
          <h2 class="fw-bold text-primary">Available Challenges</h2>
          <p class="text-muted">
            Choose a challenge to start your mental wellness journey
          </p>
        </div>

        <c:choose>
          <c:when test="${not empty challenges && challenges.size() > 0}">
            <div class="row">
              <c:forEach var="challenge" items="${challenges}">
                <div class="col-md-6 mb-4">
                  <div class="card shadow-sm border-0 h-100">
                    <div class="card-body">
                      <h5 class="card-title fw-bold">${challenge.title}</h5>
                      <p class="card-text text-muted">
                        ${challenge.description}
                      </p>
                      <p class="card-text">
                        <small class="text-muted">
                          <i class="bi bi-person"></i> Created by
                          ${challenge.creator} |
                          <i class="bi bi-calendar"></i> ${challenge.totalDays}
                          days
                        </small>
                      </p>

                      <c:choose>
                        <c:when test="${challenge.progressDays == 0}">
                          <a
                            class="btn btn-primary"
                            href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}"
                          >
                            <i class="bi bi-play-circle"></i> Start Challenge
                          </a>
                        </c:when>
                        <c:otherwise>
                          <div class="mb-2">
                            <small class="text-muted"
                              >Your Progress: ${challenge.progressDays} /
                              ${challenge.totalDays} days</small
                            >
                            <div class="progress mt-1" style="height: 6px">
                              <div
                                class="progress-bar"
                                role="progressbar"
                                style="width: ${challenge.progressDays * 100 / challenge.totalDays}%;"
                                aria-valuenow="${challenge.progressDays}"
                                aria-valuemin="0"
                                aria-valuemax="${challenge.totalDays}"
                              ></div>
                            </div>
                          </div>
                          <a
                            class="btn btn-primary"
                            href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}"
                          >
                            <i class="bi bi-arrow-right-circle"></i> Continue
                            Challenge
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
                <i class="bi bi-inbox text-muted" style="font-size: 4rem"></i>
                <h4 class="mt-3 text-muted">No Challenges Available</h4>
                <p class="text-muted">
                  Check back later for new mental health challenges.
                </p>
              </div>
            </div>
          </c:otherwise>
        </c:choose>

        <section class="mt-5">
          <div class="py-2 mb-4">
            <h3 class="fw-bold text-primary">My Wellness History</h3>
            <p class="text-muted">
              A record of your consistency and commitment to your mental health
            </p>
          </div>

          <div class="card shadow-sm border-0 overflow-hidden">
            <div class="card-body p-0">
              <c:choose>
                <c:when test="${not empty log_activity}">
                  <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                      <thead class="bg-light">
                        <tr>
                          <th class="ps-4">Activity</th>
                          <th>Status</th>
                          <th class="text-end pe-4">Date & Time</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="log" items="${log_activity}">
                          <tr>
                            <td class="ps-4">
                              <div class="d-flex align-items-center">
                                <div class="flex-shrink-0 me-3">
                                  <c:choose>
                                    <c:when
                                      test="${log.action == 'SUBMIT_REFLECTION'}"
                                    >
                                      <i
                                        class="bi bi-journal-check text-success fs-4"
                                      ></i>
                                    </c:when>
                                    <c:when
                                      test="${log.action == 'CHALLENGE_CREATE'}"
                                    >
                                      <i
                                        class="bi bi-plus-circle text-primary fs-4"
                                      ></i>
                                    </c:when>
                                    <c:otherwise>
                                      <i
                                        class="bi bi-activity text-secondary fs-4"
                                      ></i>
                                    </c:otherwise>
                                  </c:choose>
                                </div>
                                <div>
                                  <div class="fw-bold text-dark">
                                    ${log.logMessage}
                                  </div>
                                  <small class="text-muted"
                                    >${log.targetEntity} ID:
                                    ${log.targetId}</small
                                  >
                                </div>
                              </div>
                            </td>
                            <td>
                              <span
                                class="badge rounded-pill ${log.action == 'SUBMIT_REFLECTION' ? 'bg-success-subtle text-success' : 'bg-primary-subtle text-primary'} border"
                              >
                                ${log.action}
                              </span>
                            </td>
                            <td class="text-end pe-4 text-muted small">
                              <i class="bi bi-calendar3 me-1"></i>
                              ${log.timestamp}
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="text-center py-5">
                    <i
                      class="bi bi-calendar-x text-muted"
                      style="font-size: 3rem"
                    ></i>
                    <h5 class="mt-3 text-muted">No activities recorded yet</h5>
                    <p class="text-muted px-4">
                      Complete your first reflection to start building your
                      history!
                    </p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </section>
      </section>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
