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
      <%@ include file="/component/mental_health_challenge_header.jsp" %>
      
      <section class="card p-4 mb-4">
        <h3 class="card-title">Activities</h3>
        <ul>
            <c:forEach var="activity" items="${challenge.activities}">
                <li class="card-text">${activity}</li>
            </c:forEach>
        </ul>
      </section>
      
      <form id="daily-reflection-form" class="card p-4 mb-4" action="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}/submit" method="post">
        <h5>Day ${challenge.progressDays + 1} Reflection</h5>

        <section>
          <p>How are you feeling today?</p>

          <div class="d-flex gap-3 justify-content-between" role="button" aria-label="Select-like buttons">
            <c:forEach var="feeling" items="${feelings}">
              <input type="radio" class="btn-check" name="feeling" id="${feeling.name}" value="${feeling.name}" autocomplete="off">
              <label class="btn ${feeling.btnClass} flex-grow-1" for="${feeling.name}">
                <i class="bi bi-${feeling.imageClass}"></i>
                ${feeling.displayName}
              </label>
            </c:forEach>
          </div>
        </section>

        <section class="mt-4">
          <p>Write your reflection</p>
          <textarea class="form-control" rows="4" placeholder="Share your thoughts, experiences, and insights from today's activities..." id="reflection" name="reflection"></textarea>
          <p class="text-muted mt-2" id="reflection-counter">0 characters</p>
        </section>

        <div class="d-flex gap-3 mt-4">
          <button class="btn btn-secondary flex-grow-1">Cancel</button>
          <button id="submit" type="submit" class="btn btn-primary flex-grow-1" disabled>Submit Reflection</button>
        </div>
      </form>
    </div>

    <script>
      const reflection = document.getElementById("reflection");
      const counter = document.getElementById("reflection-counter");
      const submitBtn = document.getElementById("submit");
      const dailyReflectionForm = document.getElementById("daily-reflection-form");
      
      const isFieldEmpty = (field) => {
        return field.value === "" || field.value === null
      }

      reflection.addEventListener("input", (event) => {
        const reflectionLength = event.target.value.length;
        counter.textContent = reflectionLength + " characters";
      });

      dailyReflectionForm.addEventListener("change", (event) => {
        console.log(dailyReflectionForm['reflection'].value);
        console.log(dailyReflectionForm['feeling'].value);

        const isReflectionEmpty = isFieldEmpty(dailyReflectionForm['reflection']);
        const isFeelingEmpty = isFieldEmpty(dailyReflectionForm['feeling']);
        submitBtn.disabled = isReflectionEmpty || isFeelingEmpty;
      });
    </script>
</body>
</html>