<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Challenges</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-start mb-4">
        <div>
            <h2 class="fw-bold">Manage Challenges</h2>
            <p class="text-muted">Create and manage mental health challenges for students</p>
        </div>
        <button class="btn btn-primary create-btn">
            <span class="me-1">+</span> Create Challenge
        </button>
    </div>

    <c:forEach var="rowIter" begin="1" end="${challengeTypes.size() / 2 + challengeTypes.size() % 2}">
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
                  
                  <a class="btn btn-primary" href="${pageContext.request.contextPath}/mental-health-challenge/challenge/${challenge.id}">view details</a>
                </div>
              </div>
            </div>
          </c:if>
        </c:forEach>
      </div>
    </c:forEach>
</div>

</body>
</html>