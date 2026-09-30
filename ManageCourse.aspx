<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCourse.aspx.cs" Inherits="course_management_system.Admin.ManageCourse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Courses - Course Management System</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 22px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
        }

        .header-buttons {
            display: flex;
            gap: 10px;
        }

        .header-btn {
            color: white;
            text-decoration: none;
            background: rgba(255,255,255,0.2);
            padding: 10px 18px;
            border-radius: 6px;
            font-size: 14px;
        }

        .header-btn:hover {
            background: rgba(255,255,255,0.3);
        }

        /* Main Container */
        .container {
            width: 92%;
            max-width: 1250px;
            margin: 35px auto;
        }

        /* Title */
        .title-section {
            margin-bottom: 25px;
        }

        .title-section h2 {
            margin: 0 0 8px 0;
            color: #333;
            font-size: 30px;
        }

        .title-section p {
            margin: 0;
            color: #777;
            font-size: 18px;
        }

        /* Message */
        .message {
            display: block;
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 6px;
            font-weight: bold;
        }

        /* Add Button */
        .add-btn {
            display: inline-block;
            margin-bottom: 24px;
            padding: 12px 22px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-size: 16px;
        }

        .add-btn:hover {
            background: #5568d9;
        }

        /* Grid Container */
        .grid-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        /* Grid */
        .course-grid {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        .course-grid th {
            background: #667eea;
            color: white;
            padding: 14px 16px;
            text-align: left;
            border: 1px solid #ddd;
            white-space: nowrap;
            font-size: 15px;
        }

        .course-grid td {
            padding: 13px 16px;
            border: 1px solid #ddd;
            color: #333;
            white-space: nowrap;
            font-size: 15px;
        }

        .course-grid tr:hover {
            background: #f8f9ff;
        }

        /* Edit and Delete Links */
        .course-grid a {
            text-decoration: none;
            font-weight: 500;
        }

        .course-grid a:hover {
            text-decoration: underline;
        }

        /* Edit Link */
        .course-grid td a[href*="Edit"],
        .course-grid td a[href*="edit"] {
            color: #667eea;
        }

        /* Delete Link */
        .course-grid td a[href*="Delete"],
        .course-grid td a[href*="delete"] {
            color: #dc3545;
        }

        /* Edit/Delete CommandField Buttons */
        .edit-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 7px 14px;
            border-radius: 5px;
            cursor: pointer;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 7px 14px;
            border-radius: 5px;
            cursor: pointer;
        }

    </style>
</head>

<body>

    <form id="form1" runat="server">

        <!-- Header -->
        <div class="header">

            <h2>Manage Courses</h2>

            <div class="header-buttons">

                <a href="AddCourse.aspx" class="header-btn">
                    + Add Course
                </a>

                <a href="AdminDashboard.aspx" class="header-btn">
                    ← Back to Dashboard
                </a>

            </div>

        </div>


        <!-- Main Content -->
        <div class="container">

            <!-- Title Section -->
            <div class="title-section">

                <h2>Course Management</h2>

                <p>
                    View and manage all courses in the system.
                </p>

            </div>


            <!-- Message -->
            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <!-- Add New Course -->
            <a href="AddCourse.aspx" class="add-btn">
                + Add New Course
            </a>


            <!-- Course Grid -->
            <div class="grid-container">

                <asp:GridView
                    ID="gvCourses"
                    runat="server"
                    CssClass="course-grid"
                    AutoGenerateColumns="False"
                    DataKeyNames="CourseId"
                    OnRowEditing="gvCourses_RowEditing"
                    OnRowCancelingEdit="gvCourses_RowCancelingEdit"
                    OnRowUpdating="gvCourses_RowUpdating"
                    OnRowDeleting="gvCourses_RowDeleting">

                    <Columns>

                        <asp:BoundField
                            DataField="CourseID"
                            HeaderText="Course ID" />

                        <asp:BoundField
                            DataField="CourseName"
                            HeaderText="Course Name" />

                        <asp:BoundField
                            DataField="TrainerName"
                            HeaderText="Trainer Name" />

                        <asp:BoundField
                            DataField="Duration"
                            HeaderText="Duration (Weeks)" />

                        <asp:BoundField
                            DataField="Fees"
                            HeaderText="Fees"
                            DataFormatString="{0:N2}" />

                        <asp:BoundField
                            DataField="CreatedDate"
                            HeaderText="Created Date"
                            DataFormatString="{0:dd-MM-yyyy}" />

                        <asp:CommandField
                            ShowEditButton="True"
                            HeaderText="Edit" />

                        <asp:CommandField
                            ShowDeleteButton="True"
                            HeaderText="Delete" />

                    </Columns>

                </asp:GridView>

            </div>

        </div>

    </form>

</body>
</html>