using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace db_projecta.Faculty
{
    public partial class Evaluations_Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the course code dropdown list
                BindCourseCodes();
            }
        }

        protected void ddlCourseCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Populate the sections dropdown list based on the selected course code
            string courseCode = ddlCourseCode.SelectedValue;
            BindSections(courseCode);
        }

        protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Populate the gridview with students registered in the selected course code and section
            string courseCode = ddlCourseCode.SelectedValue;
            string sectionNumber = ddlSection.SelectedValue;
            BindStudents(courseCode, sectionNumber);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Process the evaluation marks
            ProcessEvaluationMarks();

            // Display a success message
            lblSuccessMessage.Text = "Evaluation marks saved successfully.";

            // Clear the form
            ClearForm();
        }

        private void BindCourseCodes()
        {
            // Hard-coded course codes
            List<string> courseCodes = new List<string> { "CS101", "ENG102", "MTH301" };

            // Bind the course codes to the dropdown list
            ddlCourseCode.DataSource = courseCodes;
            ddlCourseCode.DataBind();

            // Set the initial option as selected
            ddlCourseCode.Items.Insert(0, new ListItem("-- Select Course Code --", ""));
        }

        private void BindSections(string courseCode)
        {
            // Hard-coded section numbers for the selected course code
            List<string> sectionNumbers = new List<string> { "A", "D", "M" };

            // Bind the sections to the dropdown list
            ddlSection.DataSource = sectionNumbers;
            ddlSection.DataBind();

            // Set the initial option as selected
            ddlSection.Items.Insert(0, new ListItem("-- Select Section --", ""));
        }

        private void BindStudents(string courseCode, string sectionNumber)
        {
            // Hard-coded student data for the selected course code and section
            DataTable dt = new DataTable();
            dt.Columns.Add("student_id", typeof(int));
            dt.Columns.Add("student_name", typeof(string));
            dt.Columns.Add("registration_number", typeof(string));

            dt.Rows.Add(1, "John Doe", "FA16-BCS-001");
            dt.Rows.Add(2, "Jane Smith", "FA18-BCS-007");
            dt.Rows.Add(3, "Hamza", "21I-0815");

            // Bind the students to the gridview
            gvStudents.DataSource = dt;
            gvStudents.DataBind();
        }

        protected void ProcessEvaluationMarks()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("student_id", typeof(int));
            dt.Columns.Add("evaluation_marks", typeof(int));

            foreach (GridViewRow row in gvStudents.Rows)
            {
                int studentId = Convert.ToInt32(row.Cells[0].Text);
                int evaluationMarks = Convert.ToInt32(((TextBox)row.Cells[3].FindControl("txtScore")).Text);

                // Create a new row with evaluation details
                DataRow newRow = dt.NewRow();
                newRow["student_id"] = studentId;
                newRow["evaluation_marks"] = evaluationMarks;

                dt.Rows.Add(newRow);
            }

            // Bind the evaluation details to the gridview
            gvEvaluations.DataSource = dt;
            gvEvaluations.DataBind();
        }



        private void ClearForm()
        {
            ddlCourseCode.SelectedIndex = 0;
            ddlSection.Items.Clear();
            gvStudents.DataSource = null;
            gvStudents.DataBind();
            gvEvaluations.DataSource = null;
            gvEvaluations.DataBind();
        }
    }
}
