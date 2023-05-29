using db_projecta.Models;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace db_projecta.academic_office
{
    public partial class CourseAllocation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var com = new CommonFunc.Commonfnx();
                // Populate the dropdown list with instructors
                DataTable instructors = com.Fetch("SELECT user_id, username FROM Users WHERE role = 'faculty'");
                ddlInstructors.DataSource = instructors;
                ddlInstructors.DataTextField = "username";
                ddlInstructors.DataValueField = "user_id";
                ddlInstructors.DataBind();

                // Populate the dropdown list with course codes
                DataTable courseCodes = com.Fetch("SELECT course_code FROM Courses");
                ddlCourseCode.DataSource = courseCodes;
                ddlCourseCode.DataTextField = "course_code";
                ddlCourseCode.DataValueField = "course_code";
                ddlCourseCode.DataBind();
            }
        }

        protected void btnAllocate_Click(object sender, EventArgs e)
        {
            var c = new CommonFunc.Commonfnx();
            int instructorId = Convert.ToInt32(ddlInstructors.SelectedValue);
            string courseCode = txtCourse.Text;
            string section = txtSection.Text;

            // Retrieve the maximum section_id value from the Sections table
            string maxSectionIdQuery = "SELECT ISNULL(MAX(section_id), 0) AS MaxSectionId FROM Sections";
            DataTable maxSectionIdResult = c.Fetch(maxSectionIdQuery);
            int maxSectionId = Convert.ToInt32(maxSectionIdResult.Rows[0]["MaxSectionId"]);

            // Generate a new unique section_id value
            int newSectionId = maxSectionId + 1;

            // Insert the allocation into the Course_Instructors table
            string query = $"INSERT INTO Course_Instructors (ci_id, course_code, instructor_id) VALUES ((SELECT ISNULL(MAX(ci_id), 0) + 1 FROM Course_Instructors), '{courseCode}', {instructorId})";
            c.Query(query);

            // Insert the section into the Sections table with the new section_id value
            query = $"INSERT INTO Sections (section_id, course_code, section_number, instructor_id, section_capacity) VALUES ({newSectionId}, '{courseCode}', '{section}', {instructorId}, 0)";
            c.Query(query);

            // Display success message
            lblMessage.Text = "Course allocation successful!";
            lblMessage.Visible = true;

            // Redirect to a success page or display a success message
            // Response.Redirect("AllocationSuccess.aspx");
        }

        protected void ddlCourseCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            var comm = new CommonFunc.Commonfnx();
            string courseCode = ddlCourseCode.SelectedValue;

            // Fetch course details
            DataTable courseDetails = comm.Fetch($"SELECT course_title, credit_hours FROM Courses WHERE course_code = '{courseCode}'");

            if (courseDetails.Rows.Count > 0)
            {
                lblCourseName.Text = courseDetails.Rows[0]["course_title"].ToString();
                lblCreditHours.Text = courseDetails.Rows[0]["credit_hours"].ToString();
            }

            // Fetch section details
            DataTable sectionDetails = comm.Fetch($"SELECT S.section_number, U.username, C.course_code, C.course_title, C.credit_hours " +
                $"FROM Sections S " +
                $"INNER JOIN Users U ON S.instructor_id = U.user_id " +
                $"INNER JOIN Courses C ON S.course_code = C.course_code " +
                $"WHERE S.course_code = '{courseCode}'");

            gvSections.DataSource = sectionDetails;
            gvSections.DataBind();


        }
    }

}