<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Challenge Progress - Mental Health Hub</title>
    <jsp:include page="/component/common_head.jsp" />
  </head>
  <body class="bg-light">
    <jsp:include page="/component/main_navbar.jsp">
      <jsp:param name="activePage" value="challenges" />
    </jsp:include>
    <div class="container py-4">
      <%@ include file="/component/mental_health_challenge_header.jsp" %>

      <section class="d-flex gap-3 mb-4">
        <div class="card p-2 gap-2 flex-grow-1">
          <div class="card-body">
            <h5 class="card-title">Days Completed</h5>
            <p class="card-text">
              ${challenge.progressDays} / ${challenge.totalDays}
            </p>
            <p class="card-text">
              <fmt:formatNumber
                value="${challenge.progressDays / challenge.totalDays * 100}"
                minFractionDigits="2"
                maxFractionDigits="2"
              />
              % completed
            </p>
          </div>
        </div>
        <div class="card p-2 gap-2 flex-grow-1">
          <div class="card-body">
            <h5 class="card-title">Average Mood</h5>
            <p class="card-text">
              <fmt:formatNumber
                value="${challenge.averageMood}"
                minFractionDigits="1"
                maxFractionDigits="1"
              />
              / 5.0
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

      <div style="width: 100%; height: 300px; position: relative">
        <canvas id="moodChart"></canvas>
      </div>

      <section class="p-2">
        <h2>Your Reflections</h2>
        <div class="list-group">
          <c:forEach
            var="reflection"
            items="${challenge.dailyReflections}"
            varStatus="loopStatus"
          >
            <div
              class="list-group-item d-flex justify-content-between align-items-start"
            >
              <div class="ms-2 me-auto">
                <div class="fw-bold">Day ${loopStatus.index + 1}</div>
                <small><i class="bi bi-calendar"></i> ${reflection.date}</small>
                <p>${reflection.reflection}</p>
              </div>
              <span class="badge bg-success rounded-pill"
                >${reflection.feeling}</span
              >
            </div>
          </c:forEach>
        </div>
      </section>
    </div>
    <input type="hidden" id="challengeIdHolder" value="${challenge.id}" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
      const challengeId = document.getElementById('challengeIdHolder').value;
      // Inside your JSP <script> tag
      async function loadChartData(challengeId) {
          try {
              const contextPath = '${pageContext.request.getContextPath()}'
              const apiURL = contextPath + `/mental-health-challenge/daily-reflection/` + challengeId
              const response = await fetch(apiURL);
              const chartData = await response.json();

              renderChart(chartData);
          } catch (error) {
              console.error("Failed to fetch mood data", error);
          }
      }

      function renderChart(data) {
          const ctx = document.getElementById('moodChart').getContext('2d');
          new Chart(ctx, {
              type: 'line',
              data: {
                  labels: data.map(d => d.day),
                  datasets: [{
                      label: 'Mood Level',
                      data: data.map(d => d.mood),
                      borderColor: '#9333ea',
                      tension: 0.4,
                      fill: false
                  }]
              },
              options: {
                  responsive: true,
                  maintainAspectRatio: false,
                  scales: {
                      y: { min: 0, max: 5 }
                  }
              }
          });
      }

      // Call the function with the ID passed from your controller
      loadChartData(challengeId);
    </script>
  </body>
</html>
