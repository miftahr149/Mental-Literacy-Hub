<c:if test="${not empty challenge}">
  <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-link">&larr; Back to Challenges</a>
  <section class="card p-4 mb-4">
    <div class="card-body">
      <h1 class="card-title">${challenge.title}</h1>
      <p class="card-text"> ${challenge.description}</p>
      <div class="d-flex gap-3">
        <p class="card-text"> ${challenge.totalDays} days </p>
        <p class="card-text">&bull;</p>
        <p class="card-text"> ${challenge.activities.size()} activities </p>
      </div>
      <p class="card-text">Created by ${challenge.creator}</p>
      <div>
        <div class="d-flex justify-content-between align-items-center mb-2">
          <div class="d-flex gap-3">
            <i class="bi bi-graph-up-arrow"></i>
            <p>progress</p>
          </div>
          <p>${challenge.progressDays} / ${challenge.totalDays} days completed</p>
        </div>
        
        <div class="progress mb-3">
          <div class="progress-bar" role="progressbar" style="width: ${challenge.progressDays * 100 / challenge.totalDays}%;" aria-valuenow="${challenge.progressDays}" aria-valuemin="0" aria-valuemax="${challenge.totalDays}"></div>
        </div>
      </div>
    </div>

  </section>
  <section class="card flex-row mb-4 p-2 gap-2">
    <c:choose>
      <c:when test="${mode == 'overview'}">
        <button class="btn btn-primary mx-2 flex-grow-1" disabled>Overview</button>
        <a class="btn btn-secondary mx-2 flex-grow-1" href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}/progress">My Progress</a>
      </c:when>
      <c:when test="${mode == 'progress'}">
        <a class="btn btn-secondary mx-2 flex-grow-1" href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}">Overview</a>
        <button class="btn btn-primary mx-2 flex-grow-1" disabled>My Progress</button>
      </c:when>
    </c:choose>
  </section>
</c:if>