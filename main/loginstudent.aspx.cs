using db_projecta.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace db_projecta.main
{
    public partial class loginstudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                username.Focus();
            }
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            var commonFunc = new CommonFunc.Commonfnx();
            string query = $"SELECT * FROM Users WHERE Username='{username.Text}' AND Password='{password.Text}' AND (Role='student')";
            DataTable dt = commonFunc.Fetch(query);

            if (dt.Rows.Count > 0)
            {
                string loggedInUsername = dt.Rows[0]["Username"].ToString();
                Session["Username"] = loggedInUsername;
                Response.Redirect("~/Faculty/Facultymain.aspx");
            }
            else
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = "Username or password incorrect!";
            }
        }
    }
}