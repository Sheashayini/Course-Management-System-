using course_management_system.Security;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace course_management_system.Admin
{
    public partial class AddTrainer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only Admin can access this page

            if (Session["UserId"] == null)
            {
                Response.Redirect("../SignIn.aspx");
                return;
            }

            if (Session["Role"] == null ||
                Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("../SignIn.aspx");
                return;
            }
        }

        protected void btnAddTrainer_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";


            // Check validation controls

            if (!Page.IsValid)
            {
                return;
            }


            string firstName =
                txtFirstName.Text.Trim();

            string lastName =
                txtLastName.Text.Trim();
            string MobileNumber =
                txtMobileNumber.Text.Trim();    

            string email =
                txtEmail.Text.Trim();

            string password =
                txtPassword.Text;


            // Validate email format

            try
            {
                MailAddress mail =
                    new MailAddress(email);

                if (mail.Address != email)
                {
                    lblMessage.Text =
                        "Please enter a valid email address.";

                    return;
                }
            }
            catch
            {
                lblMessage.Text =
                    "Please enter a valid email address.";

                return;
            }


            // Password length validation

            if (password.Length < 6)
            {
                lblMessage.Text =
                    "Password must contain at least 6 characters.";

                return;
            }


            try
            {
                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    con.Open();


                    // Check duplicate email

                    string checkQuery = @"
                        SELECT COUNT(*)
                        FROM Users
                        WHERE Email = @Email";


                    using (SqlCommand checkCmd =
                           new SqlCommand(
                               checkQuery, con))
                    {
                        checkCmd.Parameters.AddWithValue(
                            "@Email", email);


                        int count =
                            Convert.ToInt32(
                                checkCmd.ExecuteScalar());


                        if (count > 0)
                        {
                            lblMessage.Text =
                                "This email is already registered.";

                            return;
                        }
                    }


                    // Hash password

                    string passwordHash =
                        PasswordHelper.HashPassword(password);


                    // Automatically assign Trainer role

                    string role = "Trainer";


                    // Insert Trainer

                    string insertQuery = @"
                        INSERT INTO Users
                        (
                            FirstName,
                            LastName,
                            MobileNumber,
                            Email,
                            PasswordHash,
                            Role,
                            IsActive
                        )
                        VALUES
                        (
                            @FirstName,
                            @LastName,
                            @MobileNumber,
                            @Email,
                            @PasswordHash,
                            @Role,
                            @IsActive
                        )";


                    using (SqlCommand cmd =
                           new SqlCommand(
                               insertQuery, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@FirstName", firstName);

                        cmd.Parameters.AddWithValue(
                            "@LastName", lastName);

                        cmd.Parameters.AddWithValue(
                            "@MobileNumber", MobileNumber);

                        cmd.Parameters.AddWithValue(
                            "@Email", email);

                        cmd.Parameters.AddWithValue(
                            "@PasswordHash", passwordHash);

                        cmd.Parameters.AddWithValue(
                            "@Role", role);

                        cmd.Parameters.AddWithValue(
                            "@IsActive", true);


                        int result =
                            cmd.ExecuteNonQuery();


                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Trainer account created successfully.";

                            ClearFields();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Unable to create trainer account.";
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Something went wrong while creating the trainer account.";
            }
        }


        private void ClearFields()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtMobileNumber.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}
