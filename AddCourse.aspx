<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCourse.aspx.cs" Inherits="course_management_system.Admin.AddCourse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Course - Course Management</title>
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
    font-weight: 500;
}

.back-btn:hover {
    background: rgba(255,255,255,0.3);
}

.container {
    width: 90%;
    max-width: 770px;
    margin: 50px auto;
}

.card {
    background: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 6px 22px rgba(0,0,0,0.08);
}

.card h2 {
    margin-top: 0;
    margin-bottom: 24px;
    color: #263238;
    font-size: 30px;
}

.card p {
    margin-bottom: 25px;
    font-size: 18px;
    color: #222;
}

.form-group {
    margin-bottom: 22px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: normal;
    color: #222;
    font-size: 18px;
}

.textbox {
    width: 100%;
    height: 50px;
    padding: 0 14px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-sizing: border-box;
    font-size: 16px;
}

.textbox:focus {
    border-color: #667eea;
    outline: none;
}

.validator {
    color: #dc3545;
    font-size: 13px;
    display: block;
    margin-top: 5px;
}

.message {
    display: block;
    margin-bottom: 20px;
    font-weight: bold;
}

.btn {
    width: 100%;
    padding: 14px;
    border: none;
    border-radius: 4px;
    background: #667eea;
    color: white;
    font-size: 20px;
    cursor: pointer;
}

.btn:hover {
    background: #5568d9;
}

.cancel {
    display: block;
    text-align: center;
    margin-top: 18px;
    color: #667eea;
    text-decoration: none;
    font-size: 18px;
}

.cancel:hover {
    text-decoration: underline;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <h2>Add Course</h2>
            <a href="AdminDashboard.aspx" class="back-btn">
                ← Dashboard
            </a>
        </div>
        <div class="container">
            <div class="card">
                <h2>Create New Course</h2>
                <p>Enter the course details below.</p>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
                
                <div class="form-group">

    <asp:Label ID="lblCourseName" runat="server" Text="Course Name"></asp:Label>

    <asp:TextBox ID="txtCourseName" runat="server"
        CssClass="textbox"
        placeholder="Course Name">
    </asp:TextBox>

    <asp:RequiredFieldValidator ID="rfvCourseName"
        runat="server"
        ControlToValidate="txtCourseName"
        ErrorMessage="Course Name is required."
        CssClass="validator"
        Display="Dynamic">
    </asp:RequiredFieldValidator>

</div>
               
            <!--Trainer Name-->
            <div class="form-group">
                
                <asp:Label ID="lblTrainerName" runat="server" Text="Trainer Name"></asp:Label>
                <asp:TextBox ID="txtTrainerName" runat="server" CssClass="textbox" placeholder="Trainer Name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTrainerName" runat="server" ControlToValidate="txtTrainerName" ErrorMessage="Trainer Name is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
               
              
           
            <!--Duration-->
            <div class="form-group">
                   
                <asp:Label ID="lblDuration" runat="server" Text="Duration (in weeks)"></asp:Label>
                <asp:TextBox ID="txtDuration" runat="server" CssClass="textbox" TextMode="Number" placeholder="Duration (in weeks)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDuration" runat="server" ControlToValidate="txtDuration" ErrorMessage="Duration is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvDuration" runat="server" ControlToValidate="txtDuration" MinimumValue="1" MaximumValue="520" Type="Integer" ErrorMessage="Duration must be between 1 and 520 weeks." CssClass="validator" Display="Dynamic"></asp:RangeValidator>
            </div>
              
                
            <!--Fees-->
            <div class="form-group">
              
                <asp:Label ID="lblFees" runat="server" Text="Fees (in Rupees)"></asp:Label>
                <asp:TextBox ID="txtFees" runat="server" CssClass="textbox" TextMode="Number" placeholder="Fees (in Rupees)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFees" runat="server" ControlToValidate="txtFees" ErrorMessage="Course fees is required." CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <regularexpressionvalidator ID="revFees" runat="server" ControlToValidate="txtFees" ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="Please enter a valid fee amount." CssClass="validator" Display="Dynamic"></regularexpressionvalidator>
            </div>
                
                

            <!--Buttons-->
            
                <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" CssClass="btn" OnClick="btnAddCourse_Click" />
                <a href="AdminDashboard.aspx" class="cancel">Cancel</a>
            
            </div>
       </div>

    </form>
</body>
</html>
