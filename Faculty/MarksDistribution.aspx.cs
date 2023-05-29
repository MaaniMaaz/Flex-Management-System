using db_projecta.Models;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace db_projecta.Faculty
{
    public partial class MarksDistribution : System.Web.UI.Page
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

            // Retrieve the courses assigned to the faculty member
            DataTable courseData = GetFacultyCourses(username);

            // Bind the course data to the GridView
            gvCourses.DataSource = courseData;
            gvCourses.DataBind();

            // Populate the course code dropdown for marks distribution
            ddlCourseCodes.DataSource = courseData;
            ddlCourseCodes.DataTextField = "course_code";
            ddlCourseCodes.DataValueField = "course_code";
            ddlCourseCodes.DataBind();

            // Populate the course code dropdown for weightage display
            ddlWeightageCourseCodes.DataSource = courseData;
            ddlWeightageCourseCodes.DataTextField = "course_code";
            ddlWeightageCourseCodes.DataValueField = "course_code";
            ddlWeightageCourseCodes.DataBind();
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


        protected void btnInsertMarksDistribution_Click(object sender, EventArgs e)
        {
            // Get the selected course code and marks distribution values
            string courseCode = ddlCourseCodes.SelectedValue;
            int assignmentWeight = Convert.ToInt32(txtAssignmentWeight.Text);
            int quizWeight = Convert.ToInt32(txtQuizWeight.Text);
            int sessionalWeight = Convert.ToInt32(txtSessionalWeight.Text);
            int finalWeight = Convert.ToInt32(txtFinalWeight.Text);

            // Insert the marks distribution into the database
            InsertMarksDistribution(courseCode, assignmentWeight, quizWeight, sessionalWeight, finalWeight);

            // Refresh the GridView
            BindCourses();
        }

        private void InsertMarksDistribution(string courseCode, int assignmentWeight, int quizWeight, int sessionalWeight, int finalWeight)

        {
            int totalWeight = assignmentWeight + quizWeight + sessionalWeight + finalWeight;

            if (totalWeight != 100)
            {
                // Display an error message indicating that the total weightage should be 100
                lblErrorMessage.Text = "Total weightage should be 100.";
                return;
            }

            CommonFunc.Commonfnx commonFunc = new CommonFunc.Commonfnx();

            // Retrieve the last inserted md_id from the Marks_Distribution table
            int lastMdId = GetLastMdId() + 1;

            // Modify the query based on your table and column names
            string query = $"INSERT INTO Marks_Distribution (md_id, course_code, assignment_weight, quiz_weight, sessional_weight, final_weight) " +
                           $"VALUES ({lastMdId}, '{courseCode}', {assignmentWeight}, {quizWeight}, {sessionalWeight}, {finalWeight})";

            commonFunc.Query(query);

            if (lastMdId > 0)
            {
                // Insert successful
                lblInsertMessage.Text = "Marks distribution inserted successfully.";
                lblInsertMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                // Insert failed
                lblInsertMessage.Text = "Failed to insert marks distribution.";
                lblInsertMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private int GetLastMdId()
        {
            CommonFunc.Commonfnx commonFunc = new CommonFunc.Commonfnx();

            // Modify the query based on your table and column names
            string query = "SELECT TOP 1 md_id FROM Marks_Distribution ORDER BY md_id DESC";

            DataTable result = commonFunc.Fetch(query);

            if (result.Rows.Count > 0)
            {
                // Retrieve the last inserted md_id
                int lastMdId = Convert.ToInt32(result.Rows[0]["md_id"]);
                return lastMdId;
            }

            // If no rows found, return a default starting value
            return 0;
        }


        protected void btnDisplayWeightage_Click(object sender, EventArgs e)
        {
            // Get the selected course code
            string courseCode = ddlWeightageCourseCodes.SelectedValue;

            // Retrieve the weightage for the selected course code
            DataTable weightageData = GetCourseWeightage(courseCode);

            // Bind the weightage data to the GridView
            gvWeightage.DataSource = weightageData;
            gvWeightage.DataBind();
        }

        private DataTable GetCourseWeightage(string courseCode)
        {
            CommonFunc.Commonfnx commonFunc = new CommonFunc.Commonfnx();

            // Modify the query based on your table and column names
            string query = $"SELECT course_code, assignment_weight, quiz_weight, sessional_weight, final_weight " +
                           $"FROM Marks_Distribution " +
                           $"WHERE course_code = '{courseCode}'";

            DataTable weightageData = commonFunc.Fetch(query);
            return weightageData;
        }
    }
}
