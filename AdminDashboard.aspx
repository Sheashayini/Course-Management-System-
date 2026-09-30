<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="course_management_system.Admin.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Admin Dashboard</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;

            font-family: Arial, sans-serif;

            background: #f5f7fb;
        }

        /* Header */

        .header {
            height: 70px;

            background: #ffffff;

            border-bottom: 1px solid #e5e7eb;

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 0 40px;
        }

        .logo {
            font-size: 21px;

            font-weight: bold;

            color: #4f46e5;
        }

        .admin-area {
            display: flex;

            align-items: center;

            gap: 20px;
        }

        .welcome {
            color: #333;

            font-weight: bold;
        }

        .logout {
            padding: 9px 17px;

            background: #ef4444;

            color: white;

            border-radius: 6px;

            text-decoration: none;

            font-weight: bold;
        }

        .logout:hover {
            background: #dc2626;
        }

        /* Main */

        .main {
            padding: 40px;
        }

        .heading h1 {
            margin: 0 0 8px;

            color: #222;
        }

        .heading p {
            margin: 0 0 35px;

            color: #666;
        }

        /* Cards */

        .cards {
            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));

            gap: 25px;
        }

        .card {
            background: #ffffff;

            padding: 28px;

            border-radius: 12px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 4px 12px rgba(0,0,0,0.05);
        }

        .card h3 {
            margin-top: 0;

            color: #333;
        }

        .card p {
            color: #666;

            line-height: 1.5;

            min-height: 45px;
        }

        .card-button {
            display: inline-block;

            padding: 10px 18px;

            background: #4f46e5;

            color: white;

            border-radius: 6px;

            text-decoration: none;

            font-weight: bold;
        }

        .card-button:hover {
            background: #4338ca;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!--Header-->
        <div class="header">
            <div class="logo">
                Course Management System
            </div>
            <div class="admin-area">
                <span class="welcome">Welcome,
                    <asp:Label ID="lblAdminName" runat="server" Text="Admin"></asp:Label>
                    </span>

                <asp:LinkButton ID="btnLogout" runat="server" CssClass="logout" OnClick="btnLogout_Click">Logout</asp:LinkButton>
            </div>

        </div>
        <!--Main-->
        <div class="main">
            <div class="heading">
                <h1>Admin Dashboard</h1>
                <p>Manage Trainers, Courses and Users efficiently</p>
            </div>
            <div class="cards">
                <!--Trainer Management-->
                <div class="card">
                    <h3>Trainer Management</h3>
                    <p>Create and Manage trainer Accounts</p>
                    <a href="AddTrainer.aspx" class="card-button">Manage Trainers</a>
                </div>
                <!--Course Management-->
                <div class="card">
                    <h3>Course Management</h3>
                    <p>Add,view,update and delete courses.</p>
                    <a href="ManageCourse.aspx" class="card-button">Manage Courses</a>
                    <br /> <br />
                    <a href="AddCourse.aspx" class="card-button">Add Course</a>
                </div>

                <!--User Management-->
                <div class="card">
                    <h3>User Management</h3>
                    <p>View and manage registered system users.</p>
                    <a href="ManageUsers.aspx" class="card-button">Manage Users</a>
               </div>
            </div>
        </div>
    </form>
</body>
</html>
