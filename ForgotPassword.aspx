<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="course_management_system.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Forgot Password - Course Management System</title>

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

        .forgot-container {
            width: 420px;
            background: #ffffff;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h2 {
            margin: 0 0 8px 0;
            color: #2d3748;
            font-size: 28px;
        }

        .header p {
            margin: 0;
            color: #718096;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #374151;
            font-size: 14px;
        }

        .textbox {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            color: #333;
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
            margin-top: 6px;
        }

        .reset-button {
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

        .reset-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 15px rgba(102, 126, 234, 0.35);
        }

        .message {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-weight: 600;
            font-size: 14px;
        }

        .signin-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
            color: #6b7280;
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
            body {
                padding: 20px;
            }

            .forgot-container {
                width: 100%;
                padding: 30px 25px;
            }

            .header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <div class="forgot-container">

            <!-- Header -->
            <div class="header">
                <h2>Reset Password</h2>
                <p>Reset your Course Management account password</p>
            </div>

            <!-- Email -->
            <div class="form-group">

                <asp:Label ID="lblEmail"
                    runat="server"
                    Text="Email">
                </asp:Label>

                <asp:TextBox ID="txtEmail"
                    runat="server"
                    CssClass="textbox"
                    TextMode="Email"
                    placeholder="Enter your registered email">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email address is required."
                    Text="Email address is required."
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator
                    ID="revEmail"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Please enter a valid email address."
                    Text="Please enter a valid email address."
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RegularExpressionValidator>

            </div>

            <!-- New Password -->
            <div class="form-group">

                <asp:Label ID="lblNewPassword"
                    runat="server"
                    Text="New Password">
                </asp:Label>

                <asp:TextBox ID="txtNewPassword"
                    runat="server"
                    CssClass="textbox"
                    TextMode="Password"
                    placeholder="Enter new password">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvNewPassword"
                    runat="server"
                    ControlToValidate="txtNewPassword"
                    ErrorMessage="New password is required."
                    Text="New password is required."
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator
                    ID="revNewPassword"
                    runat="server"
                    ControlToValidate="txtNewPassword"
                    ValidationExpression="^.{6,}$"
                    ErrorMessage="Password must contain at least 6 characters."
                    Text="Password must contain at least 6 characters."
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RegularExpressionValidator>

            </div>

            <!-- Confirm Password -->
            <div class="form-group">

                <asp:Label ID="lblConfirmPassword"
                    runat="server"
                    Text="Confirm Password">
                </asp:Label>

                <asp:TextBox ID="txtConfirmPassword"
                    runat="server"
                    CssClass="textbox"
                    TextMode="Password"
                    placeholder="Confirm new password">
                </asp:TextBox>

                <asp:RequiredFieldValidator
                    ID="rfvConfirmPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Please confirm your password."
                    Text="Please confirm your password."
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>

                <asp:CompareValidator
                    ID="cvPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtNewPassword"
                    ErrorMessage="Passwords do not match."
                    Text="Passwords do not match."
                    CssClass="validator"
                    Display="Dynamic">
                </asp:CompareValidator>

            </div>

            <!-- Reset Button -->

            <asp:Button
                ID="btnResetPassword"
                runat="server"
                Text="Reset Password"
                CssClass="reset-button"
                OnClick="btnResetPassword_Click" />

            <!-- Message -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

            <!-- Back to Sign In -->

            <div class="signin-link">
                Remember your password?
                <a href="SignIn.aspx">Sign In</a>
            </div>

        </div>
    </form>
</body>
</html>
