<c:if test="${not empty challengeType}">
  <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-link">&larr; Back to Challenges</a>
  <section class="card p-4 mb-4 flex-row">
    <div class="card-body">
      <h1 class="card-title">${challengeType.title}</h1>
      <p class="card-text"> ${challengeType.description}</p>
      <div class="d-flex gap-3">
        <p class="card-text"> ${challengeType.totalDays} days </p>
        <p class="card-text">&bull;</p>
        <p class="card-text"> ${challengeType.activities.size()} activities </p>
      </div>
      <p class="card-text">Created by ${challengeType.creator}</p>
    </div>
    <div class="d-flex gap-3">
      <div>
        <button class="p-2 btn btn-primary btn-lg"> 
          <i class="bi bi-pen"> </i>
        </button>
      </div>
      <form action="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challengeType.id}/delete" method="post">
        <button type="submit" class="p-2 btn btn-danger btn-lg">
          <i class="bi bi-trash"> </i>
        </button>
      </form>
    </div>
  </section>
</c:if>