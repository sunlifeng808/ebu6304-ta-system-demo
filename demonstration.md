# TA Recruitment System 项目讲解与六人分工说明

## 1. 项目整体结构

- 这个项目是一个典型的 `JSP / Servlet / Service / Repository / JSON` 分层 Java Web 项目，主题是助教招聘。
- 业务闭环很完整：`登录或注册 -> 进入对应角色首页 -> Applicant 申请岗位 -> MO 审核申请 -> Admin 查看工作量统计`。
- 这类项目在课堂上最值得讲的不是技术多复杂，而是每一层职责都很清楚，所以老师能很快看懂系统是怎么跑起来的。
- 总体结构涉及这些核心文件：
  `src/main/webapp/WEB-INF/web.xml`
  `src/main/webapp/index.jsp`
  `src/main/java/com/bupt/tarecruitment/servlet/`
  `src/main/java/com/bupt/tarecruitment/service/`
  `src/main/java/com/bupt/tarecruitment/repository/`
  `src/main/java/com/bupt/tarecruitment/model/`
  `src/main/resources/data/`
- 其中最关键的工程设计点，是系统虽然用 JSON 做轻量存储，但运行时并不是直接去改包里的资源文件，而是先把种子数据复制到可写目录，再对副本读写。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/util/PathUtil.java:19-38`
  这里完成运行期数据目录初始化和种子文件复制。它的重要性在于，这段逻辑决定了系统能不能把 JSON 真正当成“可写数据源”来用。
- `src/main/java/com/bupt/tarecruitment/util/PathUtil.java:49-52`
  这里统一返回运行期数据文件路径，后面所有 Repository 都依赖它，因此它相当于数据层的统一入口。

- 总体联动关系可以概括为：JSP 负责展示和提交，Servlet 负责路由和权限，Service 负责业务规则，Repository 负责 JSON 读写，Model 负责把数据结构标准化。

## 2. A 负责前端与页面层

### A-1 公共页面骨架与导航

- 相关文件：
  `src/main/webapp/WEB-INF/views/includes/header.jspf`
  `src/main/webapp/WEB-INF/views/includes/footer.jspf`
- 这部分是全站公共外壳，统一负责标题区、侧边栏、角色导航、当前用户信息、语言切换按钮和公共脚本引入。
- 设计思路是“先做系统外壳，再做具体业务页面”。Applicant、MO、Admin 页面虽然内容不同，但都挂在同一个工作台框架下，所以系统整体感很强。
- 模块联动上，所有业务页都会先设置 `pageTitle` 和 `pageTitleKey`，再 include 公共头尾，所以标题、导航和页面基调能保持统一。

### A-2 登录与注册页面

- 相关文件：
  `src/main/webapp/WEB-INF/views/login.jsp`
  `src/main/webapp/assets/css/style.css`
  `src/main/webapp/assets/js/main.js`
- `login.jsp` 把登录和注册放在同一个入口里，通过 tab 切换模式，这样课堂展示时入口更统一，也更容易说明“Applicant 可注册，MO 和 Admin 用预置账号”。
- 设计思路是把认证入口做成一个完整场景，而不是拆成很多零散页面。学生第一次进入系统时，能很清楚知道自己是登录还是注册。
- 它和后端认证模块的联动非常明确：前端负责收集和切换表单，真正的账号合法性判断交给后端。

关键代码位置：
- `src/main/webapp/assets/js/main.js:600-635`
  这里的 `applyAuthMode` 和 `setupAuthMode` 负责切换登录/注册面板。它的重要性不在算法，而在于它把两个认证模式稳定地组织在同一个页面里。
- `src/main/webapp/assets/js/main.js:638-655`
  这里做的是注册确认密码的前端校验。它只是用户体验优化，不是最终规则来源，真正的校验仍在后端。

### A-3 Dashboard 页面

- 相关文件：
  `src/main/webapp/WEB-INF/views/dashboard.jsp`
- Dashboard 不是普通欢迎页，而是三种角色的统一入口页。
- 对 Applicant，它展示 open jobs 和 my applications；对 MO，它展示 my jobs；对 Admin，它展示 applicant 数量和 workload 规则。
- 设计思路是让三种角色都从同一个入口进入系统，但进入后立刻看到自己最关心的模块，这样演示和使用都不会乱。
- 它和后端的联动方式是“后端聚合数据，前端只负责展示”。页面本身不做统计，只接收 Servlet 放好的摘要值。

### A-4 Applicant 相关页面展示

- 相关文件：
  `src/main/webapp/WEB-INF/views/applicant-profile.jsp`
  `src/main/webapp/WEB-INF/views/job-list.jsp`
  `src/main/webapp/WEB-INF/views/job-detail.jsp`
  `src/main/webapp/WEB-INF/views/my-applications.jsp`
- `applicant-profile.jsp` 是 Applicant 输入信息的页面，尤其是 skills 和 self introduction，这些内容会直接影响后面的匹配和审核。
- `job-list.jsp` 负责岗位列表展示，它不是信息终点，而是把用户引到岗位详情页。
- `job-detail.jsp` 是 Applicant 页面里最重要的一页，因为它把岗位信息、匹配结果、缺失技能、申请状态都集中展示出来，帮助 Applicant 做决策。
- `my-applications.jsp` 把 Applicant 的历史申请收束成一个闭环，让用户知道自己做过什么、系统给了什么结果。
- 设计思路是按 Applicant 的自然路径组织页面：先完善资料，再看岗位，再看匹配，再看自己的结果，这样每个页面都有明确位置。

### A-5 MO 与 Admin 页面展示

- 相关文件：
  `src/main/webapp/WEB-INF/views/mo-jobs.jsp`
  `src/main/webapp/WEB-INF/views/create-job.jsp`
  `src/main/webapp/WEB-INF/views/mo-applications.jsp`
  `src/main/webapp/WEB-INF/views/admin-workload.jsp`
  `src/main/webapp/WEB-INF/views/error.jsp`
- `mo-jobs.jsp` 先从岗位视角组织 MO 功能，让 MO 先看到自己拥有哪些岗位。
- `create-job.jsp` 是岗位发布入口，强调结构化输入，方便快速建岗位。
- `mo-applications.jsp` 是 MO 最重要的页面，因为它把 Applicant 信息、技能、匹配结果和状态更新放在一起，方便直接审核。
- `admin-workload.jsp` 则把 Admin 关注点压缩成一张管理表：谁被录用了、总工时多少、有没有超负荷。
- `error.jsp` 是公共兜底页，负责统一处理资源不存在、权限不够、参数异常这类情况。

### A-6 样式与前端脚本

- 相关文件：
  `src/main/webapp/assets/css/style.css`
  `src/main/webapp/assets/js/main.js`
- `style.css` 主要统一工作台布局、卡片、表格、登录页和响应式侧边栏，而不是单纯做视觉美化。
- `main.js` 则把语言切换、导航高亮、确认弹窗、认证 tab 切换、侧边栏开关这些公共交互集中起来。
- 设计思路是让页面只负责声明结构和数据标记，把重复交互都收进统一脚本，避免每个 JSP 自己写脚本。
- 模块联动上，JSP 通过 `data-i18n`、`data-nav-match`、`data-confirm-key` 这类标记把需求交给 `main.js`，属于“结构层声明，脚本层接管”。

## 3. B 负责测试与联调

### B-1 测试基线与演示数据

- 相关文件：
  `src/main/resources/data/users.json`
  `src/main/resources/data/jobs.json`
  `src/main/resources/data/applications.json`
  `src/main/java/com/bupt/tarecruitment/listener/DataBootstrapListener.java`
- 测试成员最重要的工作不是单独写某个类，而是保证主链路、初始数据和边界场景都处于可控状态。
- 三个 JSON 文件分别代表用户、岗位、申请记录，它们决定了演示一开始系统是什么状态。
- 因为系统启动时会复制种子数据到运行期目录，所以测试成员必须知道“初始数据在哪里”和“运行期实际改的是哪一份数据”。

### B-2 主链路测试

- 相关文件：
  `src/main/webapp/WEB-INF/web.xml`
  `src/main/java/com/bupt/tarecruitment/servlet/LoginServlet.java`
  `src/main/java/com/bupt/tarecruitment/servlet/ApplicantProfileServlet.java`
  `src/main/java/com/bupt/tarecruitment/servlet/ApplyJobServlet.java`
  `src/main/java/com/bupt/tarecruitment/servlet/MOApplicationsServlet.java`
  `src/main/java/com/bupt/tarecruitment/servlet/UpdateApplicationStatusServlet.java`
  `src/main/java/com/bupt/tarecruitment/servlet/AdminWorkloadServlet.java`
- 主链路测试要覆盖四段：登录或注册、Applicant 提交申请、MO 审核、Admin 查看统计。
- 设计思路不是测“某个页面能否打开”，而是测“一个角色做出的动作，能不能在下一个角色那里产生正确结果”。

### B-3 规则测试与边界测试

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/service/AuthService.java`
  `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java`
  `src/main/java/com/bupt/tarecruitment/service/WorkloadService.java`
  `src/main/java/com/bupt/tarecruitment/servlet/BaseServlet.java`
