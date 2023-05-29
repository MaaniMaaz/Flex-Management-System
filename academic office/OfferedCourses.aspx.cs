using db_projecta.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace db_projecta.academic_office
{
    public partial class OfferedCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load initial data or perform setup tasks
            }
        }

        protected void ddlSemester_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedSemester = ddlSemester.SelectedValue;

            // Retrieve course details based on the selected semester
            DataTable courseDetails = GetCourseDetails(selectedSemester);

            // Bind the retrieved data to the GridView control
            gvCourses.DataSource = courseDetails;
            gvCourses.DataBind();
        }

        private DataTable GetCourseDetails(string semester)
        {
            // Retrieve course details from the database based on the selected semester
            var c = new CommonFunc.Commonfnx();
            string query = $"SELECT course_code, course_title, credit_hours FROM Courses WHERE offered_semester = '{semester}'";
            DataTable courseDetails = c.Fetch(query);

            return courseDetails;
        }
    }
}