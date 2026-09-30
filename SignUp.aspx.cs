using course_management_system.Security;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace course_management_system
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            //check ASP>NET validation Controls
            if(!Page.IsValid)
            {
                return;
            }
            string FirstName = txtFirstName.Text.Trim();
            string LastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string MobileNumber = txtMobileNumber.Text.Trim();
            string password = txtPassword.Text;

            

            if (email != email.ToLowerInvariant())
            {
                lblMessage.Text = "Email must be entered in lowercase.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection con = DbConnection.GetConnection())
                {
                    con.Open();

                    // Check whether email already exists
                    string checkQuery = @"
                        SELECT COUNT(*)
                        FROM Users
                        WHERE Email = @Email";

                    using (SqlCommand checkCmd =
                           new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.AddWithValue(
                            "@Email", email);

                        int count = Convert.ToInt32(
                            checkCmd.ExecuteScalar());

                        if (count > 0)
                        {
                            lblMessage.Text =
                                "Email already exists.";

                            return;
                        }
                    }

                    // Hash password
                    string passwordHash =
                        PasswordHelper.HashPassword(password);

                    // Student role is assigned automatically
                    string role = "Student";

                    // Insert student into Users table
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
                            1
                        )";

                    using (SqlCommand cmd =
                           new SqlCommand(insertQuery, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@FirstName", FirstName);

                        cmd.Parameters.AddWithValue(
                            "@LastName", LastName);


                        cmd.Parameters.AddWithValue(
                            "@MobileNumber", MobileNumber);

                        cmd.Parameters.AddWithValue(
                            "@Email", email);


                        cmd.Parameters.AddWithValue(
                            "@PasswordHash", passwordHash);

                        cmd.Parameters.AddWithValue(
                            "@Role", role);

                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Student registration successful!";

                            ClearFields();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Registration failed.";
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "An error occurred during registration.";
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
        