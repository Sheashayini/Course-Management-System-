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
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (!Page.IsValid)
            {
                return;
            }

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            try
            {
                using (SqlConnection con = DbConnection.GetConnection())
                {
                    con.Open();

                    string query = @"SELECT UserId, FirstName, LastName, PasswordHash, Role, IsActive
                             FROM Users
                             WHERE Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Correct parameter
                        cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar, 150).Value = email;

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (!reader.Read())
                            {
                                ShowErrorMessage();
                                return;
                            }

                            int userId = Convert.ToInt32(reader["UserId"]);
                            string firstName = Convert.ToString(reader["FirstName"]);
                            string lastName = Convert.ToString(reader["LastName"]);
                            string storedHash = Convert.ToString(reader["PasswordHash"]);
                            string role = Convert.ToString(reader["Role"]);
                            bool isActive = Convert.ToBoolean(reader["IsActive"]);

                            if (!isActive)
                            {
                                lblMessage.Text = "Your account is not active. Please contact the administrator.";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                                return;
                            }

                            bool passwordValid =
                                PasswordHelper.VerifyPassword(password, storedHash);

                            if (!passwordValid)
                            {
                                ShowErrorMessage();
                                return;
                            }

                            // Login successful
                            CreateUserSession(
                                userId,
                                firstName,
                                lastName,
                                email,
                                role
                            );

                            RedirectUser(role);
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                /*lblMessage.Text =
                    "Unable to process your request right now. Please try again later.";

                lblMessage.ForeColor = System.Drawing.Color.Red;*/
                lblMessage.Text = "SQL Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        
        // Displays a common login error message 
        // This prevents revealing whether an email exists
        private void ShowErrorMessage()
        {
            lblMessage.Text = "Invalid email or password.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            // Clear password after failed login
            txtPassword.Text = "";
        }
        // Creates session values after successful login
        private void CreateUserSession(int userId, string firstName, string lastName, string email, string role)
        {
            Session["UserId"] = userId;
            Session["FirstName"] = firstName;
            Session["LastName"] = lastName;
            Session["Email"] = email;
            Session["Role"] = role;
        } 
        // Redirect user according to role
        private void RedirectUser(string role)
        {
            switch (role)
            {
                case "Admin":
                    Response.Redirect("~/Admin/AdminDashboard.aspx");
                    break;
                case "Trainer":
                    Response.Redirect("~/Trainer/TrainerDashboard.aspx");
                    break;
                case "Student":
                    Response.Redirect("~/Student/StudentDashboard.aspx");
                    break;

                default:
                    // Invalid role
                    Session.Clear();
                    lblMessage.Text = "Your account has an invalid role.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    break;

            }
        }
    }
}