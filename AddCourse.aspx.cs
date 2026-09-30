using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace course_management_system.Admin
{
    public partial class AddCourse : System.Web.UI.Page
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

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            // Check ASP.NET validators
            if (!Page.IsValid)
            {
                return;
            }

            string courseName =
                txtCourseName.Text.Trim();

            string trainerName =
                txtTrainerName.Text.Trim();

            int duration;

            decimal fees;

            // Validate duration
            if (!int.TryParse(
                txtDuration.Text.Trim(),
                out duration))
            {
                lblMessage.Text =
                    "Please enter a valid duration.";

                return;
            }

            // Validate fees
            if (!decimal.TryParse(
                txtFees.Text.Trim(),
                out fees))
            {
                lblMessage.Text =
                    "Please enter a valid fee amount.";

                return;
            }

            // Extra validation
            if (duration <= 0)
            {
                lblMessage.Text =
                    "Duration must be greater than zero.";

                return;
            }

            if (fees < 0)
            {
                lblMessage.Text =
                    "Course fees cannot be negative.";

                return;
            }

            try
            {
                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    con.Open();

                    string query = @"
                        INSERT INTO Courses
                        (
                            CourseName,
                            TrainerName,
                            Duration,
                            Fees,
                            CreatedBy,
                            CreatedDate
                        )
                        VALUES
                        (
                            @CourseName,
                            @TrainerName,
                            @Duration,
                            @Fees,
                            @CreatedBy,
                            GETDATE()
                        )";

                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CourseName",
                            courseName);

                        cmd.Parameters.AddWithValue(
                            "@TrainerName",
                            trainerName);

                        cmd.Parameters.AddWithValue(
                            "@Duration",
                            duration);

                        cmd.Parameters.AddWithValue(
                            "@Fees",
                            fees);

                        cmd.Parameters.AddWithValue(
                            "@CreatedBy",
                            Convert.ToInt32(
                                Session["UserId"]));

                        int result =
                            cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Course added successfully.";

                            ClearFields();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Unable to add course.";
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Something went wrong while adding the course.";
            }
        }

        private void ClearFields()
        {
            txtCourseName.Text = "";
            txtTrainerName.Text = "";
            txtDuration.Text = "";
            txtFees.Text = "";
        }
    }
}
    
