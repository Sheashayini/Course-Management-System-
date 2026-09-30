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
    public partial class ManageCourse : System.Web.UI.Page
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
                LoadCourses();
            }
        }

        private void LoadCourses()
        {
            try
            {
                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    string query = @"
                        SELECT
                            CourseId,
                            CourseName,
                            TrainerName,
                            Duration,
                            Fees,
                            CreatedDate
                        FROM Courses
                        ORDER BY CreatedDate ASC";

                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        using (SqlDataAdapter da =
                               new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            da.Fill(dt);

                            gvCourses.DataSource = dt;
                            gvCourses.DataBind();
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Unable to load course details.";
            }
        }

        protected void gvCourses_RowEditing(
            object sender,
            System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;

            LoadCourses();
        }

        protected void gvCourses_RowCancelingEdit(
            object sender,
            System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;

            LoadCourses();
        }

        protected void gvCourses_RowUpdating(
            object sender,
            System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            System.Web.UI.WebControls.GridViewRow row =
                gvCourses.Rows[e.RowIndex];

            int courseId =
                Convert.ToInt32(
                    gvCourses.DataKeys[e.RowIndex].Value);

            string courseName =
                ((System.Web.UI.WebControls.TextBox)
                row.Cells[1].Controls[0]).Text.Trim();

            string trainerName =
                ((System.Web.UI.WebControls.TextBox)
                row.Cells[2].Controls[0]).Text.Trim();

            string durationText =
                ((System.Web.UI.WebControls.TextBox)
                row.Cells[3].Controls[0]).Text.Trim();

            string feesText =
                ((System.Web.UI.WebControls.TextBox)
                row.Cells[4].Controls[0]).Text.Trim();

            // Required validation
            if (string.IsNullOrWhiteSpace(courseName))
            {
                lblMessage.Text =
                    "Course Name is required.";

                return;
            }

            if (string.IsNullOrWhiteSpace(trainerName))
            {
                lblMessage.Text =
                    "Trainer Name is required.";

                return;
            }

            if (string.IsNullOrWhiteSpace(durationText))
            {
                lblMessage.Text =
                    "Duration is required.";

                return;
            }

            if (string.IsNullOrWhiteSpace(feesText))
            {
                lblMessage.Text =
                    "Course Fees is required.";

                return;
            }

            // Validate duration
            int duration;

            if (!int.TryParse(durationText, out duration))
            {
                lblMessage.Text =
                    "Please enter a valid duration.";

                return;
            }

            if (duration <= 0)
            {
                lblMessage.Text =
                    "Duration must be greater than zero.";

                return;
            }

            // Validate fees
            decimal fees;

            if (!decimal.TryParse(feesText, out fees))
            {
                lblMessage.Text =
                    "Please enter a valid fee amount.";

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
                        UPDATE Courses
                        SET
                            CourseName = @CourseName,
                            TrainerName = @TrainerName,
                            Duration = @Duration,
                            Fees = @Fees,
                            UpdatedBy = @UpdatedBy,
                            UpdatedDate = GETDATE()
                        WHERE CourseId = @CourseId";

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
                            "@UpdatedBy",
                            Convert.ToInt32(
                                Session["UserId"]));

                        cmd.Parameters.AddWithValue(
                            "@CourseId",
                            courseId);

                        int result =
                            cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Course updated successfully.";

                            gvCourses.EditIndex = -1;

                            LoadCourses();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Unable to update course.";
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Something went wrong while updating the course.";
            }
        }

        protected void gvCourses_RowDeleting(
            object sender,
            System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int courseId =
                Convert.ToInt32(
                    gvCourses.DataKeys[e.RowIndex].Value);

            try
            {
                using (SqlConnection con =
                       DbConnection.GetConnection())
                {
                    con.Open();

                    string query = @"
                        DELETE FROM Courses
                        WHERE CourseId = @CourseId";

                    using (SqlCommand cmd =
                           new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CourseId",
                            courseId);

                        int result =
                            cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblMessage.Text =
                                "Course deleted successfully.";

                            LoadCourses();
                        }
                        else
                        {
                            lblMessage.Text =
                                "Unable to delete course.";
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Something went wrong while deleting the course.";
            }
        }
    }
}
  