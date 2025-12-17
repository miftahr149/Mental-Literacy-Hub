<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Choose Your Role</title>
</head>
<body>
    <h1>Choose Your Role</h1>
    <form action="${pageContext.request.contextPath}/mental-health-challenge/demo" method="post">
        <label>
            <input type="radio" name="role" value="student" required> Student
        </label><br>
        <label>
            <input type="radio" name="role" value="mhp" required> Mental Health Professional
        </label><br>
        <button type="submit">Submit</button>
    </form>
</body>
</html>