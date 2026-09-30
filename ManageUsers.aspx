<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="course_management_system.Admin.ManageUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Users - Course Management</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        .header {
            background: white;
            padding: 20px 32px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
            color: #4c43e5;
        }

        .back-btn {
            text-decoration: none;
            background: #4c43e5;
            color: white;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: bold;
        }

        .container {
            width: 92%;
            max-width: 1150px;
            margin: 35px auto;
        }

        .title-section h1 {
            margin-bottom: 8px;
            color: #222;
        }

        .title-section p {
            color: #666;
            font-size: 17px;
        }

        .message {
            display: block;
            margin: 20px 0;
            font-weight: bold;
        }

        .grid-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        .user-grid {
            width: 100%;
            border-collapse: collapse;
        }

        .user-grid th {
            background: #4c43e5;
            color: white;
            padding: 14px;
            text-align: left;
        }

        .user-grid td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        .user-grid tr:hover {
            background: #f8f9ff;
        }

        .edit-btn {
            background: #198754;
            color: white;
            padding: 7px 12px;
            border-radius: 5px;
            text-decoration: none;
            border: none;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
            padding: 7px 12px;
            border-radius: 5px;
            text-decoration: none;
            border: none;
        }

        .textbox {
            width: 90%;
            padding: 7px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .update-btn {
            background: #4c43e5;
            color: white;
            border: none;
            padding: 7px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .cancel-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 7px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">

    <div class="header">

        <h2>Course Management System</h2>

        <a href="AdminDashboard.aspx"
           class="back-btn">
            ← Dashboard
        </a>

    </div>

    <div class="container">

        <div class="title-section">

            <h1>Manage Users</h1>

            <p>
                View and manage registered students and trainers.
            </p>

        </div>

        <asp:Label ID="lblMessage"
            runat="server"
            CssClass="message">
        </asp:Label>

        <div class="grid-container">

            <asp:GridView ID="gvUsers"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="user-grid"
                DataKeyNames="UserId"
                EmptyDataText="No users found."
                OnRowEditing="gvUsers_RowEditing"
                OnRowCancelingEdit="gvUsers_RowCancelingEdit"
                OnRowUpdating="gvUsers_RowUpdating"
                OnRowDeleting="gvUsers_RowDeleting">

                <Columns>

                    <asp:BoundField
                        DataField="UserId"
                        HeaderText="ID"
                        ReadOnly="True" />

                    <asp:BoundField
                        DataField="FirstName"
                        HeaderText="First Name" />

                    <asp:BoundField
                        DataField="LastName"
                        HeaderText="Last Name" />

                     <asp:BoundField
                         DataField="MobileNumber"
                         HeaderText="MobileNumber" />

                    <asp:BoundField
                        DataField="Email"
                        HeaderText="Email" />

                    <asp:BoundField
                        DataField="Role"
                        HeaderText="Role"
                        ReadOnly="True" />

                    <asp:BoundField
                        DataField="Status"
                        HeaderText="Status"
                        ReadOnly="True" />

                    <asp:BoundField
                        DataField="CreatedDate"
                        HeaderText="Created Date"
                        DataFormatString="{0:dd-MM-yyyy}"
                        ReadOnly="True" />

                    <asp:CommandField
                        ShowEditButton="True"
                        ButtonType="Button"
                        EditText="Edit"
                        UpdateText="Update"
                        CancelText="Cancel" />

                    <asp:CommandField
                        ShowDeleteButton="True"
                        ButtonType="Button"
                        DeleteText="Delete" />

                </Columns>

            </asp:GridView>

        </div>
        </div>

    </form>
</body>
</html>
