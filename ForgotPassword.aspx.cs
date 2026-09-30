using course_management_system.Security;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace course_management_system
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string email = txtEmail.Text.Trim();
            string newPassword = txtNewPassword.Text;

            try
            {
                using (SqlConnection con = DbConnection.GetConnection())
                {
                    string query = @"SELECT UserId 
                                     FROM Users 
                                     WHERE Email = @Email 
                                     AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        con.Open();

                        object result = cmd.ExecuteScalar();

                        if (result == null)
                        {
                            lblMessage.Text = "No active account found with this email address.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            return;
                        }

                        int userId = Convert.ToInt32(result);

                        // Hash the new password
                        string passwordHash = PasswordHelper.HashPassword(newPassword);

                        string updateQuery = @"UPDATE Users
                                               SET PasswordHash = @PasswordHash
                                               WHERE UserId = @UserId";

                        using (SqlCommand updateCmd =
                               new SqlCommand(updateQuery, con))
                        {
                            updateCmd.Parameters.AddWithValue(
                                "@PasswordHash", passwordHash);

                            updateCmd.Parameters.AddWithValue(
                                "@UserId", userId);

                            int rowsAffected = updateCmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                lblMessage.Text =
                                    "Password reset successfully. You can now sign in.";

                                lblMessage.ForeColor =
                                    System.Drawing.Color.Green;

                                txtEmail.Text = "";
                                txtNewPassword.Text = "";
                                txtConfirmPassword.Text = "";
                            }
                            else
                            {
                                lblMessage.Text =
                                    "Password reset failed. Please try again.";

                                lblMessage.ForeColor =
                                    System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "An error occurred while resetting the password.";

                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
            }
        }
    }
}