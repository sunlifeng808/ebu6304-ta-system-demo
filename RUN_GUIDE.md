# 项目运行指南

本文档面向第一次接手本项目的人，目标是让你在本机把项目稳定跑起来，并且知道出现常见问题时应该检查什么。

本项目是传统 Java Web 项目，不是 Spring Boot。运行方式是：

- 使用 `JDK 17`
- 使用 `Maven` 管理依赖并打包
- 使用 `Tomcat 9` 作为 Servlet 容器
- 使用 `IntelliJ IDEA Ultimate` 进行本地部署和调试

## 1. 先说结论

如果你只想先把项目跑起来，最关键的结论只有 4 条：

1. 必须使用 `JDK 17`
2. 推荐使用 `Tomcat 9`
3. 推荐使用 `IntelliJ IDEA Ultimate`
4. 启动后访问地址通常是 `http://localhost:8080/ta-recruitment-system/`

如果你使用 `Tomcat 10` 或 `IntelliJ IDEA Community Edition`，很可能会遇到额外问题。

## 2. 为什么推荐这些版本

### 2.1 为什么推荐 Tomcat 9

项目依赖的是 `javax.servlet-api:4.0.1`，见 `pom.xml`。

这意味着当前代码基于 `javax.servlet.*` 命名空间开发，而不是 `jakarta.servlet.*`。  
`Tomcat 9` 对应 `javax.servlet` 体系，兼容性最好。  
`Tomcat 10` 以后切到了 `jakarta.servlet`，直接运行当前项目通常会报类找不到或部署失败。

### 2.2 为什么推荐 IntelliJ IDEA Ultimate

因为这是一个标准 `WAR` Web 项目，需要在 IDE 里配置：

- Web 项目结构
- Artifact
- Application Server
- Tomcat 部署

这些能力在 `IntelliJ IDEA Ultimate` 中是现成支持的。  
`IntelliJ IDEA Community Edition` 对 Java Web / Tomcat 本地部署支持不完整，不适合作为这套项目的主运行方式。

## 3. 运行前准备

你需要提前安装好以下软件：

- `JDK 17`
- `Maven 3.6+`
- `Tomcat 9`
- `IntelliJ IDEA Ultimate`

建议安装路径尽量简单，不要带中文和空格，尤其是 `JDK` 和 `Tomcat`。

### 3.1 检查 Java 是否安装成功

打开终端，执行：

```powershell
java -version
javac -version
```

你应当看到 `17` 相关版本信息。

### 3.2 检查 Maven 是否安装成功

执行：

```powershell
mvn -version
```

需要确认两件事：

- Maven 命令能正常执行
- Maven 使用的 Java 版本是 `17`

如果 Maven 走的不是 JDK 17，要先修正环境变量再继续。

### 3.3 检查 Tomcat 是否准备好

你需要提前下载并解压 `Tomcat 9`。  
只要保留完整目录即可，不需要先手动启动。

常见目录结构大致如下：

```text
apache-tomcat-9.x.x/
├─ bin/
├─ conf/
├─ lib/
├─ logs/
├─ temp/
├─ webapps/
└─ work/
```

后面在 IDEA 中配置 Application Server 时，会直接选中这个目录。

## 4. 导入项目

### 4.1 用 IDEA 打开项目

1. 打开 `IntelliJ IDEA Ultimate`
2. 选择 `Open`
3. 选择项目根目录
4. 等待 IDEA 识别 `pom.xml`

本项目根目录下有：

- `pom.xml`
- `src/main/java`
- `src/main/webapp`

这说明它是标准 Maven Web 项目。

### 4.2 如果 IDEA 没有自动识别 Maven 项目

可以手动处理：

1. 在项目视图中右键 `pom.xml`
2. 选择 `Add as Maven Project`

如果右侧 Maven 面板还没出现，可以：

1. 打开 `View -> Tool Windows -> Maven`
2. 点击 Maven 的刷新按钮重新导入依赖

## 5. 配置 JDK 和项目结构

### 5.1 设置 Project SDK

在 IDEA 中打开：

`File -> Project Structure`

然后检查：

- `Project SDK` 选择 `JDK 17`
- `Project language level` 保持默认或选择 `17`

### 5.2 检查 Maven 导入是否完成

第一次打开项目时，IDEA 会下载依赖。  
你需要确认依赖下载完成，没有红色报错。

本项目关键依赖包括：

- `javax.servlet-api`
- `jstl`
- `gson`

如果这里失败，Tomcat 部署通常也会跟着失败。

## 6. 配置 Tomcat 9

这是最关键的一部分。

### 6.1 新建运行配置

1. 点击右上角运行配置下拉框
2. 选择 `Edit Configurations`
3. 点击左上角 `+`
4. 选择 `Tomcat Server -> Local`

### 6.2 配置 Application Server

进入新建的 Tomcat 配置后：

1. 在 `Application Server` 右侧点击 `Configure`
2. 选择你本机的 `Tomcat 9` 安装目录
3. 保存配置

如果这里选错成 `Tomcat 10`，不要继续，先改回 `Tomcat 9`。

### 6.3 设置启动端口

默认 HTTP 端口一般是 `8080`。  
如果你的本机 `8080` 已经被别的程序占用，可以改成别的端口，例如 `8081`。

如果改了端口，后续访问地址也要一起改。

## 7. 配置 Deployment

### 7.1 添加 Artifact

在同一个 Tomcat 配置页面中：

1. 打开 `Deployment` 标签页
2. 点击 `+`
3. 选择 `Artifact`
4. 选择：

```text
ta-recruitment-system:war exploded
```

推荐使用 `war exploded`，因为开发调试更方便。

### 7.2 检查 Application context

