# BUPT International School Teaching Assistant Recruitment System

## 1. 项目简介

这是一个基于 **Java Servlet + JSP** 的课程项目，用于演示国际学院 Teaching Assistant（TA）招聘流程。

项目目标是尽量用简单、清晰、容易讲解的方式，实现一个完整可演示的招聘闭环：

- MO 发布岗位
- Applicant 浏览岗位并提交申请
- MO 查看申请并更新状态
- Applicant 查看自己的申请结果
- Admin 查看所有 Applicant 的 workload
- 系统根据技能重合度给出简单匹配分数和缺失技能

本项目不使用数据库，不使用 Spring Boot，不做前后端分离，所有数据使用 JSON 文件存储，适合软件工程课程展示、答辩和二次修改。

---

## 2. 技术栈

- Java 17
- Maven Web Application（WAR）
- Java Servlet + JSP + JSTL
- Gson
- HTML / CSS / 少量原生 JavaScript
- JSON 文件存储
- Tomcat 9

---

## 3. 核心功能

### 3.1 登录与角色

- 预置账号登录
- 使用 `HttpSession` 保存当前登录用户
- 按角色跳转不同 dashboard
- 支持退出登录

### 3.2 Applicant 功能

- 查看和编辑个人资料
- 编辑 skills
- 浏览所有岗位
- 查看岗位详情
- 提交岗位申请
- 防止重复申请同一岗位
- 查看自己的申请记录和状态
- 查看岗位匹配分数、已匹配技能、缺失技能

### 3.3 MO 功能

- 查看自己发布的岗位
- 新建岗位
- 查看某岗位下的申请列表
- 查看申请人的 skills
- 查看匹配分数和缺失技能
- 更新申请状态：`Pending / Accepted / Rejected`

### 3.4 Admin 功能

- 查看所有 Applicant 的 workload 总览
- 统计所有 `Accepted` 申请对应岗位的总小时数
- 超过阈值（默认 10 小时）标记为 `Overloaded`

### 3.5 简单智能匹配

本项目没有调用外部 AI 接口，使用的是本地规则型匹配：

- `matchedSkills`：Applicant skills 和 Job requiredSkills 的交集
- `missingSkills`：Job requiredSkills 中 Applicant 不具备的技能
- `score = matchedSkillsCount / requiredSkillsCount * 100`

这个逻辑简单、可解释，适合课程答辩时讲解。

---

## 4. 项目结构

```text
ta-recruitment-system/
├── pom.xml
├── README.md
├── demonstration.md
├── USER_MANUAL.md
├── src/
│   └── main/
│       ├── java/
│       │   └── com/bupt/tarecruitment/
│       │       ├── listener/
│       │       ├── model/
│       │       ├── repository/
│       │       ├── service/
│       │       ├── servlet/
│       │       └── util/
│       ├── resources/
│       │   └── data/
│       │       ├── users.json
│       │       ├── jobs.json
│       │       └── applications.json
│       └── webapp/
│           ├── index.jsp
│           ├── assets/
│           │   ├── css/style.css
│           │   └── js/main.js
│           └── WEB-INF/
│               ├── web.xml
│               └── views/
│                   ├── login.jsp
│                   ├── dashboard.jsp
│                   ├── applicant-profile.jsp
│                   ├── job-list.jsp
│                   ├── job-detail.jsp
│                   ├── my-applications.jsp
│                   ├── create-job.jsp
│                   ├── mo-jobs.jsp
│                   ├── mo-applications.jsp
│                   ├── admin-workload.jsp
│                   ├── error.jsp
│                   └── includes/
```

各层职责：

- `model`：定义数据对象
- `repository`：负责 JSON 文件读写
- `service`：处理业务逻辑
- `servlet`：接收请求、调用 service、转发 JSP
- `jsp`：页面展示

如果你需要按课堂展示场景查看项目分工、模块讲解重点、关键逻辑位置和模块联动关系，可以直接阅读根目录下的 `demonstration.md`。

---

## 5. 运行环境要求

建议环境：

- JDK 17
- Maven 3.6+
- Tomcat 9
- IntelliJ IDEA Ultimate 或 Eclipse EE

说明：

- 本项目使用的是 `javax.servlet`，因此优先推荐 **Tomcat 9**
- 如果使用 Tomcat 10，会涉及 `jakarta.servlet` 包名差异，不建议课堂演示时切换

---

## 6. 如何启动运行项目

这一部分是最重要的。下面按最常见的课堂环境说明如何启动。

### 6.1 方式一：使用 IntelliJ IDEA + Tomcat 9 运行

这是最推荐的方式。

#### 第一步：导入项目

1. 打开 IntelliJ IDEA
2. 选择 `Open`
3. 选择当前项目根目录
4. IDEA 会自动识别 `pom.xml`
5. 等待 Maven 依赖下载完成

如果右侧 Maven 面板没有出现，可以：

1. 右键 `pom.xml`
2. 选择 `Add as Maven Project`

#### 第二步：配置 JDK

1. 打开 `File -> Project Structure`
2. 在 `Project SDK` 中选择 JDK 17
3. `Project language level` 选择默认即可

