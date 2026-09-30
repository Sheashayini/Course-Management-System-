<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddTrainer.aspx.cs" Inherits="course_management_system.Admin.AddTrainer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Trainer - Course Management System</title>
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
            align-items: center;
            justify-content: space-between;

            padding: 0 40px;
        }

        .logo {
            font-size: 21px;
            font-weight: bold;
            color: #4f46e5;
        }

        .back-link {
            text-decoration: none;
            color: #4f46e5;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        /* Main */

        .main {
    padding: 40px 20px;
    max-width: 1000px;
    margin: 0 auto;
}

        .page-title {
    max-width: 650px;
    margin: 0 auto 25px;
}

        .page-title h1 {
            margin: 0 0 8px;
            color: #222;
        }

        .page-title p {
            margin: 0;
            color: #666;
        }

        /* Form */

.form-container {
    width: 100%;
    max-width: 650px;

    background: #ffffff;

    padding: 35px;

    border-radius: 12px;

    border: 1px solid #e5e7eb;

    box-shadow:
        0 4px 12px rgba(0,0,0,0.05);

    margin: 0 auto;
}

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;

            margin-bottom: 7px;

            color: #333;

            font-weight: bold;
        }

        .textbox {
            width: 100%;

            padding: 12px;

            border: 1px solid #d1d5db;

            border-radius: 7px;

            font-size: 14px;

            outline: none;
        }

        .textbox:focus {
            border-color: #4f46e5;

            box-shadow:
                0 0 0 2px rgba(79,70,229,0.12);
        }

        .validator {
            display: block;

            margin-top: 5px;

            color: #dc2626;

            font-size: 13px;
        }

        .button-group {
            display: flex;

            gap: 12px;

            margin-top: 10px;
        }

        .save-button {
            padding: 12px 25px;

            border: none;

            border-radius: 7px;

            background: #4f46e5;

            color: white;

            font-size: 15px;

            font-weight: bold;

            cursor: pointer;
        }

        .save-button:hover {
            background: #4338ca;
        }

        .cancel-button {
            padding: 12px 25px;

            border-radius: 7px;

            background: #ffffff;

            border: 1px solid #d1d5db;

            color: #444;

            text-decoration: none;

            font-size: 15px;

            font-weight: bold;
        }

        .cancel-button:hover {
            background: #f3f4f6;
        }

        .message {
            display: block;

            margin-top: 20px;

            padding: 10px;

            border-radius: 6px;

            font-weight: bold;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header-->
        <div class="header">
            <div class="logo">
                Course Management System
            </div>
            <a href="AdminDashboard.aspx" class="back-link"> ← Back to Dashboard</a>
        </div>
        <!--Main-->
        <div class="main">
            <div class="page-title">
                <h1>Add Trainer</h1>
                <p>Create a new trainer account</p>
            </div>
            
            <div class="form-container">    
                <!-- First Name-->
                    <div class="form-group">
                        <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="textbox"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name is required." CssClass="validator"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txtFirstName" ValidationExpression="^[a-zA-Z]+$" ErrorMessage="First Name can only contain letters." CssClass="validator"></asp:RegularExpressionValidator>
                    </div>

                <!--Last Name-->
                <div class="form-group">
                    <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="textbox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revLastName" runat="server" ControlToValidate="txtLastName" ValidationExpression="^[a-zA-Z]+$" ErrorMessage="Last Name can only contain letters." CssClass="validator"></asp:RegularExpressionValidator>

                </div>

                <!--MobileNumber-->
                <div class="form-group">
                    <asp:Label ID="lblMobileNumber" runat="server" Text="Mobile Number"></asp:Label>
                    <asp:TextBox ID="txtMobileNumber" runat="server" CssClass="textbox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMobileNumber" runat="server" ControlToValidate="txtMobileNumber" ErrorMessage="Mobile Number is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revMobileNumber" runat="server" ControlToValidate="txtMobileNumber" ValidationExpression="^[6-9][0-9]{9}$" ErrorMessage="Mobile Number must be 10 digits." CssClass="validator"></asp:RegularExpressionValidator>
                </div>

                <!--Email-->
                <div class="form-group">
                    <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email address is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[a-z][a-z0-9._%+-]*@[a-z0-9.-]+\.[a-z]{2,}$" ErrorMessage="Please enter a valid email address." CssClass="validator" Display="Dynamic"></asp:RegularExpressionValidator>   
             </div>

                <!--Password-->
                <div class="form-group">
                    <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <!--Confirm Password-->
                <div class="form-group">
                    <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." CssClass="validator" Display="Dynamic"></asp:CompareValidator>
                </div>
                <!--Buttons-->
                <div class="button-group">
                    <asp:Button ID="btnAddTrainer" runat="server" Text="Create Trainer" CssClass="save-button" OnClick="btnAddTrainer_Click"/>
                    <a href="AdminDashboard.aspx" class="cancel-button">Cancel</a>
                </div>
                <!--Server Message-->
                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
            </div>
    </form>
</body>
</html>
