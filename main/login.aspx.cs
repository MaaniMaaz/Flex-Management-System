using System;
using System.Data;
using db_projecta.Models;
using static db_projecta.Models.CommonFunc;

namespace db_projecta.main
{
    public partial class login : System.Web.UI.Page
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
            string query = $"SELECT * FROM Users WHERE Username='{username.Text}' AND Password='{password.Text}' AND Role='Admin'";
            DataTable dt = commonFunc.Fetch(query);

            if (dt.Rows.Count > 0)
            {
                Session["Username"] = username.Text;
                Response.Redirect("/academic office/acadmicofficerHome.aspx"); // Redirect to your admin page
            }
            else
            {
                // Show error message
                // This should be a label on your login page to show error messages
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = "Username, password, or role is incorrect!";

            }
        }
    }
}
