using System;
using System.Data;
using db_projecta.Models;
using System.Web.UI.WebControls;

namespace db_projecta.Faculty
{
    public partial class AttendanceManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the username from the session
                string username = Session["username"] as string;

                // Populate the course code dropdown list
                BindCourseCodes(username);
            }
        }

        protected void ddlCourseCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the username from the session
            string username = Session["username"] as string;

            // Populate the sections dropdown list based on the selected course code and username
            string courseCode = ddlCourseCode.SelectedValue;
            BindSections(courseCode, username);
        }

        protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the username from the session
            string username = Session["username"] as string;

            // Populate the gridview with students registered in the selected course code, section, and username
            string courseCode = ddlCourseCode.SelectedValue;
            string sectionNumber = ddlSection.SelectedValue;
            BindStudents(courseCode, sectionNumber, username);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Get the username from the session
            string username = Session["username"] as string;

            // Insert attendance records into the database
            string courseCode = ddlCourseCode.SelectedValue;
            string sectionNumber = ddlSection.SelectedValue;

            DateTime date;
            if (DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", null, System.Globalization.DateTimeStyles.None, out date))
            {
                InsertAttendance(courseCode, sectionNumber, date, username);

                // Display a success message
                lblSuccessMessage.Text = "Attendance marked successfully.";

                // Clear the form
                ClearForm();
            }
            else
            {
                // Display an error message for invalid date format
                lblErrorMessage.Text = "Invalid date format";
            }
        }

        protected void btnShowAttendance_Click(object sender, EventArgs e)
        {
            // Get the username from the session
            string username = Session["username"] as string;

            // Retrieve attendance records for the given roll number, course code, and section
            string rollNumber = txtRollNumber.Text;
            string courseCode = ddlCourseCode.SelectedValue;
            string sectionNumber = ddlSection.SelectedValue;

            DataTable dt = GetAttendance(rollNumber, courseCode, sectionNumber, username);

            // Bind the attendance records to the gridview
            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();
        }

        private void BindCourseCodes(string username)
        {
            var con = new CommonFunc.Commonfnx();

            // Fetch the distinct course codes for the given username
            string query = $"SELECT DISTINCT C.course_code " +
                           $"FROM Courses C " +
                           $"INNER JOIN Course_Instructors CI ON C.course_code = CI.course_code " +
                           $"INNER JOIN Users U ON CI.instructor_id = U.user_id " +
                           $"WHERE U.username = '{username}'";

            DataTable dt = con.Fetch(query);

            // Bind the course codes to the dropdown list
            ddlCourseCode.DataSource = dt;
            ddlCourseCode.DataTextField = "course_code";
            ddlCourseCode.DataValueField = "course_code";
            ddlCourseCode.DataBind();

            // Set the initial option as selected
            ddlCourseCode.Items.Insert(0, new ListItem("-- Select Course Code --", ""));
        }

        private void BindSections(string courseCode, string username)
        {
            var cn = new CommonFunc.Commonfnx();

            // Fetch the sections for the selected course code and username
            string query = $"SELECT SC.section_number " +
                           $"FROM Sections SC " +
                           $"INNER JOIN Course_Instructors CI ON SC.course_code = CI.course_code " +
                           $"INNER JOIN Users U ON CI.instructor_id = U.user_id " +
                           $"WHERE SC.course_code = '{courseCode}' AND U.username = '{username}'";

            DataTable dt = cn.Fetch(query);

            // Bind the sections to the dropdown list
            ddlSection.DataSource = dt;
            ddlSection.DataTextField = "section_number";
            ddlSection.DataValueField = "section_number";
            ddlSection.DataBind();

            // Set the initial option as selected
            ddlSection.Items.Insert(0, new ListItem("-- Select Section --", ""));
        }

        private void BindStudents(string courseCode, string sectionNumber, string username)
        {
            var c = new CommonFunc.Commonfnx();

            // Fetch the students registered in the selected course code, section, and username
            string query = $"SELECT S.student_id, S.student_name, S.registration_number " +
                           $"FROM Students S " +
                           $"INNER JOIN Student_Enrollment SE ON S.student_id = SE.student_id " +
                           $"INNER JOIN Sections SC ON SE.section_id = SC.section_id " +
                           $"INNER JOIN Course_Instructors CI ON SC.course_code = CI.course_code " +
                           $"INNER JOIN Users U ON CI.instructor_id = U.user_id " +
                           $"WHERE SC.course_code = '{courseCode}' AND SC.section_number = '{sectionNumber}' AND U.username = '{username}'";

            DataTable dt = c.Fetch(query);

            // Bind the students to the gridview
            gvStudents.DataSource = dt;
            gvStudents.DataBind();
        }

        private void InsertAttendance(string courseCode, string sectionNumber, DateTime date, string username)
        {
            var conn = new CommonFunc.Commonfnx();

            foreach (GridViewRow row in gvStudents.Rows)
            {
                int studentId = Convert.ToInt32(row.Cells[1].Text);
                string status = ((DropDownList)row.Cells[3].FindControl("ddlStatus")).SelectedValue;

                // Insert attendance record
                string query = $"INSERT INTO Attendance (attendance_id, section_id, student_id, date, status) " +
                               $"VALUES ((SELECT ISNULL(MAX(attendance_id), 0) FROM Attendance) + 1, " +
                               $"(SELECT section_id FROM Sections WHERE course_code = '{courseCode}' AND section_number = '{sectionNumber}'), " +
                               $"{studentId}, '{date.ToString("yyyy-MM-dd")}', '{status}')";
                conn.Query(query);
            }
        }

        private DataTable GetAttendance(string rollNumber, string courseCode, string sectionNumber, string username)
        {
            var conn = new CommonFunc.Commonfnx();

            // Retrieve attendance records for the given roll number, course code, section, and username
            string query = $"SELECT A.date, A.status " +
                           $"FROM Attendance A " +
                           $"INNER JOIN Students S ON A.student_id = S.student_id " +
                           $"INNER JOIN Sections SC ON A.section_id = SC.section_id " +
                           $"INNER JOIN Course_Instructors CI ON SC.course_code = CI.course_code " +
                           $"INNER JOIN Users U ON CI.instructor_id = U.user_id " +
                           $"WHERE S.registration_number = '{rollNumber}' AND SC.course_code = '{courseCode}' AND SC.section_number = '{sectionNumber}' AND U.username = '{username}'";

            DataTable dt = conn.Fetch(query);

            return dt;

        }
        private void ClearForm()
        {
            ddlCourseCode.SelectedIndex = 0;
            ddlSection.Items.Clear();
            gvStudents.DataSource = null;
            gvStudents.DataBind();
            txtDate.Text = string.Empty;
        }
    }
}

