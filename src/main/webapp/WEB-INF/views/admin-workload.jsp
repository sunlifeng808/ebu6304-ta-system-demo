<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Workload Overview" />
<%@ include file="includes/header.jspf" %>

<section class="section-header">
    <h2>Applicant Workload Overview</h2>
    <p>Applicants above ${threshold} accepted hours are marked as overloaded.</p>
</section>

<div class="table-card">
    <table>
        <thead>
        <tr>
            <th>Applicant Name</th>
            <th>Email</th>
            <th>Accepted Jobs Count</th>
            <th>Total Hours</th>
            <th>Workload Status</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${workloadSummaries}" var="item">
            <tr>
                <td>${item.applicant.fullName}</td>
                <td>${item.applicant.email}</td>
                <td>${item.acceptedJobsCount}</td>
                <td>${item.totalHours}</td>
                <td>
                    <span class="badge badge-${item.workloadStatus}">${item.workloadStatus}</span>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty workloadSummaries}">
            <tr>
                <td colspan="5" class="empty-row">No applicant workload data found.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<%@ include file="includes/footer.jspf" %>
