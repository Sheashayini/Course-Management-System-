using System;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI.WebControls;

namespace course_management_system.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check login
            if (Session["UserId"] == null)
            {
                Response.Redirect("../SignIn.aspx");
                return;
            }

            // Only Admin can access this page
            if (Session["Role"] == null ||
                Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("../SignIn.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUsers();
            }
        }


        // LOAD USERS
        private void LoadUsers()
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
                            MobileNumber,
                            Email,
                            Role,
                            CASE
                                WHEN IsActive = 1
                                THEN 'Active'
                                ELSE 'Inactive'
                            END AS Status,
                            CreatedDate
                        FROM Users
                        WHERE Role IN ('Student', 'Trainer')
                        ORDER BY CreatedDate ASC";

                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        using (SqlDataAdapter da =
                               new SqlDataAdapter(cmd))
                        {
                            DataTable dt =
                                new DataTable();

                            da.Fill(dt);

                            gvUsers.DataSource = dt;
                            gvUsers.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text =
                    "Unable to load user details: "
                    + ex.Message;

                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
            }
        }


        // EDIT
        protected void gvUsers_RowEditing(
            object sender,
            GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;

            LoadUsers();

            lblMessage.Text = "";
        }


        // CANCEL EDIT
        protected void gvUsers_RowCancelingEdit(
            object sender,
            GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;

            LoadUsers();

            lblMessage.Text = "";
        }


        // UPDATE USER
        protected void gvUsers_RowUpdating(
            object sender,
            GridViewUpdateEventArgs e)
        {
            try
            {
                // Get UserId
                int userId =
                    Convert.ToInt32(
                        gvUsers.DataKeys[e.RowIndex].Value);


                // Get edited values
                string firstName =
                    e.NewValues["FirstName"] == null
                    ? ""
                    : e.NewValues["FirstName"].ToString().Trim();

                string lastName =
                    e.NewValues["LastName"] == null
                    ? ""
                    : e.NewValues["LastName"].ToString().Trim();

                string MobileNumber =
                    e.NewValues["MobileNumber"] == null
                    ? ""
                    : e.NewValues["MobileNumber"].ToString().Trim();

                string email =
                    e.NewValues["Email"] == null
                    ? ""
                    : e.NewValues["Email"].ToString().Trim();


                // First Name validation
                if (string.IsNullOrWhiteSpace(firstName))
                {
                    lblMessage.Text =
                        "First Name is required.";

                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    return;
                }


                // Last Name validation
                if (string.IsNullOrWhiteSpace(lastName))
                {
                    lblMessage.Text =
                        "Last Name is required.";

                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    return;
                }

                // Mobile number validation
                if (string.IsNullOrWhiteSpace(MobileNumber))
                {
                    lblMessage.Text =
                        "Mobile Number is required.";

                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    return;
                }


                // Email validation
                if (string.IsNullOrWhiteSpace(email))
                {
                    lblMessage.Text =
                        "Email is required.";

                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    return;
                }


                // Email must be lowercase
                if (email != email.ToLowerInvariant())
                {
                    lblMessage.Text =
                        "Email must be entered in lowercase.";

                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    return;
                }


                // Validate email format
                try
                {
                    MailAddress mail =
                        new MailAddress(email);
                }
                catch
                {
                    lblMessage.Text =
                        "Please enter a valid email address.";

                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    return;
                }


                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    con.Open();


                    // Check duplicate email
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
                                "Email address already exists.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Red;

                            return;
                        }
                    }


                    // Update Student or Trainer
                    string updateQuery = @"
                        UPDATE Users
                        SET
                            FirstName = @FirstName,
                            LastName = @LastName,
                            MobileNumber=@MobileNumber,
                            Email = @Email
                        WHERE UserId = @UserId
                        AND Role IN ('Student', 'Trainer')";


                    using (SqlCommand cmd =
                           new SqlCommand(updateQuery, con))
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
                            "@UserId", userId);


                        int result =
                            cmd.ExecuteNonQuery();


                        if (result > 0)
                        {
                            gvUsers.EditIndex = -1;

                            LoadUsers();

                            lblMessage.Text =
                                "User updated successfully.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMessage.Text =
                                "User could not be updated.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text =
                    "Unable to update user: "
                    + ex.Message;

                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
            }
        }


        // DELETE USER
        protected void gvUsers_RowDeleting(
            object sender,
            GridViewDeleteEventArgs e)
        {
            try
            {
                // Get UserId
                int userId =
                    Convert.ToInt32(
                        gvUsers.DataKeys[e.RowIndex].Value);


                // Prevent Admin from deleting own account
                if (Session["UserId"] != null &&
                    Session["UserId"].ToString()
                    == userId.ToString())
                {
                    lblMessage.Text =
                        "You cannot delete your own account.";

                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;

                    return;
                }


                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    con.Open();


                    // Admin can delete both Student and Trainer
                    string query = @"
                        DELETE FROM Users
                        WHERE UserId = @UserId
                        AND Role IN ('Student', 'Trainer')";


                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@UserId", userId);


                        int result =
                            cmd.ExecuteNonQuery();


                        if (result > 0)
                        {
                            lblMessage.Text =
                                "User deleted successfully.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMessage.Text =
                                "User could not be deleted.";

                            lblMessage.ForeColor =
                                System.Drawing.Color.Red;
                        }
                    }
                }


                // Reload users
                LoadUsers();
            }
            catch (Exception ex)
            {
                lblMessage.Text =
                    "Unable to delete user: "
                    + ex.Message;

                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
            }
        }
    }
}