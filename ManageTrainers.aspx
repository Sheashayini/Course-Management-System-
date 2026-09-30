<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageTrainers.aspx.cs" Inherits="course_management_system.Admin.ManageTrainers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Trainers - Course Management</title>
    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

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
        }

        .back-btn {
            color: white;
            text-decoration: none;
            background: rgba(255,255,255,0.2);
            padding: 10px 18px;
            border-radius: 6px;
        }

        .container {
            width: 92%;
            max-width: 1200px;
            margin: 35px auto;
        }

        .title-section {
            margin-bottom: 25px;
        }

        .title-section h2 {
            margin-bottom: 8px;
            color: #333;
        }

        .title-section p {
            color: #777;
        }

        .message {
            display: block;
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 6px;
            font-weight: bold;
        }

        .grid-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        .trainer-grid {
            width: 100%;
            border-collapse: collapse;
        }

        .trainer-grid th {
            background: #667eea;
            color: white;
            padding: 14px;
            text-align: left;
        }

        .trainer-grid td {
            padding: 13px;
            border-bottom: 1px solid #eee;
        }

        .trainer-grid tr:hover {
            background: #f8f9ff;
        }

        .edit-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 7px 14px;
            border-radius: 5px;
            cursor: pointer;
        }

        .status-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 7px 14px;
            border-radius: 5px;
            cursor: pointer;
        }

        .empty-message {
            text-align: center;
            padding: 30px;
            color: #777;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <h2>Manage Trainers</h2>
            <a href="AdminDashboard.aspx" class="back-btn"> ← Back to Dashboard</a>
        </div>
        <div class="container">
            <div class="title-section">
                <h2>Trainer Management</h2>
                <p>View,Edit And Manage Trainer Accounts</p>
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            <<asp:GridView ID="gvTrainers" runat="server"
    AutoGenerateColumns="False"
    DataKeyNames="UserId"
    CssClass="trainer-grid"
    EmptyDataText="No trainers found"
    OnRowEditing="gvTrainers_RowEditing"
    OnRowCancelingEdit="gvTrainers_RowCancelingEdit"
    OnRowUpdating="gvTrainers_RowUpdating"
    OnRowCommand="gvTrainers_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="UserId" HeaderText="ID" ReadOnly="True" />
                       <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" DataFormatString="{0:MM/dd/yyyy}" ReadOnly="true"/>
                        <asp:CommandField ShowEditButton="True" HeaderText="Action" />
                    <asp:TemplateField HeaderText="Reset Password">
    <ItemTemplate>
        <asp:Button
            ID="btnResetPassword"
            runat="server"
            Text="Reset Password"
            CommandName="ResetPassword"
            CommandArgument='<%# Eval("UserId") %>'
            CssClass="btn-reset"
            OnClientClick="return confirm('Are you sure you want to reset this password?');" />
    </ItemTemplate>
</asp:TemplateField>
                </Columns>
             </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>