- 这里主要测四类规则：输入格式是否合法、是否允许重复申请、状态值是否合法、是否存在越权访问。
- 设计思路是把测试重点压在业务规则上，因为课堂项目最容易出问题的地方，不是页面样式，而是规则是否真的被后端保护住。

## 4. C 负责基础设施、认证模块与技术统筹

### C-1 路由入口与基础控制器

- 相关文件：
  `src/main/webapp/WEB-INF/web.xml`
  `src/main/java/com/bupt/tarecruitment/servlet/BaseServlet.java`
- `web.xml` 是整个系统的路由总表，老师看这个文件时能快速知道项目到底提供了哪些功能入口。
- `BaseServlet` 是后端公共控制层，统一处理登录校验、角色校验、错误跳转、UTF-8 设置和视图转发。
- 设计思路是把所有 Servlet 都会重复做的动作抽出来，让具体业务 Servlet 只关心自己的业务。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/servlet/BaseServlet.java:21-41`
  这里的 `requireLogin` 和 `requireRole` 是权限控制核心。它的重要性在于，系统不是只检查“有没有登录”，还检查“是不是正确角色”。
- `src/main/java/com/bupt/tarecruitment/servlet/BaseServlet.java:49-56`
  这里统一错误页和编码设置，让错误处理和字符集行为在所有页面里保持一致。

### C-2 启动期数据准备

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/listener/DataBootstrapListener.java`
  `src/main/java/com/bupt/tarecruitment/util/PathUtil.java`
  `src/main/java/com/bupt/tarecruitment/util/JsonFileUtil.java`
