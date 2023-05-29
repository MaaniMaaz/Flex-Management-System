using System;
using System.Data;
using db_projecta.Models;

namespace db_projecta.academic_office
{
    public partial class Attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGetCourses_Click(object sender, EventArgs e)
        {
            string rollNumber = txtRollNumber.Text.Trim();

            // Retrieve the sections registered by the student
            DataTable sections = GetStudentSections(rollNumber);

            // Bind the sections to the dropdown list
            ddlSections.DataSource = sections;
            ddlSections.DataTextField = "section_number";
            ddlSections.DataValueField = "section_id";
            ddlSections.DataBind();

            // Show the dropdown list and submit button
            ddlSections.Visible = true;
            btnSubmit.Visible = true;

            // Hide the attendance gridview
            gvAttendance.Visible = false;
        }

        protected DataTable GetStudentSections(string rollNumber)
        {
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = $"SELECT SS.section_id, SS.section_number, C.course_code " +
                           $"FROM Students S " +
                           $"INNER JOIN Student_Enrollment SE ON S.student_id = SE.student_id " +
                           $"INNER JOIN Sections SS ON SE.section_id = SS.section_id " +
                           $"INNER JOIN Courses C ON SS.course_code = C.course_code " +
                           $"WHERE S.registration_number = '{rollNumber}'";

            DataTable dt = commonfnx.Fetch(query);
            return dt;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sectionId = ddlSections.SelectedValue;

            // Retrieve the attendance for the selected section
            DataTable attendance = GetSectionAttendance(sectionId);

            // Bind the attendance data to the GridView
            gvAttendance.DataSource = attendance;
            gvAttendance.DataBind();

            // Show the attendance GridView
            gvAttendance.Visible = true;
        }

        protected DataTable GetSectionAttendance(string sectionId)
        {
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = $"SELECT ROW_NUMBER() OVER (ORDER BY date) AS RowNumber, " +
                           $"date AS Date, " +
                           $"status AS Status, " +
                           $"C.course_code AS CourseCode " +
                           $"FROM Attendance A " +
                           $"INNER JOIN Sections SS ON A.section_id = SS.section_id " +
                           $"INNER JOIN Courses C ON SS.course_code = C.course_code " +
                           $"WHERE SS.section_id = {sectionId}";

            DataTable dt = commonfnx.Fetch(query);
            return dt;
        }
    }
}
