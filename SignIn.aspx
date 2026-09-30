<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="course_management_system.SignIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign In - Course Management System</title>
    <style> 
        * { box-sizing: border-box; } 
        body { margin: 0; padding: 0; font-family: Arial, Helvetica, sans-serif; background: linear-gradient(135deg, #667eea, #764ba2); min-height: 100vh; display: flex; justify-content: center; align-items: center; } 
        /* Main Container */
        .signin-container { width: 420px; background: #ffffff; padding: 40px; border-radius: 18px; box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25); animation: fadeIn 0.5s ease-in-out; } 
        /* Animation */ 
        @keyframes fadeIn { 
            from { opacity: 0; transform: translateY(20px); } 
            to { opacity: 1; transform: translateY(0); } } 
        /* Heading */ 
        .header { text-align: center; margin-bottom: 30px; } 
        .header h2 { margin: 0 0 8px 0; color: #2d3748; font-size: 28px; } 
        .header p { margin: 0; color: #718096; font-size: 14px; } 
        /* Form Group */ 
        .form-group { margin-bottom: 20px; } 
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #374151; font-size: 14px; } 
        /* TextBox */
        .textbox { width: 100%; padding: 13px 14px; border: 1px solid #d1d5db; border-radius: 8px; font-size: 15px; color: #333; outline: none; transition: 0.3s; } 
        .textbox:focus { border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15); } 
        .textbox::placeholder { color: #a0aec0; } 
        /* Validation Error */ 
        .validator { display: block; color: #dc2626; font-size: 12px; margin-top: 6px; } 
        /* Validation Summary */ 
        .validation-summary { background: #fff5f5; border: 1px solid #feb2b2; color: #c53030; border-radius: 8px; padding: 10px 12px; margin-bottom: 18px; font-size: 13px; } 
        /* Sign In Button */ 
        .signin-button { width: 100%; padding: 13px; border: none; border-radius: 8px; background: linear-gradient( 135deg, #667eea, #764ba2 ); color: white; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; margin-top: 5px; } 
        .signin-button:hover { transform: translateY(-1px); box-shadow: 0 6px 15px rgba(102, 126, 234, 0.35); } 
        .signin-button:active { transform: translateY(0); } 
        /* Server Message */ 
        .message { display: block; text-align: center; margin-top: 15px; font-weight: 600; font-size: 14px; } 
        /* Sign Up Section */ 
        .signup-link { text-align: center; margin-top: 25px; padding-top: 20px; border-top: 1px solid #e5e7eb; color: #6b7280; font-size: 14px; } 
        .signup-link a { color: #667eea; text-decoration: none; font-weight: bold; margin-left: 4px; } 
        .signup-link a:hover { text-decoration: underline; } 
        /* Mobile Responsive */
        @media (max-width: 500px) { body { padding: 20px; } 
                                    .signin-container { width: 100%; padding: 30px 25px; } 
                                    .header h2 { font-size: 24px; } } 

    </style>
   </head>
<body>
    <form id="form1" runat="server">
        <div class="signin-container">

            <!--Header-->

            <div class="header">
                <h2>Welcome Back</h2>
                <p>Sign in to your Course Management account</p>
            </div>
            <!-- Validation Summary-->

            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-summary" HeaderText="Please correct the following:" DisplayMode="BulletList"></asp:ValidationSummary>

            <!--Email-->
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" TextMode="Email" placeholder="Enter Your Email Address"></asp:TextBox>
                
                <!--Required Email-->

                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email address is required." Text="Email Address is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                
                <!--Email Format-->

                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Please enter a valid email address." Text="Please enter a valid email address." CssClass="validator" Display="Dynamic"> </asp:RegularExpressionValidator>

            </div>
            <!--Password-->
            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" TextMode="Password" placeholder="Enter Your Password"></asp:TextBox>
                
                <!--Required Password-->

                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." Text="Password is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <!--Minimum password required-->

                <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"  ValidationExpression="^.{6,}$" ErrorMessage="Password must contain at least 6 characters." Text="Password must contain at least 6 characters." CssClass="validator" Display="Dynamic"> </asp:RegularExpressionValidator>
            </div>
            <!--reset password-->
           <!-- Forgot Password -->
<div style="text-align: right; margin-top: -10px; margin-bottom: 15px;">
    <asp:HyperLink ID="lnkForgotPassword"
        runat="server"
        NavigateUrl="~/ForgotPassword.aspx"
        Text="Forgot Password?"
        style="color: #667eea; text-decoration: none; font-size: 14px;">
    </asp:HyperLink>
</div>



        <!--SignIn Button-->
            <asp:Button ID="btnSignIn" runat="server" Text="Sign In" CssClass="signin-button" OnClick="btnSignIn_Click" />


            <!--Server Message-->
            <asp:Label ID="lblMessage" runat="server" CssClass="message" ></asp:Label>

            <!--Sign Up-->
            <div class="signup-link">
                New Student?
                <a href="SignUp.aspx"> Create Student Account</a>
            </div>
        </div>
    </form>
</body>
</html>
