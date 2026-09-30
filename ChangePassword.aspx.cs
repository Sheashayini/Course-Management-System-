using course_management_system.Security;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace course_management_system
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check whether user is logged in
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (!Page.IsValid)
            {
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            string currentPassword = txtCurrentPassword.Text;
            string newPassword = txtNewPassword.Text;

            try
            {
                using (SqlConnection con = DbConnection.GetConnection())
                {
                    con.Open();

                    // Get current password hash
                    string selectQuery = @"
                        SELECT PasswordHash
                        FROM Users
                        WHERE UserId = @UserId
                        AND IsActive = 1";

                    string storedHash = null;

                    using (SqlCommand cmd =
                           new SqlCommand(selectQuery, con))
                    {
                        cmd.Parameters.Add(
                            "@UserId",
                            SqlDbType.Int).Value = userId;

                        object result = cmd.ExecuteScalar();

                        if (result == null)
                        {
                            lblMessage.Text =
                                "User account not found.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Red;

                            return;
                        }

                        storedHash = result.ToString();
                    }

                    // Verify current password
                    bool currentPasswordValid =
                        PasswordHelper.VerifyPassword(
                            currentPassword,
                            storedHash);

                    if (!currentPasswordValid)
                    {
                        lblMessage.Text =
                            "Current password is incorrect.";

                        lblMessage.ForeColor =
                            System.Drawing.Color.Red;

                        txtCurrentPassword.Text = "";

                        return;
                    }

                    // Hash new password
                    string newPasswordHash =
                        PasswordHelper.HashPassword(newPassword);

                    // Update password
                    string updateQuery = @"
                        UPDATE Users
                        SET PasswordHash = @PasswordHash
                        WHERE UserId = @UserId";

                    using (SqlCommand cmd =
                           new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.Add(
                            "@PasswordHash",
                            SqlDbType.VarChar,
                            500).Value = newPasswordHash;

                        cmd.Parameters.Add(
                            "@UserId",
                            SqlDbType.Int).Value = userId;

                        int result =
                            cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Password changed successfully.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Green;

                            ClearFields();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Password change failed.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (SqlException)
            {
                lblMessage.Text =
                    "Unable to change password right now. Please try again.";

                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
            }
        }

        private void ClearFields()
        {
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}
 