Artifact 添加完成后，IDEA 一般会自动生成 context path。  
你需要确认它是：

```text
/ta-recruitment-system
```

这个名字来自 `pom.xml` 里的：

- `artifactId = ta-recruitment-system`
- `finalName = ta-recruitment-system`

如果这里被改成了别的值，访问地址也会变。

## 8. 启动项目

完成上面的配置后：

1. 点击运行按钮启动 Tomcat
2. 等待控制台输出部署完成
3. 在浏览器访问：

```text
http://localhost:8080/ta-recruitment-system/
```

如果你改过端口，比如改成 `8081`，则访问：

```text
http://localhost:8081/ta-recruitment-system/
```

项目欢迎页是 `index.jsp`，会再跳转到登录流程。

## 9. 首次登录账号

系统内置了演示账号，可以直接登录：

| 角色 | 用户名 | 密码 |
| --- | --- | --- |
| Applicant | `applicant1` | `123456` |
| Applicant | `applicant2` | `123456` |
| MO | `mo1` | `123456` |
| Admin | `admin1` | `123456` |

## 10. 项目数据存放说明

这一点很容易被忽略，但对演示很重要。

### 10.1 初始数据在哪里

初始种子数据位于：

`src/main/resources/data/`

包括：

- `users.json`
- `jobs.json`
- `applications.json`

### 10.2 为什么运行后数据还能修改

项目启动时会执行 `DataBootstrapListener`，再由 `PathUtil` 初始化可写数据目录。  
它不是直接在运行时修改 `src/main/resources/data/` 里的源文件，而是先把初始 JSON 复制到应用运行目录，再对复制后的文件读写。

代码入口在：

- `src/main/java/com/bupt/tarecruitment/listener/DataBootstrapListener.java`
- `src/main/java/com/bupt/tarecruitment/util/PathUtil.java`

### 10.3 数据最终写到哪里

优先写到：

`/WEB-INF/data`

如果容器拿不到真实部署路径，则回退到：

- `javax.servlet.context.tempdir`
- 再在里面创建 `ta-recruitment-data`

所以你在页面上的新增岗位、提交申请、修改状态，通常改的是部署后的运行数据，不一定是源码目录中的 JSON。

## 11. 如何重置演示数据

如果你已经演示过很多次，数据被改乱了，可以这样重置：

1. 停止 Tomcat
2. 删除部署目录下的运行数据
3. 重新启动项目

简单理解就是：  
把运行时生成的数据目录删掉，系统下次启动时会再次从 `src/main/resources/data/` 拷贝一份初始数据。

如果你是通过 IDEA 的 `war exploded` 部署，最稳妥的做法是：

1. 停止 Tomcat
2. 删除 IDEA/Tomcat 部署生成目录中的该应用数据
3. 必要时执行一次 `Build -> Rebuild Project`
4. 重新启动 Tomcat

## 12. 如果不用 IDEA，能不能跑

可以。

### 12.1 先本地打包

在项目根目录执行：

```powershell
mvn clean package
```

成功后会生成：

```text
target/ta-recruitment-system.war
```

### 12.2 手动部署到 Tomcat

把这个文件复制到：

```text
Tomcat安装目录\webapps\
```

然后启动 Tomcat，再访问：

```text
http://localhost:8080/ta-recruitment-system/
```

但如果你后续还要调试 JSP、Servlet 或演示修改过程，还是建议用 IDEA Ultimate 直接跑。

## 13. 常见问题排查

### 13.1 页面 404

优先检查下面 4 项：

1. Tomcat 是否真的启动成功
2. 是否已经在 `Deployment` 中添加了 `war exploded`
3. `Application context` 是否是 `/ta-recruitment-system`
4. 访问地址是否写成了正确的端口和路径

标准地址应为：

```text
http://localhost:8080/ta-recruitment-system/
```

### 13.2 IDEA 里没有 Tomcat Server 选项

通常有两个原因：

- 你使用的是 `IntelliJ IDEA Community Edition`
- 当前项目没有被 IDEA 识别成 Web 项目

优先确认你使用的是 `Ultimate`。

### 13.3 Maven 依赖下载失败

先检查：

- 网络是否正常
- Maven 配置是否可用
- `mvn -version` 是否正常
- Maven 使用的 Java 是否是 17

如果学校网络有限制，可以切换可用镜像源后再重新导入依赖。

### 13.4 Tomcat 启动了，但项目没部署成功

常见原因：

- 没有添加 Artifact
- 添加错成了别的 Artifact
- 使用了 `Tomcat 10`
- JDK 版本不对

重点检查：

- `Tomcat Server -> Deployment`
- `Project SDK = 17`
- `Application Server = Tomcat 9`

### 13.5 修改了源码中的 JSON，但页面里看不到变化

这是因为运行时用的是复制后的数据文件，不一定直接读取源码目录：

`src/main/resources/data/`

如果你想恢复成源码中的初始状态，通常需要删除运行数据后再重启。

## 14. 推荐的课堂演示顺序

如果你是为了答辩或课程展示，建议按下面顺序演示：

1. 用 `mo1 / 123456` 登录
2. 新建一个岗位
3. 查看该岗位下的申请列表
4. 退出登录
5. 用 `applicant1 / 123456` 登录
6. 修改个人 `skills`
7. 浏览岗位并查看匹配分数
8. 提交申请
9. 再切回 `mo1` 查看申请并修改状态
10. 最后用 `admin1 / 123456` 登录查看 workload

这样三种角色都能展示到，流程也比较完整。

## 15. 最后再提醒一次

请优先按下面组合运行本项目：

- `JDK 17`
- `Tomcat 9`
- `IntelliJ IDEA Ultimate`

访问地址优先使用：

```text
http://localhost:8080/ta-recruitment-system/
```
