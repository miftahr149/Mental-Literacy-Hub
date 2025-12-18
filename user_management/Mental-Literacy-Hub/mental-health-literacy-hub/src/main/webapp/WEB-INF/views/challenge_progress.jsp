<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Challenge Progress</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>
    <div class="container">
      <%@ include file="/component/mental_health_challenge_header.jsp" %>
      
      <section class="d-flex gap-3 mb-4">
        <div class="card p-2 gap-2 flex-grow-1">
          <div class="card-body">
            <h5 class="card-title">Days Completed</h5>
            <p class="card-text">${challenge.progressDays} / ${challenge.totalDays}</p>
            <p class="card-text">
              <fmt:formatNumber value="${challenge.progressDays / challenge.totalDays * 100}" minFractionDigits="2" maxFractionDigits="2" />
              % completed
            </p>
          </div>
        </div>
        <div class="card p-2 gap-2 flex-grow-1">
          <div class="card-body">
            <h5 class="card-title">Average Mood</h5>
            <p class="card-text">
              <fmt:formatNumber value="${challenge.averageMood}" minFractionDigits="1" maxFractionDigits="1" /> / 5.0
            </p>
            <p class="card-text">Across all reflections</p>
          </div>
        </div>
        <div class="card p-2 gap-2 flex-grow-1">
          <div class="card-body">
            <h5 class="card-title">Current Streak</h5>
            <p class="card-text">${challenge.currentStreak} days</p>
            <p class="card-text">keep it going!</p>
          </div>
        </div>
      </section>

      <section class="p-2">
        <h2>Your Reflections</h2>
        <div class="list-group">
            <c:forEach var="reflection" items="${challenge.dailyReflections}" varStatus="loopStatus">
                <div class="list-group-item d-flex justify-content-between align-items-start">
                    <div class="ms-2 me-auto">
                        <div class="fw-bold">Day ${loopStatus.index + 1}</div>
                        <small><i class="bi bi-calendar"></i> ${reflection.date}</small>
                        <p>${reflection.reflection}</p>
                    </div>
                    <span class="badge bg-success rounded-pill">${reflection.feeling}</span>
                </div>
            </c:forEach>
        </div>
      </section>
    </div>
</body>
</html>