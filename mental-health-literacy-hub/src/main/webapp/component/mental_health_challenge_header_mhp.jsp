<c:if test="${not empty challengeType}">
  <a
    href="${pageContext.request.contextPath}/mental-health-challenge/"
    class="btn btn-link"
    >&larr; Back to Challenges</a
  >
  <section class="card p-4 mb-4 flex-row">
    <div class="card-body">
      <h1 class="card-title">${challengeType.title}</h1>
      <p class="card-text">${challengeType.description}</p>
      <div class="d-flex gap-3">
        <p class="card-text">${challengeType.totalDays} days</p>
        <p class="card-text">&bull;</p>
        <p class="card-text">${challengeType.activities.size()} activities</p>
      </div>
      <p class="card-text">Created by ${challengeType.creator}</p>
    </div>
    <div class="d-flex gap-3">
      <div>
        <button
          class="p-2 btn btn-primary btn-lg"
          data-bs-toggle="modal"
          data-bs-target="#editChallengeModal"
        >
          <i class="bi bi-pen"> </i>
        </button>
      </div>
      <form
        action="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challengeType.id}/delete"
        method="post"
      >
        <button type="submit" class="p-2 btn btn-danger btn-lg">
          <i class="bi bi-trash"> </i>
        </button>
      </form>
    </div>
  </section>

  <div
    class="modal fade"
    id="editChallengeModal"
    tabindex="-1"
    aria-labelledby="modalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content border-0 rounded-4 overflow-hidden">
        <div class="modal-header card-header-gradient text-white border-0 py-3">
          <h5 class="modal-title fw-bold" id="modalLabel">Edit Challenge</h5>
          <button
            type="button"
            class="btn-close btn-close-white"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>

        <form
          action="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challengeType.id}/update"
          method="post"
        >
          <div class="modal-body p-4">
            <div class="mb-3">
              <label class="form-label fw-bold small">Challenge Title *</label>
              <input
                type="text"
                name="title"
                class="form-control"
                placeholder="e.g., 30-Day Gratitude Journey"
                required
                value="${challengeType.title}"
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
              >${challengeType.description}</textarea>
            </div>

            <div class="mb-3">
              <label class="form-label fw-bold small">Duration (days) *</label>
              <input
                type="number"
                name="totalDays"
                class="form-control"
                value="30"
                required
                value="${challengeType.totalDays}"
              />
            </div>

            <div class="mb-3">
              <label class="form-label fw-bold small">Daily Activities *</label>
              <div id="activityContainer">
                <div class="input-group mb-2">
                  <input
                    type="text"
                    name="activities"
                    class="form-control"
                    placeholder="Activity 1"
                    value="${challengeType.activitiesAsList[0]}"
                    required
                  />
                </div>

                <c:forEach var="index" begin="1" end="${challengeType.activities.size() - 1}">
                  <div class="input-group mb-2">
                    <input type="text" name="activities" class="form-control" placeholder="Activity" value="${challengeType.activitiesAsList[index]}" required />
                    <button class="btn btn-outline-danger" type="button" onclick="this.parentElement.remove()">
                        <i class="bi bi-trash"></i>
                    </button>
                  </div>
                </c:forEach>
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
              Edit Challenge
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
  ></script>
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
</c:if>
