<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="My Profile" />
<%@ include file="includes/header.jspf" %>

<section class="card form-card">
    <div class="section-header">
        <h2>Applicant Profile</h2>
        <p>Update your name, email and skills for better matching.</p>
    </div>

    <c:if test="${param.msg == 'updated'}">
        <div class="alert alert-success">Profile updated successfully.</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/applicant/profile" method="post">
        <label for="fullName">Full Name</label>
        <input id="fullName" name="fullName" type="text" value="${applicant.fullName}">

        <label for="email">Email</label>
        <input id="email" name="email" type="email" value="${applicant.email}">

        <label for="skills">Skills</label>
        <textarea id="skills" name="skills" rows="4" placeholder="Java, Excel, Communication">${skillsText}</textarea>
        <p class="hint">Use comma-separated skills, for example: Java, Python, Communication</p>

        <button class="btn btn-primary" type="submit">Save Profile</button>
    </form>
</section>

<%@ include file="includes/footer.jspf" %>
