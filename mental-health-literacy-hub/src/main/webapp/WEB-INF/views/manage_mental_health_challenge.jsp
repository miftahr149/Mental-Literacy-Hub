<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Manage Challenges - Mental Health Hub</title>
    <jsp:include page="/component/common_head.jsp" />
  </head>
  <body class="bg-light">
    <jsp:include page="/component/main_navbar.jsp">
      <jsp:param name="activePage" value="challenges" />
    </jsp:include>
    <div class="container py-4">
      <div class="d-flex justify-content-between align-items-start mb-4">
        <div>
          <h2 class="fw-bold">Manage Challenges</h2>
          <p class="text-muted">
            Create and manage mental health challenges for students
          </p>
        </div>
        <button
          class="btn btn-primary"
          data-bs-toggle="modal"
          data-bs-target="#createChallengeModal"
        >
          <span class="me-1">+</span> Create Challenge
        </button>
      </div>

      <c:forEach
        var="rowIter"
        begin="1"
        end="${challengeTypes.size() / 2 + challengeTypes.size() % 2}"
      >
        <div class="row my-2">
          <c:forEach var="colIter" begin="0" end="1">
            <c:set var="index" value="${(rowIter - 1) * 2 + colIter}" />
            <c:if test="${index < challengeTypes.size()}">
              <c:set var="challenge" value="${challengeTypes[index]}" />
              <div class="col-md-6">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">${challenge.title}</h5>
                    <p class="card-text">${challenge.description}</p>
                    <p class="card-text text-muted">${challenge.creator}</p>

                    <a
                      class="btn btn-primary"
                      href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}/manage"
                      >view details</a
                    >
                  </div>
                </div>
              </div>
            </c:if>
          </c:forEach>
        </div>
      </c:forEach>

      <div
        class="modal fade"
        id="createChallengeModal"
        tabindex="-1"
        aria-labelledby="modalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content border-0 rounded-4 overflow-hidden">
            <div
              class="modal-header card-header-gradient text-white border-0 py-3"
            >
              <h5 class="modal-title fw-bold" id="modalLabel">
                Create New Challenge
              </h5>
              <button
                type="button"
                class="btn-close btn-close-white"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>

            <form
              action="${pageContext.request.contextPath}/mental-health-challenge/create"
              method="post"
            >
              <div class="modal-body p-4">
                <div class="mb-3">
                  <label class="form-label fw-bold small"
                    >Challenge Title *</label
                  >
                  <input
                    type="text"
                    name="title"
                    class="form-control"
                    placeholder="e.g., 30-Day Gratitude Journey"
                    required
                  />
                </div>

                <div class="mb-3">
                  <label class="form-label fw-bold small">Description *</label>
                  <textarea
                    name="description"
                    class="form-control"
                    rows="4"
                    placeholder="Describe the purpose and benefits..."
                    required
                  ></textarea>
                </div>

                <div class="mb-3">
                  <label class="form-label fw-bold small"
                    >Duration (days) *</label
                  >
                  <input
                    type="number"
                    name="totalDays"
                    class="form-control"
                    value="30"
                    required
                  />
                </div>

                <div class="mb-3">
                  <label class="form-label fw-bold small"
                    >Daily Activities *</label
                  >
                  <div id="activityContainer">
                    <div class="input-group mb-2">
                      <input
                        type="text"
                        name="activities"
                        class="form-control"
                        placeholder="Activity 1"
                        required
                      />
                    </div>
                  </div>

                  <button
                    type="button"
                    class="btn btn-outline-primary btn-sm mt-1"
                    onclick="addActivityField()"
                  >
                    <i class="bi bi-plus"></i> Add Another Activity
                  </button>
                </div>
              </div>
              <div class="modal-footer border-0 p-4 pt-0 d-flex gap-2">
                <button
                  type="button"
                  class="btn btn-outline-secondary flex-grow-1 py-2"
                  data-bs-dismiss="modal"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  class="btn btn-primary create-btn flex-grow-1 py-2"
                >
                  Create Challenge
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <section class="mt-5">
        <div class="d-flex align-items-center mb-4">
            <div class="bg-primary rounded-circle p-2 me-3">
                <i class="bi bi-shield-check text-white"></i>
            </div>
            <div>
                <h3 class="fw-bold mb-0">Management Audit Trail</h3>
                <p class="text-muted mb-0">Track your changes to challenge templates and system events</p>
            </div>
        </div>

        <div class="card border-0 shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light text-secondary small text-uppercase">
                        <tr>
                            <th class="ps-4">Event Type</th>
                            <th>Details</th>
                            <th>Date & Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty mhp_activity}">
                                <c:forEach var="log" items="${mhp_activity}">
                                    <tr>
                                        <td class="ps-4">
                                            <c:choose>
                                                <c:when test="${log.action == 'MHP_CREATE_CHALLENGE'}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle">CREATE</span>
                                                </c:when>
                                                <c:when test="${log.action == 'MHP_EDIT_CHALLENGE' || log.action == 'MHP_UPDATE_CHALLENGE'}">
                                                    <span class="badge bg-info-subtle text-info border border-info-subtle">UPDATE</span>
                                                </c:when>
                                                <c:when test="${log.action == 'MHP_DELETE_CHALLENGE'}">
                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle">DELETE</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border">SYSTEM</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="fw-semibold text-dark">${log.logMessage}</div>
                                            <small class="text-muted">Entity: ${log.targetEntity} | ID: ${log.targetId}</small>
                                        </td>
                                        <td class="text-muted">
                                            <i class="bi bi-clock-history me-1"></i> ${log.timestamp}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3" class="text-center py-5">
                                        <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" alt="No Data" style="width: 60px; opacity: 0.5;">
                                        <p class="mt-3 text-muted">No management activity recorded yet.</p>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function addActivityField() {
        const container = document.getElementById("activityContainer");
        const fieldCount =
          container.getElementsByClassName("input-group").length + 1;

        // Create a new input group
        const div = document.createElement("div");
        div.className = "input-group mb-2";
        div.innerHTML = `
            <input type="text" name="activities" class="form-control" placeholder="Activity ${fieldCount}" required />
            <button class="btn btn-outline-danger" type="button" onclick="this.parentElement.remove()">
                <i class="bi bi-trash"></i>
            </button>
        `;

        container.appendChild(div);
      }
    </script>
  </body>
</html>
