<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Challenge Details - Mental Health Hub</title>
    <jsp:include page="/component/common_head.jsp"/>
</head>
<body class="bg-light">
  <jsp:include page="/component/main_navbar.jsp">
    <jsp:param name="activePage" value="challenges"/>
  </jsp:include>
    <div class="container py-4">
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>