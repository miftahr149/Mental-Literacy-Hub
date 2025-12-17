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
      <%@ include file="/component/mental_health_challenge_header_mhp.jsp" %>
      
      <section class="card p-4 mb-4">
        <h3 class="card-title">Activities</h3>
        <ul>
            <c:forEach var="activity" items="${challengeType.activities}">
                <li class="card-text">${activity}</li>
            </c:forEach>
        </ul>
      </section>
    </div>
</body>
</html>