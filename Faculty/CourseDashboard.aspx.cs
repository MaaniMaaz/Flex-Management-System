using db_projecta.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace db_projecta.Faculty
{
    public partial class CourseDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCourses();
            }
        }

        private void BindCourses()
        {
            // Get the username from the session
            string username = Session["Username"] as string;

            // Retrieve the courses and sections assigned to the faculty member
            DataTable courseData = GetFacultyCourses(username);

            // Bind the course data to the GridView
            gvCourses.DataSource = courseData;
            gvCourses.DataBind();
        }

        private DataTable GetFacultyCourses(string username)
        {
            CommonFunc.Commonfnx commonFunc = new CommonFunc.Commonfnx();

            // Modify the query based on your table and column names
            string query = $"SELECT C.course_code, C.course_title, S.section_number " +
                           $"FROM Courses C " +
                           $"INNER JOIN Course_Instructors CI ON C.course_code = CI.course_code " +
                           $"INNER JOIN Sections S ON CI.course_code = S.course_code " +
                           $"INNER JOIN Users U ON CI.instructor_id = U.user_id " +
                           $"WHERE U.username = '{username}'";

            DataTable courseData = commonFunc.Fetch(query);
            return courseData;
        }
    }
}
