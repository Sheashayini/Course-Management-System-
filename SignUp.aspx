<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="course_management_system.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up - Course Management System</title>
    <style>

    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        padding: 0;
        font-family: Arial, Helvetica, sans-serif;
        background: linear-gradient(135deg, #667eea, #764ba2);
        min-height: 100vh;

        display: flex;
        justify-content: center;
        align-items: center;
    }

    .signup-container {
        width: 450px;
        max-width: 95%;
        background: #ffffff;
        padding: 35px 40px;

        border-radius: 16px;

        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.20);
    }

    .header {
        text-align: center;
        margin-bottom: 28px;
    }

    .header h2 {
        margin: 0;
        color: #333;
        font-size: 28px;
    }

    .header p {
        margin-top: 8px;
        color: #777;
        font-size: 14px;
    }

    .form-group {
        margin-bottom: 18px;
    }

    .form-group label {
        display: block;
        margin-bottom: 7px;
        font-weight: bold;
        color: #444;
        font-size: 14px;
    }

    .textbox {
        width: 100%;
        padding: 12px 13px;

        border: 1px solid #d1d5db;
        border-radius: 8px;

        font-size: 14px;
        outline: none;

        transition: 0.3s;
    }

    .textbox:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
    }

    .validator {
        display: block;
        color: #dc2626;
        font-size: 12px;
        margin-top: 5px;
    }

    .signup-button {
        width: 100%;
        padding: 13px;

        border: none;
        border-radius: 8px;

        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;

        font-size: 16px;
        font-weight: bold;

        cursor: pointer;

        transition: 0.3s;
    }

    .signup-button:hover {
        transform: translateY(-1px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.35);
    }

    .message {
        display: block;
        text-align: center;
        margin-top: 15px;
        font-weight: bold;
        font-size: 14px;
    }

    .validation-summary {
        margin-bottom: 15px;
        padding: 10px;
        border-radius: 7px;
        color: #dc2626;
        background: #fef2f2;
        font-size: 13px;
    }

    .signin-link {
        text-align: center;
        margin-top: 22px;
        color: #666;
        font-size: 14px;
    }

    .signin-link a {
        color: #667eea;
        text-decoration: none;
        font-weight: bold;
    }

    .signin-link a:hover {
        text-decoration: underline;
    }

    @media (max-width: 500px) {

        .signup-container {
            padding: 25px 20px;
        }

        .header h2 {
            font-size: 24px;
        }
    }

</style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <!--Header-->
            <div class="header">
                <h2>Sign Up</h2>
                <p>Create your account to access the course management system</p>
            </div>
            <!-- Validation Summary -->
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-summary" HeaderText="Please correct the following:" DisplayMode="BulletList"/>

            <!--First Name-->
            <div class="form-group">
                <asp:Label ID="lblFName" runat="server" Text="First Name"></asp:Label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="textbox" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name is required." Display="Dynamic" CssClass="validator"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txtFirstName" ValidationExpression="^[A-Za-z ]+$" ErrorMessage="First Name should contain only letters." Display="Dynamic" CssClass="validator"> </asp:RegularExpressionValidator>

            </div>
            <!--Last Name-->
            <div class="form-group">
                <asp:Label ID="lblLName" runat="server" Text="Last Name"></asp:Label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="textbox" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvfLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is required." Display="Dynamic" CssClass="validator"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revlastName" runat="server" ControlToValidate="txtLastName" ValidationExpression="^[A-Za-z ]+$" ErrorMessage="Last Name should contain only letters." Display="Dynamic" CssClass="validator"> </asp:RegularExpressionValidator>
            </div>

            <!--Mobile Number-->
            <div class="form-group">
                <asp:Label ID="lblMobileNumber" runat="server" Text="Mobile Number" placeholder="Enter Mobile Number"></asp:Label>
                <asp:TextBox ID="txtMobileNumber" runat="server" CssClass="textbox" MaxLength="10"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobileNumber" runat="server" ControlToValidate="txtMobileNumber" ErrorMessage="Mobile Number is required." Display="Dynamic" ForeColor="Red" CssClass="validator"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revMobileNumber" runat="server" ControlToValidate="txtMobileNumber" ValidationExpression="^\d{10}$" ErrorMessage="Enter a valid 10-Digit Number" ValidatorExpression="^[6-9][0-9]{9}$" ForeColor="Red" Display="Dynamic" CssClass="validator"></asp:RegularExpressionValidator>
            </div>
            <!--Email-->
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" TextMode="Email" MaxLength="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email Address is Required." Display="Dynamic" CssClass="validator"></asp:RequiredFieldValidator>
               <asp:RegularExpressionValidator
                    ID="revEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[a-z][a-z0-9._%+-]*@[a-z0-9.-]+\.[a-z]{2,}$"
                    ErrorMessage="Email must start with a lowercase letter and contain only lowercase letters."
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RegularExpressionValidator>
            </div>

            <!--Password-->
            <div class="form-group" >
                <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." ></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d).{8,}$" ErrorMessage="Password must be at least 8 characters and contain at least one letter and one number." Display="Dynamic" 
                    CssClass="validator"> </asp:RegularExpressionValidator>
            </div>
            <!--confirm Password-->
            <div class="form-group">
                <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="textbox" TextMode="Password" MaxLength="50"> </asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Please confirm your password." Display="Dynamic" CssClass="validator"> </asp:RequiredFieldValidator> 
                <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" Operator="Equal" Type="String" ErrorMessage="Passwords do not match." Display="Dynamic" CssClass="validator"> </asp:CompareValidator>
            </div>
            <!-- Sign Up Button --> 

            <asp:Button ID="btnSignUp" runat="server" Text="Create Account" CssClass="signup-button" OnClick="btnSignUp_Click" />
            <!-- Message -->
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message"> </asp:Label> 
            <!-- Sign In --> 
            <div class="signin-link">
                Already have an account?
                <a href="SignIn.aspx">Sign In</a> 

            </div>

        </div>
    </form>
</body>
</html>
