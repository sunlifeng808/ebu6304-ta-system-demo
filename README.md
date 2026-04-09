# BUPT International School Teaching Assistant Recruitment System

## 1. Project Introduction

This project is a simple Java Web course project for recruiting Teaching Assistants (TAs) in the BUPT International School.  
It is built with Java Servlet + JSP and uses JSON files for data storage, so it is easy to understand, easy to run, and easy to demonstrate in class.

The system supports three roles:

- Applicant
- MO (Module Organiser)
- Admin

## 2. Technology Stack

- Java 11
- Maven Web Application (WAR)
- Java Servlet + JSP + JSTL
- Gson
- HTML / CSS / a small amount of vanilla JavaScript
- JSON file storage
- Tomcat 9

## 3. Main Features

- User login and logout
- Role-based dashboard
- Applicant profile view and edit
- Applicant job browsing and job detail view
- Applicant job application submission
- Duplicate application prevention
- Applicant application status tracking
- MO job creation
- MO job list management
- MO applicant review and status update
- Local rule-based skill matching
- Admin workload overview

## 4. Project Structure

```text
ta-recruitment-system/
├── pom.xml
├── README.md
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
│           ├── assets/
│           │   ├── css/style.css
│           │   └── js/main.js
│           ├── WEB-INF/
│           │   ├── web.xml
│           │   └── views/
│           └── index.jsp
└── USER_MANUAL.md
```

## 5. How to Import into IntelliJ IDEA / Eclipse

### IntelliJ IDEA

1. Open IntelliJ IDEA.
2. Choose `Open`.
3. Select this project folder.
4. Wait for Maven dependencies to load.
5. Configure Tomcat 9 in `Run/Debug Configurations`.
6. Deploy the generated WAR artifact.

### Eclipse

1. Open Eclipse.
2. Choose `File -> Import -> Existing Maven Projects`.
3. Select this project folder.
4. Finish the import.
5. Add the project to Tomcat 9 in the Servers view.

## 6. Tomcat Configuration

- Recommended server: Tomcat 9
- JDK: Java 11 or Java 17
- Context path example: `/ta-recruitment-system`

If your IDE asks for a web artifact, choose the exploded WAR or the generated WAR artifact.

## 7. How to Run

1. Make sure Maven and JDK are installed.
2. Import the project into IDEA or Eclipse.
3. Configure Tomcat 9.
4. Start the server.
5. Open:

```text
http://localhost:8080/ta-recruitment-system/
```

You will be redirected to the login page.

You can also build the project from terminal:

```bash
mvn clean package
```

## 8. Initial Accounts

| Role | Username | Password |
|------|----------|----------|
| Applicant | applicant1 | 123456 |
| Applicant | applicant2 | 123456 |
| MO | mo1 | 123456 |
| Admin | admin1 | 123456 |

## 9. JSON Data File Notes

Source seed files are stored in:

```text
src/main/resources/data/
```

At runtime, the system copies these seed files into a writable application data folder under `WEB-INF/data` when the web app starts for the first time.  
This is done because files inside `src/main/resources` are packaged into the WAR and should not be written directly during runtime.

Files:

- `users.json`: stores all users
- `jobs.json`: stores job posts
- `applications.json`: stores application records

## 10. Matching Logic

The project includes a simple explainable local matching feature.

- Applicant has `skills`
- Job has `requiredSkills`
- `matchedSkills` = overlap between the two lists
- `missingSkills` = required skills not found in applicant skills
- `score = matchedSkillsCount / requiredSkillsCount * 100`

This result is shown:

- on the applicant job detail page
- on the MO application review page

## 11. Workload Logic

The admin page calculates workload using accepted applications only.

- For each applicant, find all applications with status `Accepted`
- Sum the `hours` of the related jobs
- If total hours > 10, show `Overloaded`
- Otherwise, show `Normal`

## 12. Demo Flow Suggestion

Recommended classroom demo:

1. Login as `mo1`
2. Open `My Jobs`
3. Create a new job
4. View applicants for an existing job and update one application status
5. Logout
6. Login as `applicant1`
7. Edit the profile skills
8. Browse jobs
9. Open one job detail page and show the match score
10. Apply for a job
11. Open `My Applications` and show the status
12. Logout
13. Login as `admin1`
14. Open workload overview and show overloaded / normal result

## 13. Notes for Presentation

- The project follows a simple MVC structure:
  - `model`
  - `repository`
  - `service`
  - `servlet`
  - `jsp`
- No database is used
- No Spring Boot or front-end framework is used
- The code is intentionally straightforward for course presentation and modification
