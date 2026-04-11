# `src` 目录代码提交分工

依据 [DEMONSTRATION.md](./DEMONSTRATION.md) 中的分工说明，结合当前 `src` 目录实际文件结构，提交责任按以下原则划分：

- 以文件为最小单位，每个文件只归属一人。
- 尽可能按整个包划分，只有在 `servlet`、`service` 这类天然跨角色包中才细分到文件。
- `B` 负责测试与联调，不承担 `src` 目录代码提交责任。
- 以下划分已覆盖当前 `src` 下全部文件，无遗漏、无重复。

## A：前端与页面层

负责整个 `src/main/webapp/` 包下全部文件：

- `src/main/webapp/index.jsp`
- `src/main/webapp/WEB-INF/web.xml`
- `src/main/webapp/WEB-INF/views/includes/header.jspf`
- `src/main/webapp/WEB-INF/views/includes/footer.jspf`
- `src/main/webapp/WEB-INF/views/login.jsp`
- `src/main/webapp/WEB-INF/views/dashboard.jsp`
- `src/main/webapp/WEB-INF/views/applicant-profile.jsp`
- `src/main/webapp/WEB-INF/views/job-list.jsp`
- `src/main/webapp/WEB-INF/views/job-detail.jsp`
- `src/main/webapp/WEB-INF/views/my-applications.jsp`
- `src/main/webapp/WEB-INF/views/mo-jobs.jsp`
- `src/main/webapp/WEB-INF/views/create-job.jsp`
- `src/main/webapp/WEB-INF/views/mo-applications.jsp`
- `src/main/webapp/WEB-INF/views/admin-workload.jsp`
- `src/main/webapp/WEB-INF/views/error.jsp`
- `src/main/webapp/assets/css/style.css`
- `src/main/webapp/assets/js/main.js`

## C：基础设施、认证与启动初始化

负责以下完整包：

- `src/main/java/com/bupt/tarecruitment/listener/`
- `src/main/java/com/bupt/tarecruitment/util/`

负责以下系统入口与认证相关文件：

- `src/main/java/com/bupt/tarecruitment/servlet/BaseServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/LoginServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/RegisterServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/LogoutServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/DashboardServlet.java`
- `src/main/java/com/bupt/tarecruitment/service/AuthService.java`

负责以下运行初始化数据文件：

- `src/main/resources/data/users.json`
- `src/main/resources/data/jobs.json`
- `src/main/resources/data/applications.json`

## D：Applicant 业务后端

负责以下 Applicant 业务相关文件：

- `src/main/java/com/bupt/tarecruitment/servlet/ApplicantProfileServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/JobListServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/JobDetailServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/ApplyJobServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/MyApplicationsServlet.java`
- `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java`

## E：MO 业务后端

负责以下 MO 业务相关文件：

- `src/main/java/com/bupt/tarecruitment/servlet/MOJobsServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/JobCreateServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/MOApplicationsServlet.java`
- `src/main/java/com/bupt/tarecruitment/servlet/UpdateApplicationStatusServlet.java`
- `src/main/java/com/bupt/tarecruitment/service/JobService.java`

## F：数据模型、Repository、匹配分析与统计

负责以下完整包：

- `src/main/java/com/bupt/tarecruitment/model/`
- `src/main/java/com/bupt/tarecruitment/repository/`

负责以下分析与统计相关文件：

- `src/main/java/com/bupt/tarecruitment/service/MatchService.java`
- `src/main/java/com/bupt/tarecruitment/service/WorkloadService.java`
- `src/main/java/com/bupt/tarecruitment/servlet/AdminWorkloadServlet.java`

## B：测试与联调

- `B` 不承担 `src` 目录代码提交责任。
- `B` 的职责保留为测试、联调、验收和演示链路检查。
