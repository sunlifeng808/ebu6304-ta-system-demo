<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Browse Jobs" />
<%@ include file="includes/header.jspf" %>

<section class="section-header">
    <h2>Available TA Jobs</h2>
    <p>Browse all open positions and view the required skills before applying.</p>
</section>

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
                       href="${pageContext.request.contextPath}/jobs/detail?id=${job.id}">View Detail</a>
                    <c:if test="${appliedJobMap[job.id]}">
                        <span class="badge badge-info">Applied</span>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty jobs}">
            <tr>
                <td colspan="6" class="empty-row">No jobs are available right now.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<%@ include file="includes/footer.jspf" %>
