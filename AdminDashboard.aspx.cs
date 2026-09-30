using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace course_management_system.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //user must be logged in
            if (Session["UserId"]==null)
            {
                Response.Redirect("../SignIn.aspx");
                return;
            }
            //only admin can access this page
            if (Session["Role"]==null || Session["Role"].ToString()!="Admin")
            {
                Response.Redirect("../SignIn.aspx");
                return;
            }
            if(!IsPostBack)
            {
                if (Session["Firstname"]!=null)
                {
                    lblAdminName.Text = Session["Firstname"].ToString();
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../SignIn.aspx");
        }
    }
}