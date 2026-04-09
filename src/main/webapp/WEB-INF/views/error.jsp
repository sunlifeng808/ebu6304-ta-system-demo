<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Error" />
<%@ include file="includes/header.jspf" %>

<section class="card narrow-card">
    <h2>Something went wrong</h2>
    <p class="error-text">${errorMessage}</p>
    <c:choose>
        <c:when test="${not empty backUrl}">
            <a class="btn btn-primary" href="${backUrl}">Go Back</a>
        </c:when>
        <c:otherwise>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/dashboard">Return to Dashboard</a>
        </c:otherwise>
    </c:choose>
</section>

<%@ include file="includes/footer.jspf" %>