- 这组模块解决的是运行期数据落地问题。资源目录里的 JSON 更像初始数据，不适合直接拿来当长期可写数据。
- `DataBootstrapListener` 负责在应用启动时触发初始化；`PathUtil` 决定运行期数据目录；`JsonFileUtil` 提供稳定的 JSON 读写。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/util/PathUtil.java:19-38`
  这里会检查运行期数据目录是否存在，不存在就创建，并把种子数据复制过去。这段逻辑决定了项目能不能在不接数据库的情况下稳定运行。
- `src/main/java/com/bupt/tarecruitment/util/JsonFileUtil.java:27-64`
  这里统一处理 JSON 文件不存在、空内容、写入失败等情况，让上层 Repository 不需要重复处理底层文件问题。

### C-3 登录、注册与退出

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/LoginServlet.java`
  `src/main/java/com/bupt/tarecruitment/servlet/RegisterServlet.java`
  `src/main/java/com/bupt/tarecruitment/servlet/LogoutServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/AuthService.java`
  `src/main/java/com/bupt/tarecruitment/repository/UserRepository.java`
- `LoginServlet` 负责收用户名密码、调用认证服务并建立 Session。
- `RegisterServlet` 负责 Applicant 自助注册，成功后直接登录进入 profile 页面。
- `LogoutServlet` 负责销毁 Session，清空当前登录态。
- `AuthService` 是认证规则中心，负责用户名、邮箱、密码等规则校验。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/service/AuthService.java:28-58`
  这里完成 Applicant 注册对象的创建和落库前检查。它的重要性在于，系统不是随便收一个表单就写入，而是先保证账号数据结构对后续模块是可用的。
- `src/main/java/com/bupt/tarecruitment/service/AuthService.java:61-83`
  这里集中校验邮箱格式、用户名长度、密码长度和确认密码一致性，说明认证规则是由后端统一控制的。
- `src/main/java/com/bupt/tarecruitment/servlet/LoginServlet.java:24-43`
  这里在登录成功后重建 Session 并放入 `currentUser`，后续所有角色识别和权限判断都建立在这里。

### C-4 Dashboard 作为统一入口

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/DashboardServlet.java`
  `src/main/webapp/WEB-INF/views/dashboard.jsp`
