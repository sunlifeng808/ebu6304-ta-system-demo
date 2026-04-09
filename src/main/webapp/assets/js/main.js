document.addEventListener("DOMContentLoaded", function () {
    var STORAGE_KEY = "ta-language";
    var translations = {
        en: {
            "brand.title": "TA Recruitment System",
            "brand.subtitle": "BUPT International School",
            "workspace.kicker": "Recruitment Workspace",
            "sidebar.account": "Current Account",
            "page.dashboard": "Dashboard",
            "page.jobs": "Browse Jobs",
            "page.jobDetail": "Job Detail",
            "page.profile": "My Profile",
            "page.myApplications": "My Applications",
            "page.myJobs": "My Jobs",
            "page.jobApplications": "Applications",
            "page.createJob": "Create Job",
            "page.workload": "Workload Overview",
            "page.error": "Error",
            "page.login": "Login",
            "nav.dashboard": "Dashboard",
            "nav.profile": "My Profile",
            "nav.jobs": "Browse Jobs",
            "nav.myApplications": "My Applications",
            "nav.moJobs": "My Jobs",
            "nav.createJob": "Create Job",
            "nav.workload": "Workload Overview",
            "action.logout": "Logout",
            "action.login": "Login",
            "action.save": "Save",
            "action.saveProfile": "Save Profile",
            "action.browseJobs": "Browse Jobs",
            "action.editProfile": "Edit Profile",
            "action.createJob": "Create Job",
            "action.viewMyJobs": "View My Jobs",
            "action.viewWorkload": "View Workload",
            "action.viewDetail": "View Detail",
            "action.viewApplications": "View Applications",
            "action.goBack": "Go Back",
            "action.returnDashboard": "Return to Dashboard",
            "action.applyNow": "Apply Now",
            "role.APPLICANT": "Applicant",
            "role.MO": "Module Organiser",
            "role.ADMIN": "Administrator",
            "status.Pending": "Pending",
            "status.Accepted": "Accepted",
            "status.Rejected": "Rejected",
            "status.Open": "Open",
            "status.Normal": "Normal",
            "status.Overloaded": "Overloaded",
            "status.Applied": "Applied",
            "status.AlreadyApplied": "You already applied",
            "common.title": "Title",
            "common.jobTitle": "Job Title",
            "common.module": "Module",
            "common.description": "Description",
            "common.hours": "Hours",
            "common.requiredSkills": "Required Skills",
            "common.status": "Status",
            "common.action": "Action",
            "common.none": "None",
            "dashboard.welcome": "Welcome,",
            "dashboard.applicantIntro": "You can edit your profile, browse TA positions, and track your application status.",
            "dashboard.moIntro": "You can create TA jobs, review applicants, and update application results.",
            "dashboard.adminIntro": "You can review the overall TA workload and quickly identify overloaded applicants.",
            "dashboard.applicantPanel": "Applicant Panel",
            "dashboard.openJobs": "Open Jobs",
            "dashboard.myApplications": "My Applications",
            "dashboard.profileTitle": "Profile",
            "dashboard.profileDesc": "Keep your skills updated so the system can compute a clearer match score.",
            "dashboard.moPanel": "MO Panel",
            "dashboard.myPostedJobs": "My Posted Jobs",
            "dashboard.newJobTitle": "Create New Job",
            "dashboard.newJobDesc": "Post a new TA position and start collecting applications.",
            "dashboard.adminPanel": "Admin Panel",
            "dashboard.applicantsInSystem": "Applicants in System",
            "dashboard.workloadRuleTitle": "Workload Rule",
            "dashboard.workloadRuleDesc": "Applicants with accepted workload above 10 hours are marked as overloaded.",
            "jobList.heading": "Available TA Jobs",
            "jobList.desc": "Browse all open positions and view the required skills before applying.",
            "jobList.empty": "No jobs are available right now.",
            "jobDetail.matchTitle": "Match Result",
            "jobDetail.submitted": "Application submitted successfully.",
            "jobDetail.duplicate": "You have already applied for this job.",
            "jobDetail.matchScore": "Match Score",
            "jobDetail.matchedSkills": "Matched Skills",
            "jobDetail.missingSkills": "Missing Skills",
            "profile.heading": "Applicant Profile",
            "profile.desc": "Update your name, email and skills for better matching.",
            "profile.updated": "Profile updated successfully.",
            "profile.fullName": "Full Name",
            "profile.email": "Email",
            "profile.skills": "Skills",
            "profile.skillsPlaceholder": "Java, Excel, Communication",
            "profile.skillsHint": "Use comma-separated skills, for example: Java, Python, Communication",
            "applications.heading": "My Application Records",
            "applications.desc": "Track the latest result of each job application.",
            "applications.appliedAt": "Applied At",
            "applications.empty": "You have not submitted any applications yet.",
            "moJobs.heading": "My Posted Jobs",
            "moJobs.desc": "Manage the jobs you have created and review all applicants.",
            "moJobs.created": "Job created successfully.",
            "moJobs.empty": "You have not created any jobs yet.",
            "moApplications.heading": "Applications for",
            "moApplications.updated": "Application status updated successfully.",
            "moApplications.applicant": "Applicant",
            "moApplications.matchScore": "Match Score",
            "moApplications.missingSkills": "Missing Skills",
            "moApplications.update": "Update",
            "moApplications.empty": "No applicants yet for this job.",
            "createJob.heading": "Create a New TA Job",
            "createJob.desc": "Fill in the position information below.",
            "createJob.jobTitle": "Job Title",
            "createJob.moduleName": "Module / Activity Name",
            "createJob.description": "Description",
            "createJob.requiredSkills": "Required Skills",
            "createJob.requiredSkillsPlaceholder": "Java, Python, Communication",
            "createJob.workloadHours": "Workload Hours",
            "admin.heading": "Applicant Workload Overview",
            "admin.thresholdPrefix": "Applicants above",
            "admin.thresholdSuffix": "accepted hours are marked as overloaded.",
            "admin.applicantName": "Applicant Name",
            "admin.acceptedJobsCount": "Accepted Jobs Count",
            "admin.totalHours": "Total Hours",
            "admin.workloadStatus": "Workload Status",
            "admin.empty": "No applicant workload data found.",
            "error.heading": "Something went wrong",
            "login.systemTitle": "Teaching Assistant Recruitment System",
            "login.intro": "Switch between roles, review applications quickly, and manage the TA process in one cleaner workspace.",
            "login.highlightApplicantTitle": "Applicants",
            "login.highlightApplicantDesc": "Maintain profiles, compare matches, and track applications.",
            "login.highlightMoTitle": "Module Organisers",
            "login.highlightMoDesc": "Create positions and update results from one place.",
            "login.highlightAdminTitle": "Administrators",
            "login.highlightAdminDesc": "Monitor accepted workload and spot overload risks early.",
            "login.formTitle": "Sign in",
            "login.formDesc": "Use the demo accounts below or your own project credentials.",
            "login.username": "Username",
            "login.password": "Password",
            "login.usernamePlaceholder": "Enter username",
            "login.passwordPlaceholder": "Enter password",
            "login.demoTitle": "Demo Accounts",
            "login.demoApplicant": "Applicant",
            "login.demoMo": "Module Organiser",
            "login.demoAdmin": "Administrator",
            "confirm.submitApplication": "Submit application for this job?",
            "confirm.updateApplication": "Update this application status?"
        },
        zh: {
            "brand.title": "助教招聘系统",
            "brand.subtitle": "北邮国际学院",
            "workspace.kicker": "招聘工作台",
            "sidebar.account": "当前账号",
            "page.dashboard": "控制台",
            "page.jobs": "岗位浏览",
            "page.jobDetail": "岗位详情",
            "page.profile": "我的资料",
            "page.myApplications": "我的申请",
            "page.myJobs": "我的岗位",
            "page.jobApplications": "申请列表",
            "page.createJob": "创建岗位",
            "page.workload": "工作量总览",
            "page.error": "错误",
            "page.login": "登录",
            "nav.dashboard": "控制台",
            "nav.profile": "我的资料",
            "nav.jobs": "浏览岗位",
            "nav.myApplications": "我的申请",
            "nav.moJobs": "我的岗位",
            "nav.createJob": "创建岗位",
            "nav.workload": "工作量总览",
            "action.logout": "退出登录",
            "action.login": "登录",
            "action.save": "保存",
            "action.saveProfile": "保存资料",
            "action.browseJobs": "浏览岗位",
            "action.editProfile": "编辑资料",
            "action.createJob": "创建岗位",
            "action.viewMyJobs": "查看岗位",
            "action.viewWorkload": "查看总览",
            "action.viewDetail": "查看详情",
            "action.viewApplications": "查看申请",
            "action.goBack": "返回上一页",
            "action.returnDashboard": "返回控制台",
            "action.applyNow": "立即申请",
            "role.APPLICANT": "申请人",
            "role.MO": "课程负责人",
            "role.ADMIN": "管理员",
            "status.Pending": "待处理",
            "status.Accepted": "已录用",
            "status.Rejected": "已拒绝",
            "status.Open": "开放中",
            "status.Normal": "正常",
            "status.Overloaded": "超负荷",
            "status.Applied": "已申请",
            "status.AlreadyApplied": "你已申请过该岗位",
            "common.title": "标题",
            "common.jobTitle": "岗位名称",
            "common.module": "课程 / 模块",
            "common.description": "描述",
            "common.hours": "工时",
            "common.requiredSkills": "所需技能",
            "common.status": "状态",
            "common.action": "操作",
            "common.none": "无",
            "dashboard.welcome": "欢迎，",
            "dashboard.applicantIntro": "你可以维护个人资料、浏览助教岗位，并持续跟进申请状态。",
            "dashboard.moIntro": "你可以创建助教岗位、审核申请人，并更新申请结果。",
            "dashboard.adminIntro": "你可以查看整体助教工作量，并快速识别超负荷的申请人。",
            "dashboard.applicantPanel": "申请人面板",
            "dashboard.openJobs": "开放岗位数",
            "dashboard.myApplications": "我的申请数",
            "dashboard.profileTitle": "个人资料",
            "dashboard.profileDesc": "及时更新你的技能信息，系统才能给出更准确的匹配分数。",
            "dashboard.moPanel": "课程负责人面板",
            "dashboard.myPostedJobs": "已发布岗位数",
            "dashboard.newJobTitle": "创建新岗位",
            "dashboard.newJobDesc": "发布新的助教岗位并开始收集申请。",
            "dashboard.adminPanel": "管理员面板",
            "dashboard.applicantsInSystem": "系统申请人数",
            "dashboard.workloadRuleTitle": "工作量规则",
            "dashboard.workloadRuleDesc": "录用工时超过 10 小时的申请人会被标记为超负荷。",
            "jobList.heading": "当前开放的助教岗位",
            "jobList.desc": "浏览所有开放岗位，并在申请前查看所需技能。",
            "jobList.empty": "当前暂无可申请岗位。",
            "jobDetail.matchTitle": "匹配结果",
            "jobDetail.submitted": "申请已成功提交。",
            "jobDetail.duplicate": "你已经申请过这个岗位。",
            "jobDetail.matchScore": "匹配分数",
            "jobDetail.matchedSkills": "已匹配技能",
            "jobDetail.missingSkills": "缺失技能",
            "profile.heading": "申请人资料",
            "profile.desc": "更新你的姓名、邮箱和技能信息，以获得更好的匹配结果。",
            "profile.updated": "资料更新成功。",
            "profile.fullName": "姓名",
            "profile.email": "邮箱",
            "profile.skills": "技能",
            "profile.skillsPlaceholder": "Java, Excel, 沟通协作",
            "profile.skillsHint": "请用英文逗号分隔技能，例如：Java, Python, Communication",
            "applications.heading": "我的申请记录",
            "applications.desc": "跟踪每个岗位申请的最新处理结果。",
            "applications.appliedAt": "申请时间",
            "applications.empty": "你还没有提交任何申请。",
            "moJobs.heading": "我发布的岗位",
            "moJobs.desc": "管理你创建的岗位，并查看所有申请人。",
            "moJobs.created": "岗位创建成功。",
            "moJobs.empty": "你还没有创建任何岗位。",
            "moApplications.heading": "岗位申请：",
            "moApplications.updated": "申请状态更新成功。",
            "moApplications.applicant": "申请人",
            "moApplications.matchScore": "匹配分数",
            "moApplications.missingSkills": "缺失技能",
            "moApplications.update": "更新",
            "moApplications.empty": "该岗位暂时还没有申请人。",
            "createJob.heading": "创建新的助教岗位",
            "createJob.desc": "请填写下面的岗位信息。",
            "createJob.jobTitle": "岗位标题",
            "createJob.moduleName": "课程 / 活动名称",
            "createJob.description": "岗位描述",
            "createJob.requiredSkills": "所需技能",
            "createJob.requiredSkillsPlaceholder": "Java, Python, Communication",
            "createJob.workloadHours": "工作量小时数",
            "admin.heading": "申请人工作量总览",
            "admin.thresholdPrefix": "录用工时超过",
            "admin.thresholdSuffix": "小时的申请人会被标记为超负荷。",
            "admin.applicantName": "申请人姓名",
            "admin.acceptedJobsCount": "录用岗位数",
            "admin.totalHours": "总工时",
            "admin.workloadStatus": "工作量状态",
            "admin.empty": "未找到申请人的工作量数据。",
            "error.heading": "出现了一些问题",
            "login.systemTitle": "Teaching Assistant Recruitment System",
            "login.intro": "在同一套更清晰的工作台中切换角色、快速审阅申请并管理助教招聘流程。",
            "login.highlightApplicantTitle": "申请人",
            "login.highlightApplicantDesc": "维护资料、查看匹配结果并持续跟踪申请。",
            "login.highlightMoTitle": "课程负责人",
            "login.highlightMoDesc": "统一创建岗位并更新申请结果。",
            "login.highlightAdminTitle": "管理员",
            "login.highlightAdminDesc": "监控录用工时，及时识别超负荷风险。",
            "login.formTitle": "登录系统",
            "login.formDesc": "可直接使用下方演示账号，或输入你自己的项目账号。",
            "login.username": "用户名",
            "login.password": "密码",
            "login.usernamePlaceholder": "请输入用户名",
            "login.passwordPlaceholder": "请输入密码",
            "login.demoTitle": "演示账号",
            "login.demoApplicant": "申请人",
            "login.demoMo": "课程负责人",
            "login.demoAdmin": "管理员",
            "confirm.submitApplication": "确认提交该岗位申请吗？",
            "confirm.updateApplication": "确认更新该申请状态吗？"
        }
    };

    function getLanguage() {
        var stored = window.localStorage.getItem(STORAGE_KEY);
        if (stored === "zh" || stored === "en") {
            return stored;
        }
        return (window.navigator.language || "").toLowerCase().indexOf("zh") === 0 ? "zh" : "en";
    }

    function t(key, lang) {
        var locale = translations[lang] || translations.en;
        return locale[key] || translations.en[key] || key;
    }

    function translateTextNodes(lang) {
        var elements = document.querySelectorAll("[data-i18n]");
        for (var i = 0; i < elements.length; i++) {
            var key = elements[i].getAttribute("data-i18n");
            elements[i].textContent = t(key, lang);
        }
    }

    function translatePlaceholders(lang) {
        var fields = document.querySelectorAll("[data-i18n-placeholder]");
        for (var i = 0; i < fields.length; i++) {
            var key = fields[i].getAttribute("data-i18n-placeholder");
            fields[i].setAttribute("placeholder", t(key, lang));
        }
    }

    function translateStatuses(lang) {
        var statusElements = document.querySelectorAll("[data-status-label]");
        for (var i = 0; i < statusElements.length; i++) {
            var status = statusElements[i].getAttribute("data-status-label");
            statusElements[i].textContent = t("status." + status, lang);
        }

        var roleElements = document.querySelectorAll("[data-role-label]");
        for (var j = 0; j < roleElements.length; j++) {
            var role = roleElements[j].getAttribute("data-role-label");
            roleElements[j].textContent = t("role." + role, lang);
        }

        var statusOptions = document.querySelectorAll("[data-status-option]");
        for (var k = 0; k < statusOptions.length; k++) {
            var optionStatus = statusOptions[k].getAttribute("data-status-option");
            statusOptions[k].textContent = t("status." + optionStatus, lang);
        }
    }

    function updateDocumentTitle(lang) {
        var titleKey = document.body.getAttribute("data-page-title-key");
        if (!titleKey) {
            return;
        }
        document.title = t(titleKey, lang) + " - " + t("brand.title", lang);
    }

    function updateToggleLabels(lang) {
        var nextLabel = lang === "zh" ? "EN" : "中文";
        var toggles = document.querySelectorAll("[data-lang-toggle]");
        for (var i = 0; i < toggles.length; i++) {
            toggles[i].textContent = nextLabel;
        }
    }

    function translatePage(lang) {
        document.documentElement.setAttribute("lang", lang === "zh" ? "zh-CN" : "en");
        translateTextNodes(lang);
        translatePlaceholders(lang);
        translateStatuses(lang);
        updateDocumentTitle(lang);
        updateToggleLabels(lang);
        document.body.setAttribute("data-language", lang);
    }

    function resolveMessage(form, lang) {
        var key = form.getAttribute("data-confirm-key");
        if (key) {
            return t(key, lang);
        }
        return form.getAttribute("data-confirm");
    }

    function setupConfirmForms() {
        var forms = document.querySelectorAll("form[data-confirm], form[data-confirm-key]");
        for (var i = 0; i < forms.length; i++) {
            forms[i].addEventListener("submit", function (event) {
                var message = resolveMessage(this, getLanguage());
                if (message && !window.confirm(message)) {
                    event.preventDefault();
                }
            });
        }
    }

    function setupLanguageToggle() {
        var toggles = document.querySelectorAll("[data-lang-toggle]");
        for (var i = 0; i < toggles.length; i++) {
            toggles[i].addEventListener("click", function () {
                var next = getLanguage() === "zh" ? "en" : "zh";
                window.localStorage.setItem(STORAGE_KEY, next);
                translatePage(next);
            });
        }
    }

    function setupSidebar() {
        var toggle = document.querySelector("[data-sidebar-toggle]");
        var close = document.querySelector("[data-sidebar-close]");
        var navLinks = document.querySelectorAll(".nav-link");

        if (toggle) {
            toggle.addEventListener("click", function () {
                document.body.classList.toggle("sidebar-open");
            });
        }

        if (close) {
            close.addEventListener("click", function () {
                document.body.classList.remove("sidebar-open");
            });
        }

        for (var i = 0; i < navLinks.length; i++) {
            navLinks[i].addEventListener("click", function () {
                document.body.classList.remove("sidebar-open");
            });
        }
    }

    function setupActiveNav() {
        var contextPath = document.body.getAttribute("data-context-path") || "";
        var currentPath = window.location.pathname;

        if (contextPath && currentPath.indexOf(contextPath) === 0) {
            currentPath = currentPath.substring(contextPath.length);
        }

        var links = document.querySelectorAll("[data-nav-match]");
        var bestLink = null;
        var bestLength = -1;

        for (var i = 0; i < links.length; i++) {
            var patterns = links[i].getAttribute("data-nav-match").split(",");
            for (var j = 0; j < patterns.length; j++) {
                var pattern = patterns[j].trim();
                var isMatch = currentPath === pattern || currentPath.indexOf(pattern + "/") === 0;
                if (isMatch && pattern.length > bestLength) {
                    bestLink = links[i];
                    bestLength = pattern.length;
                }
            }
        }

        if (bestLink) {
            bestLink.classList.add("is-active");
        }
    }

    translatePage(getLanguage());
    setupLanguageToggle();
    setupConfirmForms();
    setupSidebar();
    setupActiveNav();
});
