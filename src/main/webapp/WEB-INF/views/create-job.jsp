<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Create Job" />
<%@ include file="includes/header.jspf" %>

<section class="card form-card">
    <div class="section-header">
        <h2>Create a New TA Job</h2>
        <p>Fill in the position information below.</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/mo/jobs/create" method="post">
        <label for="title">Job Title</label>
        <input id="title" name="title" type="text" value="${param.title}">

        <label for="moduleName">Module / Activity Name</label>
        <input id="moduleName" name="moduleName" type="text" value="${param.moduleName}">

        <label for="description">Description</label>
        <textarea id="description" name="description" rows="4">${param.description}</textarea>

        <label for="requiredSkills">Required Skills</label>
        <textarea id="requiredSkills" name="requiredSkills" rows="3"
                  placeholder="Java, Python, Communication">${param.requiredSkills}</textarea>

        <label for="hours">Workload Hours</label>
        <input id="hours" name="hours" type="number" min="1" value="${param.hours}">

        <button class="btn btn-primary" type="submit">Create Job</button>
    </form>
</section>

<%@ include file="includes/footer.jspf" %>
