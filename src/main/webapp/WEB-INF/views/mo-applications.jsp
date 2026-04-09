<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Applications" />
<%@ include file="includes/header.jspf" %>

<section class="section-header">
    <h2>Applications for ${job.title}</h2>
    <p>Module: ${job.moduleName} | Hours: ${job.hours}</p>
</section>

<c:if test="${param.msg == 'updated'}">
    <div class="alert alert-success">Application status updated successfully.</div>
</c:if>

<div class="table-card">
    <table>
        <thead>
        <tr>
            <th>Applicant</th>
            <th>Email</th>
            <th>Skills</th>
            <th>Match Score</th>
            <th>Missing Skills</th>
            <th>Status</th>
            <th>Update</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${applicationDisplays}" var="item">
            <tr>
                <td>${item.applicant.fullName}</td>
                <td>${item.applicant.email}</td>
                <td>${fn:join(item.applicant.skills, ', ')}</td>
                <td>${item.matchResult.score}%</td>
                <td>
                    <c:choose>
                        <c:when test="${empty item.matchResult.missingSkills}">None</c:when>
                        <c:otherwise>${fn:join(item.matchResult.missingSkills, ', ')}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <span class="badge badge-${item.application.status}">${item.application.status}</span>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/mo/application/update" method="post" class="inline-form"
                          data-confirm="Update this application status?">
                        <input type="hidden" name="applicationId" value="${item.application.id}">
                        <input type="hidden" name="jobId" value="${job.id}">
                        <select name="status">
                            <option value="Pending" <c:if test="${item.application.status == 'Pending'}">selected</c:if>>Pending</option>
                            <option value="Accepted" <c:if test="${item.application.status == 'Accepted'}">selected</c:if>>Accepted</option>
                            <option value="Rejected" <c:if test="${item.application.status == 'Rejected'}">selected</c:if>>Rejected</option>
                        </select>
                        <button class="btn btn-primary btn-small" type="submit">Save</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty applicationDisplays}">
            <tr>
                <td colspan="7" class="empty-row">No applicants yet for this job.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<%@ include file="includes/footer.jspf" %>