- `DashboardServlet` 会根据用户角色决定给页面塞什么摘要数据，而不是让 JSP 自己判断和计算。
- 设计思路是统一入口、按角色分流。三类角色都从 `/dashboard` 进入系统，但看到的内容不同。
- 它的价值在于把整个系统从一个登录入口平稳分到三条业务路径上。

## 5. D 负责 Applicant 业务后端

### D-1 Applicant 资料维护

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/ApplicantProfileServlet.java`
  `src/main/java/com/bupt/tarecruitment/repository/UserRepository.java`
  `src/main/webapp/WEB-INF/views/applicant-profile.jsp`
- 这个模块负责让 Applicant 维护自己的姓名、邮箱、自我介绍和技能。
- 设计思路是把 profile 看成 Applicant 整条业务链的输入源，而不是一个孤立的个人主页。
- 更新后的 skills 和 self introduction 会直接影响后面的岗位匹配和 MO 审核页面展示。

### D-2 岗位列表浏览

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/JobListServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/JobService.java`
  `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java`
  `src/main/webapp/WEB-INF/views/job-list.jsp`
- 这个模块负责展示可申请岗位，并标记哪些岗位已经申请过。
- 设计思路不是在列表页展示所有细节，而是先做岗位概览，再引导用户进入岗位详情页。
- 它的联动价值在于，同时依赖岗位数据和申请记录数据，把“可看岗位”和“已投岗位”合并成一个 Applicant 能直接理解的页面。

### D-3 岗位详情与匹配展示

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/JobDetailServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/MatchService.java`
  `src/main/java/com/bupt/tarecruitment/repository/UserRepository.java`
  `src/main/webapp/WEB-INF/views/job-detail.jsp`
- 这是 Applicant 端最能体现设计思路的模块，因为它不仅展示岗位信息，还展示匹配分数、匹配技能、缺失技能和是否已申请。
- 设计思路非常明确：系统不替 Applicant 做决定，而是把关键比较结果直接展示出来，让选择更透明。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/servlet/JobDetailServlet.java:33-40`
  这里会同时拿 Applicant 资料、岗位要求和申请状态，然后生成 `matchResult` 和 `alreadyApplied`。它的重要性在于，这里把多个数据源真正串起来了。
- `src/main/java/com/bupt/tarecruitment/service/MatchService.java:10-31`
  这里是匹配核心，负责找交集和差集，再形成 score。逻辑不复杂，但它是 Applicant 页面里最有“分析感”的一段业务代码。

### D-4 提交申请与申请记录

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/ApplyJobServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java`
  `src/main/java/com/bupt/tarecruitment/servlet/MyApplicationsServlet.java`
  `src/main/webapp/WEB-INF/views/my-applications.jsp`
- `ApplyJobServlet` 接收申请动作，但真正的规则判断在 `ApplicationService`。
- `MyApplicationsServlet` 则从 Applicant 视角整理申请记录，让用户看到自己的申请结果，而不是回头去每个岗位里单独找。
- 设计思路是把“提交动作”和“结果回看”拆开，一个负责写数据，一个负责读数据。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java:23-40`
  这里完成岗位存在性检查、重复申请检查、状态默认值设置和申请记录生成，是 Applicant 写入链路的核心。
- `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java:43-45`
  这里专门负责查重，说明“是否已经申请过”被收敛成了独立规则，而不是散落在前端页面里。

## 6. E 负责 MO 业务后端

### E-1 我的岗位列表

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/MOJobsServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/JobService.java`
  `src/main/webapp/WEB-INF/views/mo-jobs.jsp`
- 这个模块负责从 MO 自己的视角看岗位，而不是看全站岗位。
- 设计思路是从“岗位归属”出发组织功能，而不是先从申请人出发。
- 这样后面的申请查看自然变成“进入某一个岗位，再看它下面有哪些申请”。

### E-2 创建岗位

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/JobCreateServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/JobService.java`
  `src/main/webapp/WEB-INF/views/create-job.jsp`