#### 第三步：配置 Tomcat 9

1. 点击右上角运行配置下拉框
2. 选择 `Edit Configurations`
3. 点击 `+`
4. 选择 `Tomcat Server -> Local`
5. 配置本地 Tomcat 9 安装目录

#### 第四步：部署项目

在 Tomcat 配置页面中：

1. 打开 `Deployment`
2. 点击 `+`
3. 选择 `Artifact`
4. 选择：

```text
ta-recruitment-system:war exploded
```

建议使用 `war exploded`，便于开发时直接运行。

#### 第五步：检查访问路径

一般 context path 会自动生成：

```text
/ta-recruitment-system
```

如果没有，可以手动设置成这个值。

#### 第六步：启动项目

点击运行按钮启动 Tomcat。

启动成功后，在浏览器访问：

```text
http://localhost:8080/ta-recruitment-system/
```

系统会自动跳转到登录页。

---

### 6.2 方式二：使用 Eclipse + Tomcat 9 运行

#### 第一步：导入 Maven 项目

1. 打开 Eclipse
2. 选择 `File -> Import`
3. 选择 `Maven -> Existing Maven Projects`
4. 选择项目根目录
5. 点击完成

#### 第二步：配置 Tomcat

1. 打开 `Servers` 视图
2. 新建一个 `Tomcat v9.0 Server`
3. 绑定本地 Tomcat 9 安装目录

#### 第三步：部署项目

1. 右键 Tomcat Server
2. 选择 `Add and Remove`
3. 把当前项目加入到已部署列表

#### 第四步：启动并访问

启动 Tomcat 后访问：

```text
http://localhost:8080/ta-recruitment-system/
```

---

### 6.3 方式三：先打包 WAR，再部署到 Tomcat

如果你不想通过 IDE 直接运行，也可以先打包。

在项目根目录执行：

```bash
mvn clean package
```

打包成功后会生成：

```text
target/ta-recruitment-system.war
```

然后把这个 WAR 包复制到 Tomcat 的 `webapps/` 目录下，启动 Tomcat 即可。

浏览器访问：

```text
http://localhost:8080/ta-recruitment-system/
```

---

## 7. 启动后登录账号

系统内置了 4 个演示账号：

| 角色 | 用户名 | 密码 |
|------|--------|------|
| Applicant | applicant1 | 123456 |
| Applicant | applicant2 | 123456 |
| MO | mo1 | 123456 |
| Admin | admin1 | 123456 |

---

## 8. 首次运行时的数据说明

种子数据位于：

```text
src/main/resources/data/
```

包括：

- `users.json`
- `jobs.json`
- `applications.json`

### 为什么运行时还能修改 JSON？

因为 Maven 打包后，`resources` 里的文件会进入 WAR 包内部，运行时通常不适合直接写入。  
所以本项目在启动时会自动把这些初始 JSON 文件复制到应用的可写目录中，再对复制后的文件进行读写。

这样有两个好处：

- 保留了课程要求的 JSON 初始化数据
- 避免直接写 WAR 内资源导致失败

---

## 9. 主要页面说明

### Applicant

- `/applicant/profile`
- `/jobs`
- `/jobs/detail?id=...`
- `/applicant/applications`

### MO

- `/mo/jobs`
- `/mo/jobs/create`
- `/mo/applications?jobId=...`

### Admin

- `/admin/workload`

---

## 10. 常见问题

### 10.1 页面打不开

先检查：

- Tomcat 是否已经启动
- context path 是否是 `/ta-recruitment-system`
- 浏览器地址是否正确

推荐访问：

```text
http://localhost:8080/ta-recruitment-system/
```

### 10.2 Maven 依赖下载失败

可能原因：

- 网络问题
- Maven 仓库配置问题
- 本机没有正确安装 Maven

建议先执行：

```bash
mvn -version
```

确认 Maven 和 Java 都能正常使用。

### 10.3 Tomcat 启动了但页面 404

常见原因：

- 没有正确部署 artifact
- 部署的不是 `war exploded`
- context path 配置不对

### 10.4 修改 JSON 后没有效果

因为系统运行时使用的是复制后的可写数据文件，不一定直接读取 `src/main/resources/data/` 中的源文件。  
如果要重置数据，最简单的方法是：

1. 停止 Tomcat
2. 删除部署目录中的应用数据
3. 重新启动项目

或者重新部署项目。

---

## 11. 项目亮点

这个项目的特点不是“复杂”，而是“适合课程项目”：

- 结构清楚
- 技术简单
- 功能完整
- 可直接部署到 Tomcat
- 没有数据库依赖
- 适合演示和答辩
- 匹配逻辑清楚、容易解释

---

## 12. 总结

如果你要做软件工程课程展示，这个项目比较适合：

- 代码量适中
- MVC 分层明显
- 每个角色功能都能演示
- 匹配和 workload 有一定“智能分析”展示效果
- 技术选型符合基础 Java Web 教学环境

启动时最重要的两点：

1. 使用 **Tomcat 9**
2. 访问地址使用：

```text
http://localhost:8080/ta-recruitment-system/
```
