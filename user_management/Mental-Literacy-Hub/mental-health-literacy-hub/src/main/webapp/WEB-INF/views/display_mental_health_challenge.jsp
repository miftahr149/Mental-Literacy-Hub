<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>

  <head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  </head>

  <body>
    <div class="container py-5">
      <section>
        <div class="py-2">
          <h2 class="text-secondary">Available Challenges</h2>
          <p>Choose a challenge to start your mental wellness journey</p>
        </div>

        <c:forEach var="rowIter" begin="1" end="${challenges.size() / 2 + challenges.size() % 2}">
          <div class="row my-2">
            <c:forEach var="colIter" begin="0" end="1">
              <c:set var="index" value="${(rowIter - 1) * 2 + colIter}" />
              <c:if test="${index < challenges.size()}">
                <c:set var="challenge" value="${challenges[index]}" />
                <div class="col-md-6">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="card-title">${challenge.title}</h5>
                      <p class="card-text">${challenge.description}</p>
                      <p class="card-text text-muted">${challenge.creator}</p>
                      
                      <c:choose>
                        <c:when test="${challenge.progressDays == 0}">
                          <a class="btn btn-primary" href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}">Start Challenge</a>
                        </c:when>
                        <c:otherwise>
                          <p>Your Progress: ${challenge.progressDays} / ${challenge.totalDays} days</p>
                          <a class="btn btn-primary" href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}">Continue</a>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>
        </c:forEach>
      </section>
    </div>
  </body>
</html>