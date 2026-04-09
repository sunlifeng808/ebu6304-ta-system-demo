<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Job Detail" />
<%@ include file="includes/header.jspf" %>

<div class="grid-two">
    <section class="card">
        <h2>${job.title}</h2>
        <p><strong>Module:</strong> ${job.moduleName}</p>
        <p><strong>Description:</strong> ${job.description}</p>
        <p><strong>Required Skills:</strong>
            <c:forEach items="${job.requiredSkills}" var="skill" varStatus="status">
                ${skill}<c:if test="${not status.last}">, </c:if>
            </c:forEach>
        </p>
        <p><strong>Hours:</strong> ${job.hours}</p>
        <p><strong>Status:</strong> ${job.status}</p>
    </section>

    <section class="card">
        <h2>Match Result</h2>
        <c:if test="${param.msg == 'applied'}">
            <div class="alert alert-success">Application submitted successfully.</div>
        </c:if>
        <c:if test="${param.msg == 'duplicate'}">
            <div class="alert alert-error">You have already applied for this job.</div>
        </c:if>

        <p><strong>Match Score:</strong> ${matchResult.score}%</p>
        <p><strong>Matched Skills:</strong>
            <c:choose>
                <c:when test="${empty matchResult.matchedSkills}">None</c:when>
                <c:otherwise>
                    <c:forEach items="${matchResult.matchedSkills}" var="skill" varStatus="status">
                        ${skill}<c:if test="${not status.last}">, </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </p>
        <p><strong>Missing Skills:</strong>
            <c:choose>
                <c:when test="${empty matchResult.missingSkills}">None</c:when>
                <c:otherwise>
                    <c:forEach items="${matchResult.missingSkills}" var="skill" varStatus="status">
                        ${skill}<c:if test="${not status.last}">, </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </p>

        <c:choose>
            <c:when test="${alreadyApplied}">
                <span class="badge badge-info">You already applied</span>
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/jobs/apply" method="post" data-confirm="Submit application for this job?">
                    <input type="hidden" name="id" value="${job.id}">
                    <button class="btn btn-primary" type="submit">Apply Now</button>
                </form>
            </c:otherwise>
        </c:choose>
    </section>
</div>

<%@ include file="includes/footer.jspf" %>
