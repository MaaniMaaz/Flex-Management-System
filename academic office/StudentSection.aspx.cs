using db_projecta.Models;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace db_projecta.academic_office
{
    public partial class StudentSection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCourses();
            }
        }

        protected void BindCourses()
        {
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = "SELECT course_code FROM Courses";
            DataTable dt = commonfnx.Fetch(query);

            ddlCourses.DataSource = dt;
            ddlCourses.DataTextField = "course_code";
            ddlCourses.DataValueField = "course_code";
            ddlCourses.DataBind();
        }

        protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCourses.SelectedValue != "")
            {
                BindSections(ddlCourses.SelectedValue);
                ClearStudents();
            }
            else
            {
                ddlSections.Items.Clear();
                ddlSections.Items.Insert(0, new ListItem("- Select Section -", ""));
                ClearStudents();
            }
        }

        protected void BindSections(string courseCode)
        {
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = "SELECT section_number FROM Sections WHERE course_code = '" + courseCode + "'";
            DataTable dt = commonfnx.Fetch(query);

            ddlSections.DataSource = dt;
            ddlSections.DataTextField = "section_number";
            ddlSections.DataValueField = "section_number";
            ddlSections.DataBind();
        }

        protected void ddlSections_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSections.SelectedValue != "")
            {
                btnSubmit.Visible = true;
                ClearStudents();
            }
            else
            {
                btnSubmit.Visible = false;
                ClearStudents();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddlCourses.SelectedValue != "" && ddlSections.SelectedValue != "")
            {
                BindStudents(ddlCourses.SelectedValue, ddlSections.SelectedValue);
            }
            else
            {
                ClearStudents();
            }
        }

        protected void BindStudents(string courseCode, string sectionNumber)
        {
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = "SELECT ROW_NUMBER() OVER (ORDER BY student_name) AS RowNumber, " +
                           "student_name AS StudentName, " +
                           "registration_number AS RollNumber " +
                           "FROM Students " +
                           "INNER JOIN Student_Enrollment ON Students.student_id = Student_Enrollment.student_id " +
                           "INNER JOIN Sections ON Student_Enrollment.section_id = Sections.section_id " +
                           "WHERE Sections.course_code = '" + courseCode + "' AND Sections.section_number = '" + sectionNumber + "'";

            DataTable dt = new DataTable();

            try
            {
                dt = commonfnx.Fetch(query);
            }
            catch (Exception ex)
            {
                // Handle the exception appropriately, such as displaying an error message
                // or logging the exception details for further investigation
                // Example: lblErrorMessage.Text = "An error occurred while fetching the student data.";
            }

            gvStudents.DataSource = dt;
            gvStudents.DataBind();

            gvStudents.Visible = true;
        }



        protected void ClearStudents()
        {
            gvStudents.DataSource = null;
            gvStudents.DataBind();
            gvStudents.Visible = false;
        }
    }
}
