# Course Management System

A web-based Course Management System developed using C#, ASP.NET Web Forms, ADO.NET, and SQL Server.

## Technologies Used

- C#
- ASP.NET Web Forms
- ADO.NET
- SQL Server
- HTML
- CSS
- JavaScript

## Features

### Admin
- Admin login and authentication
- Manage courses
- Add, update, and delete courses
- Manage trainers
- Manage students/users
- Role-based access control

### Trainer
- Trainer login
- View available courses
- Update course information
- View trainers
- View students

### Student
- Student login
- View available courses

## Authentication and Security

- Role-based authentication and authorization
- Secure password hashing using PBKDF2
- Session-based authentication
- Server-side validation
- Parameterized SQL queries

## Database

The application uses Microsoft SQL Server.

Database Name:

`CourseManagementDB`

Main tables:

- Users
- Courses

The database script is available in:

`Database/CourseManagementDB.sql`

## Project Structure

```text
Course-Management-System/
│
├── Admin/
├── Trainer/
├── Student/
├── Security/
├── Data/
├── Management/
├── Account/
├── Dashboards/
├── Content/
├── Scripts/
├── App_Start/
│
├── SignIn.aspx
├── SignUp.aspx
├── ChangePassword.aspx
├── ForgotPassword.aspx
├── Global.asax
├── Web.config
│
├── Database/
│   └── CourseManagementDB.sql
│
└── README.md
