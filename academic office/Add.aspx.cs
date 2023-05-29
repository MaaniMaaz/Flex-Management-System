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
    public partial class Add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize the form
                ClearForm();
            }
        }

        protected void ddlUserRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Hide both student and faculty sections initially
            studentDetails.Visible = false;
            facultyDetails.Visible = false;

            // Show the selected section based on the user role
            string selectedRole = ddlUserRole.SelectedValue;
            if (selectedRole == "Student")
            {
                studentDetails.Visible = true;
            }
            else if (selectedRole == "Faculty")
            {
                facultyDetails.Visible = true;
            }
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            string selectedRole = ddlUserRole.SelectedValue;
            if (selectedRole == "Student")
            {
                AddStudent();
            }
            else if (selectedRole == "Faculty")
            {
                AddFaculty();
            }

            // Clear the form after adding the user
            ClearForm();

            // Display the success message
            lblSuccessMessage.Text = "User added successfully!";
            lblSuccessMessage.Visible = true;
        }

        protected void AddStudent()
        {
            // Retrieve the student details from the form
            string studentName = txtStudentName.Text;
            string registrationNumber = txtRegistrationNumber.Text;
            int batchYear = Convert.ToInt32(txtBatchYear.Text);

            // Generate the student_id
            int studentId = GenerateStudentId();

            // Insert the student details into the database
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = $"INSERT INTO Students (student_id, student_name, registration_number, batch_year) VALUES ({studentId}, '{studentName}', '{registrationNumber}', {batchYear})";
            commonfnx.Query(query);
        }

        protected int GenerateStudentId()
        {
            // Retrieve the maximum student_id from the Students table
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = "SELECT MAX(student_id) AS MaxId FROM Students";
            DataTable dt = commonfnx.Fetch(query);

            int lastUsedId = 0;
            if (dt.Rows.Count > 0 && dt.Rows[0]["MaxId"] != DBNull.Value)
            {
                lastUsedId = Convert.ToInt32(dt.Rows[0]["MaxId"]);
            }

            int newStudentId = lastUsedId + 1;

            return newStudentId;
        }



        protected void AddFaculty()
        {
            // Retrieve the faculty details from the form
            string facultyName = txtFacultyName.Text;
            string facultyId = txtFacultyId.Text;

            // Generate the user_id
            int userId = GenerateUserId();

            // Insert the faculty details into the database
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = $"INSERT INTO Users (user_id, username, password, role) VALUES ({userId}, '{facultyName}', '{facultyId}', 'faculty')";
            commonfnx.Query(query);
        }

        protected int GenerateUserId()
        {
            // Retrieve the maximum user_id from the Users table
            CommonFunc.Commonfnx commonfnx = new CommonFunc.Commonfnx();
            string query = "SELECT MAX(user_id) AS MaxId FROM Users";
            DataTable dt = commonfnx.Fetch(query);

            int lastUsedId = 0;
            if (dt.Rows.Count > 0 && dt.Rows[0]["MaxId"] != DBNull.Value)
            {
                lastUsedId = Convert.ToInt32(dt.Rows[0]["MaxId"]);
            }

            int newUserId = lastUsedId + 1;

            return newUserId;
        }



        protected void ClearForm()
        {
            ddlUserRole.SelectedIndex = 0;
            studentDetails.Visible = false;
            facultyDetails.Visible = false;
            txtStudentName.Text = string.Empty;
            txtRegistrationNumber.Text = string.Empty;
            txtBatchYear.Text = string.Empty;
            txtFacultyName.Text = string.Empty;
            txtFacultyId.Text = string.Empty;
            lblSuccessMessage.Visible = false;
        }
    }
}