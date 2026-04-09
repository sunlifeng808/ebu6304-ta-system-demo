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
<body class="login-body" data-page-title-key="page.login" data-context-path="${pageContext.request.contextPath}">
<div class="login-shell">
    <section class="login-hero">
        <p class="login-kicker" data-i18n="brand.subtitle">BUPT International School</p>
        <h1 data-i18n="brand.title">TA Recruitment System</h1>
        <p class="login-copy" data-i18n="login.intro">Switch between roles, review applications quickly, and manage the TA process in one cleaner workspace.</p>

        <div class="login-feature-grid">
            <div class="feature-card">
                <strong data-i18n="login.highlightApplicantTitle">Applicants</strong>
                <p data-i18n="login.highlightApplicantDesc">Maintain profiles, compare matches, and track applications.</p>
            </div>
            <div class="feature-card">
                <strong data-i18n="login.highlightMoTitle">Module Organisers</strong>
                <p data-i18n="login.highlightMoDesc">Create positions and update results from one place.</p>
            </div>
            <div class="feature-card">
                <strong data-i18n="login.highlightAdminTitle">Administrators</strong>
                <p data-i18n="login.highlightAdminDesc">Monitor accepted workload and spot overload risks early.</p>
            </div>
        </div>
    </section>

    <section class="login-card">
        <div class="login-card-top">
            <div>
                <p class="workspace-kicker" data-i18n="login.formTitle">Sign in</p>
                <h2 data-i18n="login.systemTitle">Teaching Assistant Recruitment System</h2>
                <p class="login-note" data-i18n="login.formDesc">Use the demo accounts below or your own project credentials.</p>
            </div>
            <button class="lang-switch" type="button" data-lang-toggle>中文</button>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" class="form-card">
            <label for="username" data-i18n="login.username">Username</label>
            <input id="username" name="username" type="text" value="${username}"
                   data-i18n-placeholder="login.usernamePlaceholder" placeholder="Enter username">

            <label for="password" data-i18n="login.password">Password</label>
            <input id="password" name="password" type="password"
                   data-i18n-placeholder="login.passwordPlaceholder" placeholder="Enter password">

            <button class="btn btn-primary btn-block" data-i18n="action.login" type="submit">Login</button>
        </form>

        <div class="demo-box">
            <h3 data-i18n="login.demoTitle">Demo Accounts</h3>
            <ul>
                <li><span data-i18n="login.demoApplicant">Applicant</span>: applicant1 / 123456</li>
                <li><span data-i18n="login.demoMo">Module Organiser</span>: mo1 / 123456</li>
                <li><span data-i18n="login.demoAdmin">Administrator</span>: admin1 / 123456</li>
            </ul>
        </div>
    </section>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
