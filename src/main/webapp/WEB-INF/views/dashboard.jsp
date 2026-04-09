<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Dashboard" />
<%@ include file="includes/header.jspf" %>

<section class="hero-card">
    <h2>Welcome, ${sessionScope.currentUser.fullName}</h2>
    <p>
        <c:choose>
            <c:when test="${sessionScope.currentUser.role == 'APPLICANT'}">
                You can edit your profile, browse TA positions, and track your application status.
            </c:when>
            <c:when test="${sessionScope.currentUser.role == 'MO'}">
                You can create TA jobs, review applicants, and update application results.
            </c:when>
            <c:otherwise>
                You can review the overall TA workload and quickly identify overloaded applicants.
            </c:otherwise>
        </c:choose>
    </p>
</section>

<div class="grid-two">
    <c:if test="${sessionScope.currentUser.role == 'APPLICANT'}">
        <div class="card">
            <h3>Applicant Panel</h3>
            <p>Open Jobs: <strong>${openJobCount}</strong></p>
            <p>My Applications: <strong>${myApplicationCount}</strong></p>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/jobs">Browse Jobs</a>
        </div>
        <div class="card">
            <h3>Profile</h3>
            <p>Keep your skills updated so the system can compute a clearer match score.</p>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/applicant/profile">Edit Profile</a>
        </div>
    </c:if>

    <c:if test="${sessionScope.currentUser.role == 'MO'}">
        <div class="card">
            <h3>MO Panel</h3>
            <p>My Posted Jobs: <strong>${myJobCount}</strong></p>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/mo/jobs">View My Jobs</a>
        </div>
        <div class="card">
            <h3>Create New Job</h3>
            <p>Post a new TA position and start collecting applications.</p>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/mo/jobs/create">Create Job</a>
        </div>
    </c:if>

    <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
        <div class="card">
            <h3>Admin Panel</h3>
            <p>Applicants in System: <strong>${summaryCount}</strong></p>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/workload">View Workload</a>
        </div>
        <div class="card">
            <h3>Workload Rule</h3>
            <p>Applicants with accepted workload above 10 hours are marked as overloaded.</p>
        </div>
    </c:if>
</div>

<%@ include file="includes/footer.jspf" %>