- `JobCreateServlet` 负责参数接收和表单合法性判断。
- `JobService.createJob` 负责把这些输入真正组装成 Job，并补全系统字段，比如 id、发布者和默认状态。
- 设计思路是把“输入校验”和“业务对象创建”拆到不同层，便于解释也便于维护。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/servlet/JobCreateServlet.java:23-55`
  这里负责把表单参数变成合格输入，尤其是 hours 的正整数校验。它的重要性在于，它挡住了最容易在课堂演示中出错的无效输入。
- `src/main/java/com/bupt/tarecruitment/service/JobService.java:41-52`
  这里真正创建 Job 对象并设置默认状态 `Open`，说明岗位创建不是简单传参，而是一次标准化对象生成。

### E-3 查看岗位下的申请列表

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/MOApplicationsServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java`
  `src/main/java/com/bupt/tarecruitment/service/MatchService.java`
  `src/main/java/com/bupt/tarecruitment/repository/UserRepository.java`
  `src/main/webapp/WEB-INF/views/mo-applications.jsp`
- 这是 MO 端最核心的模块，因为它把岗位、申请人、技能、匹配结果和状态更新都集中到一个页面里。
- 设计思路有两个重点：第一，先检查岗位是否存在以及是否属于当前 MO；第二，把分散的数据整理成 `ApplicationDisplay` 这样的页面对象，再交给 JSP。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/servlet/MOApplicationsServlet.java:27-37`
  这里先检查岗位存在性和岗位归属，它的重要性在于，系统权限不是只看角色，还看资源归属。
- `src/main/java/com/bupt/tarecruitment/servlet/MOApplicationsServlet.java:46-53`
  这里会读取申请记录、Applicant 资料并再次计算匹配结果，最后组装成展示对象。它说明这个模块本质上是一个聚合模块。

### E-4 更新申请状态

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/servlet/UpdateApplicationStatusServlet.java`
  `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java`
  `src/main/webapp/WEB-INF/views/mo-applications.jsp`
- 这个模块负责把 MO 的审核动作真正落到申请记录上。
- 设计思路是双层保护：Servlet 层检查资源存在和资源归属，Service 层检查状态值是否合法。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/servlet/UpdateApplicationStatusServlet.java:27-42`
  这里先检查 application、job 和 MO 的归属关系，再执行更新。它的重要性在于，系统保护的是“这个人能不能改这条记录”，而不只是“这个人是不是 MO”。
- `src/main/java/com/bupt/tarecruitment/service/ApplicationService.java:59-64`
  这里限制状态只能是 `Pending / Accepted / Rejected`，说明状态更新不是任意字符串写回，而是受业务规则约束的。

## 7. F 负责数据模型、Repository 与分析模块

### F-1 数据模型层

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/model/User.java`
  `src/main/java/com/bupt/tarecruitment/model/Applicant.java`
  `src/main/java/com/bupt/tarecruitment/model/MO.java`
  `src/main/java/com/bupt/tarecruitment/model/Admin.java`
  `src/main/java/com/bupt/tarecruitment/model/Job.java`
  `src/main/java/com/bupt/tarecruitment/model/ApplicationRecord.java`
  `src/main/java/com/bupt/tarecruitment/model/ApplicationDisplay.java`
  `src/main/java/com/bupt/tarecruitment/model/MatchResult.java`
  `src/main/java/com/bupt/tarecruitment/model/WorkloadSummary.java`
- Model 层负责把系统里的核心实体表达清楚。
- `User / Applicant / MO / Admin` 表示角色身份；`Job` 表示岗位；`ApplicationRecord` 表示申请行为；`ApplicationDisplay`、`MatchResult`、`WorkloadSummary` 则是为了展示和聚合结果而设计的对象。
- 设计思路是区分“基础实体”和“展示实体”，这样 JSP 页面就不需要自己去拼很多零散数据。

### F-2 Repository 层

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/repository/UserRepository.java`
  `src/main/java/com/bupt/tarecruitment/repository/JobRepository.java`
  `src/main/java/com/bupt/tarecruitment/repository/ApplicationRepository.java`
- Repository 层统一负责从 JSON 取数据和把数据写回 JSON，不参与复杂业务判断。
- `UserRepository` 负责用户查询和 Applicant 更新；`JobRepository` 负责岗位查询和保存；`ApplicationRepository` 负责申请查询、查重、保存和状态更新。
- 设计思路是让 Repository 保持朴素，把所有业务判断留在 Service 层。这样项目结构更清晰，以后如果要换数据库，替换成本也更低。

### F-3 匹配分析模块

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/service/MatchService.java`
  `src/main/java/com/bupt/tarecruitment/model/MatchResult.java`
