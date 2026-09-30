using course_management_system.Security;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace course_management_system.Admin
{
    public partial class ManageTrainers : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                LoadTrainers();
            }
        }
        private void LoadTrainers()
        {
            try
            {
                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    string query = @"
                        SELECT
                            UserId,
                            FirstName,
                            LastName,
                            Email,
                            CASE
                                WHEN IsActive = 1
                                THEN 'Active'
                                ELSE 'Inactive'
                            END AS Status,
                            CreatedDate
                        FROM Users
                        WHERE Role = 'Trainer'
                        ORDER BY CreatedDate DESC";

                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        using (SqlDataAdapter da =
                               new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            da.Fill(dt);

                            gvTrainers.DataSource = dt;
                            gvTrainers.DataBind();
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Unable to load trainer details.";
            }
        }
        protected void gvTrainers_RowCommand(
    object sender,
    GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ResetPassword")
            {
                int userId = Convert.ToInt32(e.CommandArgument);

                ResetUserPassword(userId);
            }
        }
        private void ResetUserPassword(int userId)
        {
            string temporaryPassword = GenerateTemporaryPassword();

            string passwordHash =
                PasswordHelper.HashPassword(temporaryPassword);

            try
            {
                using (SqlConnection con = DbConnection.GetConnection())
                {
                    con.Open();

                    string query = @"
                UPDATE Users
                SET PasswordHash = @PasswordHash
                WHERE UserId = @UserId
                AND Role = 'Trainer'";

                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add(
                            "@PasswordHash",
                            SqlDbType.VarChar,
                            500).Value = passwordHash;

                        cmd.Parameters.Add(
                            "@UserId",
                            SqlDbType.Int).Value = userId;

                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Password reset successfully. Temporary password: "
                                + temporaryPassword;

                            lblMessage.ForeColor =
                                System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMessage.Text =
                                "Unable to reset password.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (SqlException)
            {
                lblMessage.Text =
                    "Unable to reset password right now.";

                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
            }
        }
        private string GenerateTemporaryPassword()
        {
            return "Temp@" +
                   Guid.NewGuid()
                       .ToString("N")
                       .Substring(0, 8);
        }
        protected void gvTrainers_RowEditing(
            object sender,
            System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvTrainers.EditIndex = e.NewEditIndex;

            LoadTrainers();
        }

        protected void gvTrainers_RowCancelingEdit(
            object sender,
            System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvTrainers.EditIndex = -1;

            LoadTrainers();
        }

        protected void gvTrainers_RowUpdating(
            object sender,
            System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvTrainers.Rows[e.RowIndex];

            int userId =
                Convert.ToInt32(
                    gvTrainers.DataKeys[e.RowIndex].Value);

            string firstName =
                ((System.Web.UI.WebControls.TextBox)
                row.Cells[1].Controls[0]).Text.Trim();

            string lastName =
                ((System.Web.UI.WebControls.TextBox)
                row.Cells[2].Controls[0]).Text.Trim();

            string email =
                ((System.Web.UI.WebControls.TextBox)
                row.Cells[3].Controls[0]).Text.Trim();

            // Required field validation
            if (string.IsNullOrWhiteSpace(firstName))
            {
                lblMessage.Text =
                    "First Name is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(lastName))
            {
                lblMessage.Text =
                    "Last Name is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(email))
            {
                lblMessage.Text =
                    "Email is required.";
                return;
            }

            // Basic email validation
            try
            {
                System.Net.Mail.MailAddress mail =
                    new System.Net.Mail.MailAddress(email);

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

            try
            {
                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    con.Open();

                    // Check whether email is already
                    // used by another account
                    string checkQuery = @"
                        SELECT COUNT(*)
                        FROM Users
                        WHERE Email = @Email
                        AND UserId <> @UserId";

                    using (SqlCommand checkCmd =
                           new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.AddWithValue(
                            "@Email", email);

                        checkCmd.Parameters.AddWithValue(
                            "@UserId", userId);

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

                    string updateQuery = @"
                        UPDATE Users
                        SET
                            FirstName = @FirstName,
                            LastName = @LastName,
                            Email = @Email
                        WHERE UserId = @UserId
                        AND Role = 'Trainer'";

                    using (SqlCommand cmd =
                           new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@FirstName", firstName);

                        cmd.Parameters.AddWithValue(
                            "@LastName", lastName);

                        cmd.Parameters.AddWithValue(
                            "@Email", email);

                        cmd.Parameters.AddWithValue(
                            "@UserId", userId);

                        int result =
                            cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Trainer details updated successfully.";

                            gvTrainers.EditIndex = -1;

                            LoadTrainers();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Unable to update trainer details.";
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Something went wrong while updating the trainer.";
            }
        }
    }

}

