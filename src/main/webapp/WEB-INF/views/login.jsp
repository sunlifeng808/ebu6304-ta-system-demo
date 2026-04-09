<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - TA Recruitment System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="login-body">
<div class="login-card">
    <h1>BUPT International School</h1>
    <h2>Teaching Assistant Recruitment System</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post" class="form-card">
        <label for="username">Username</label>
        <input id="username" name="username" type="text" value="${username}" placeholder="Enter username">

        <label for="password">Password</label>
        <input id="password" name="password" type="password" placeholder="Enter password">

        <button class="btn btn-primary btn-block" type="submit">Login</button>
    </form>
</div>
</body>
</html>
