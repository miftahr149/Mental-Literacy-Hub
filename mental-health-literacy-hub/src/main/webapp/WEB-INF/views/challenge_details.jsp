<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Challenge Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>
    <div class="container">
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

      <section class="card d-flex justify-content-center mb-4 p-2 gap-2">
          <button class="btn btn-primary mx-2" disabled>Overview</button>
          <button class="btn btn-secondary mx-2">My Progress</button>
      </section>
      
      <section class="card p-4 mb-4">
        <h3 class="card-title">Activities</h3>
        <ul>
            <c:forEach var="activity" items="${challenge.activities}">
                <li class="card-text">${activity}</li>
            </c:forEach>
        </ul>
      </section>
      <a href="${pageContext.request.contextPath}/mental-health-challenge/" class="btn btn-primary">
        Back to Challenges
      </a>
    </div>
</body>
</html>