# 用户使用手册

## 1. 文档说明

本手册面向系统使用者，介绍如何以不同角色使用本系统完成 TA 招聘相关操作。

系统包含三类角色：

- Applicant（申请 TA 的学生）
- MO / Module Organiser（发布岗位并筛选申请者的负责人）
- Admin（管理员，用于查看整体 workload）

---

## 2. 登录说明

启动系统后，在浏览器访问：

```text
http://localhost:8080/ta-recruitment-system/
```

系统会自动跳转到登录页。

输入用户名和密码后，点击 `Login` 即可进入系统。

### 演示账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| Applicant | applicant1 | 123456 |
| Applicant | applicant2 | 123456 |
| MO | mo1 | 123456 |
| Admin | admin1 | 123456 |

---

## 3. Applicant 使用说明

Applicant 主要负责查看岗位、提交申请、查看申请状态。

### 3.1 登录后可见功能

Applicant 登录后，在导航栏中可以看到：

- `Dashboard`
- `My Profile`
- `Browse Jobs`
- `My Applications`

### 3.2 编辑个人信息

进入 `My Profile` 页面后，可以查看和修改：

- Full Name
- Email
- Skills

其中 `Skills` 使用英文逗号分隔，例如：

```text
Java, Python, Communication
```

修改完成后点击 `Save Profile` 保存。

### 3.3 浏览岗位

进入 `Browse Jobs` 页面后，可以看到所有开放中的岗位，包括：

- 岗位名称
- 模块名称
- 工作时长
- 所需技能
- 岗位状态

点击 `View Detail` 可以查看岗位详情。

### 3.4 查看岗位详情和匹配结果

在岗位详情页中，可以看到：

- 岗位名称
- 模块名称
- 岗位描述
- Required Skills
- Hours
- Match Score
- Matched Skills
- Missing Skills

其中：

- `Match Score` 表示技能匹配分数
- `Matched Skills` 表示你已具备的岗位技能
- `Missing Skills` 表示该岗位仍缺少的技能

### 3.5 提交申请

如果还没有申请该岗位，详情页会显示 `Apply Now` 按钮。

点击后即可提交申请。

系统会自动防止重复申请同一个岗位。  
如果已经申请过，该页面会显示 `You already applied`。

### 3.6 查看申请记录

进入 `My Applications` 页面后，可以看到自己的所有申请记录，包括：

- Job Title
- Module
- Status
- Applied At

状态说明：

- `Pending`：待处理
- `Accepted`：已录用
- `Rejected`：已拒绝

---

## 4. MO 使用说明

MO 负责发布 TA 岗位、查看申请者并更新申请状态。

### 4.1 登录后可见功能

MO 登录后，在导航栏中可以看到：

- `Dashboard`
- `My Jobs`
- `Create Job`

### 4.2 查看自己发布的岗位

进入 `My Jobs` 页面后，可以看到自己发布的所有岗位，包括：

- Title
- Module
- Hours
- Required Skills
- Status

点击 `View Applications` 可以查看该岗位下的所有申请人。

### 4.3 创建新岗位

进入 `Create Job` 页面后，填写以下信息：

- Job Title
- Module / Activity Name
- Description
- Required Skills
- Workload Hours

其中 `Required Skills` 需要使用英文逗号分隔，例如：

```text
Java, Communication, Tutoring
```

填写完成后点击 `Create Job`。

如果字段为空或工时不是正整数，系统会给出提示。

### 4.4 查看申请者信息

在 `Applications` 页面中，可以查看某个岗位下的所有申请记录，包括：

- Applicant Name
- Email
- Skills
- Match Score
- Missing Skills
- Current Status

这样可以快速判断申请者与岗位要求的匹配程度。

### 4.5 更新申请状态

对于每条申请，MO 可以从下拉框中选择状态：

- Pending
- Accepted
- Rejected

选择完成后点击 `Save` 保存结果。

更新成功后，Applicant 再次登录时就能在自己的 `My Applications` 页面中看到最新状态。

---

## 5. Admin 使用说明

Admin 主要用于查看系统中的 workload 总览。

### 5.1 登录后可见功能

Admin 登录后，在导航栏中可以看到：

- `Dashboard`
- `Workload Overview`

### 5.2 查看 workload 总览

进入 `Workload Overview` 页面后，可以看到每位 Applicant 的统计信息：

- Applicant Name
- Email
- Accepted Jobs Count
- Total Hours
- Workload Status

### 5.3 workload 状态规则

系统统计逻辑如下：

1. 只统计状态为 `Accepted` 的申请
2. 取出对应岗位的 `hours`
3. 计算总工时
4. 如果总工时大于 10，标记为 `Overloaded`
5. 否则标记为 `Normal`

这样管理员可以快速发现工作量过高的学生。

---

## 6. 匹配功能说明

系统带有一个简单的本地规则型匹配功能，用于辅助 Applicant 和 MO 判断岗位适配度。

### 6.1 匹配规则

- Applicant 有一组 `skills`
- Job 有一组 `requiredSkills`
- 系统比较两组技能的重合情况

计算规则：

```text
匹配分数 = 已匹配技能数量 / 岗位要求技能数量 × 100
```

### 6.2 匹配结果展示内容

系统会展示：

- `matchedSkills`
- `missingSkills`
- `score`

### 6.3 展示位置

匹配结果会出现在：

- Applicant 的岗位详情页
- MO 的申请管理页

---

## 7. 常见操作建议

### 7.1 课堂演示推荐顺序

建议按照下面顺序演示：

1. 用 `mo1` 登录
2. 创建一个新岗位
3. 查看一个岗位的申请人列表
4. 修改申请状态
5. 退出登录
6. 用 `applicant1` 登录
7. 修改 skills
8. 浏览岗位并查看匹配分
9. 提交岗位申请
10. 查看申请状态
11. 退出登录
12. 用 `admin1` 登录
13. 查看 workload 总览

### 7.2 如果想重置演示数据

如果你在运行过程中修改了很多数据，想恢复初始状态，可以：

1. 停止 Tomcat
2. 删除部署目录中的应用数据文件
3. 重新部署并启动项目

系统会重新从初始 JSON 数据复制一份新的运行数据。

---

## 8. 状态说明汇总

### 8.1 申请状态

- `Pending`：申请已提交，但还未处理
- `Accepted`：申请通过
- `Rejected`：申请未通过

### 8.2 工作量状态

- `Normal`：工作量正常
- `Overloaded`：工作量超过阈值

---

## 9. 结束语

本系统主要用于课程项目演示，因此设计上强调：

- 简单
- 清晰
- 易运行
- 易展示

如果只是做课堂汇报或软件工程课程答辩，按照本手册操作即可完整展示系统流程。