- `MatchService` 负责把 Applicant skills 和岗位 requiredSkills 做标准化比较，产出匹配技能、缺失技能和分数。
- 设计思路不是做复杂算法，而是做可解释算法。课堂展示场景下，老师更关心“这个分数为什么这样来”，而不是模型多高级。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/service/MatchService.java:10-31`
  这里完成技能比较和分数计算。它的重要性在于，这段逻辑直接决定了 Applicant 和 MO 页面里最有“分析感”的展示结果。
- `src/main/java/com/bupt/tarecruitment/service/MatchService.java:33-42`
  这里做技能标准化，说明系统没有直接拿原始字符串生硬比较，而是先做清洗再比较，提高了结果稳定性。

### F-4 工作量统计模块

- 相关文件：
  `src/main/java/com/bupt/tarecruitment/service/WorkloadService.java`
  `src/main/java/com/bupt/tarecruitment/model/WorkloadSummary.java`
  `src/main/java/com/bupt/tarecruitment/servlet/AdminWorkloadServlet.java`
  `src/main/webapp/WEB-INF/views/admin-workload.jsp`
- 这个模块负责从 Admin 视角重新理解申请数据，不再关心“谁投了什么”，而是关心“谁已经被录用、总工时是多少、有没有超负荷”。
- 设计思路非常适合课堂讲，因为它展示了同一份底层数据，在不同角色视角下如何被重组为新的业务结果。

关键代码位置：
- `src/main/java/com/bupt/tarecruitment/service/WorkloadService.java:28-50`
  这里会遍历 Applicant、ApplicationRecord 和 Job 三类数据，只统计 `Accepted` 申请，并累计工时。它的重要性在于，它把前面所有角色动作最终汇总成了 Admin 视角结果。
- `src/main/java/com/bupt/tarecruitment/service/WorkloadService.java:49-50`
  这里根据阈值判断 `Normal` 或 `Overloaded`，说明 Admin 页面看到的状态不是人工输入，而是系统分析结论。

## 8. 模块联动总说明

- 登录链路：`login.jsp` 提交到 `LoginServlet`，`LoginServlet` 调 `AuthService`，`AuthService` 再调 `UserRepository`，成功后把 `currentUser` 放进 Session，再进入 `DashboardServlet` 和 `dashboard.jsp`。
- 注册链路：`login.jsp` 的注册表单提交到 `RegisterServlet`，`RegisterServlet` 调 `AuthService.registerApplicant`，再由 `UserRepository.createApplicant` 写入 JSON，最后跳到 Applicant 的 profile 页面。
- Applicant 资料链路：`applicant-profile.jsp` 提交到 `ApplicantProfileServlet`，更新后的 Applicant 会被 `UserRepository.updateApplicant` 写回数据文件，后面的匹配和 MO 审核都读取这里的数据。
- 岗位浏览链路：`JobListServlet` 负责把开放岗位和已申请标记组装后交给 `job-list.jsp`；点击岗位后，`JobDetailServlet` 会再补充匹配结果和已申请状态给 `job-detail.jsp`。
- 申请提交链路：`job-detail.jsp` 的申请表单提交到 `ApplyJobServlet`，`ApplyJobServlet` 调 `ApplicationService.applyForJob`，后者创建 `ApplicationRecord` 并通过 `ApplicationRepository.save` 写入 JSON。
- MO 审核链路：`MOJobsServlet` 先展示 MO 自己的岗位；进入某个岗位后，`MOApplicationsServlet` 把岗位、申请人和匹配结果组装好；状态更新再由 `UpdateApplicationStatusServlet` 和 `ApplicationService.updateApplicationStatus` 完成。
- Admin 统计链路：`AdminWorkloadServlet` 调 `WorkloadService.getApplicantWorkloadSummaries`，从 Applicant、Job、Application 三类数据里聚合出 `WorkloadSummary`，再交给 `admin-workload.jsp` 渲染。
- 前端公共联动：所有页面的公共导航、语言切换、侧边栏和确认弹窗，都依赖 `header.jspf` 提供结构标记，再由 `main.js` 统一接管。
