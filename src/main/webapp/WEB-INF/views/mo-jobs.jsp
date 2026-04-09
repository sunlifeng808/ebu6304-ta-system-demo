<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="My Jobs" />
<%@ include file="includes/header.jspf" %>

<section class="section-header">
    <h2>My Posted Jobs</h2>
    <p>Manage the jobs you have created and review all applicants.</p>
</section>

<c:if test="${param.msg == 'created'}">
    <div class="alert alert-success">Job created successfully.</div>
</c:if>

<div class="table-card">
    <table>
        <thead>
        <tr>
            <th>Title</th>
            <th>Module</th>
            <th>Hours</th>
            <th>Required Skills</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${jobs}" var="job">
            <tr>
                <td>${job.title}</td>
                <td>${job.moduleName}</td>
                <td>${job.hours}</td>
                <td>${fn:join(job.requiredSkills, ', ')}</td>
                <td>${job.status}</td>
                <td>
                    <a class="btn btn-secondary btn-small"
                       href="${pageContext.request.contextPath}/mo/applications?jobId=${job.id}">View Applications</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty jobs}">
            <tr>
                <td colspan="6" class="empty-row">You have not created any jobs yet.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<%@ include file="includes/footer.jspf" %>
