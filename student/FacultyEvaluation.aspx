<!DOCTYPE html>
<html>
<head>
	<title>Faculty Interface</title>
	<style>
		body {
			font-family: Arial, sans-serif;
			margin: 0;
			padding: 0;
		}
		h1 {
			text-align: center;
			margin-top: 20px;
		}
		form {
			max-width: 800px;
			margin: 20px auto;
			padding: 20px;
			border: 1px solid #ccc;
			border-radius: 5px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		label {
			display: block;
			margin-bottom: 5px;
			font-weight: bold;
		}
		input[type="text"], select {
			display: block;
			width: 100%;
			padding: 10px;
			border: 1px solid #ccc;
			border-radius: 5px;
			margin-bottom: 10px;
			box-sizing: border-box;
		}
		table {
			width: 100%;
			border-collapse: collapse;
			margin-bottom: 20px;
		}
		th, td {
			padding: 10px;
			border: 1px solid #ccc;
			text-align: center;
			font-size: 14px;
		}
		th {
			background-color: #eee;
			font-weight: bold;
		}
		button {
			display: block;
			padding: 10px;
			background-color: #2082e4;
			color: #fff;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			margin-top: 10px;
			float: right;
		}
		button:hover {
			background-color: #0066cc;
		}
	</style>
</head>
<body>
	<h1>Faculty Interface</h1>
	<form>
		<label for="campus">Campus Name:</label>
		<input type="text" id="campus" name="campus" value="Islamabad" readonly>

		<label for="semester">Semester Name:</label>
		<input type="text" id="semester" name="semester" value="Spring 2023" readonly>

		<label for="course">Registered Courses:</label>
		<select id="course" name="course" onchange="updateSection()">
			<option value="">Select Course</option>
			<option value="CS101">CS101 - Introduction to Computer Science</option>
			<option value="CS201">CS201 - Data Structures and Algorithms</option>
			<option value="CS301">CS301 - Operating Systems</option>
		</select>

		<label for="section">Section:</label>
		<select id="section" name="section">
			<option value="">Select Section</option>
		</select>

		<h2>Evaluation Table:</h2>
		<table id="evaluation-table">
			<thead>
				<tr>
					<th>Student ID</th>
					<th>Assignments</th>
					<th>Quizzes</th>
					<th>Mid 1</th>
					<th>Mid 2</th>
					<th>Project</th>
					<th>Final</th>
				</tr>
			</thead>
        </table>
        <script>
        // Demo data for the evaluation table
const evaluationData = [
	{ id: "2021-CS-101", assignments: 90, quizzes: 80, mid1: 70, mid2: 75, project: 85, final: 80 },
	{ id: "2021-CS-102", assignments: 85, quizzes: 75, mid1: 80, mid2: 70, project: 90, final: 85 },
	{ id: "2021-CS-103", assignments: 80, quizzes: 85, mid1: 75, mid2: 80, project: 80, final: 90 },
	{ id: "2021-CS-104", assignments: 75, quizzes: 90, mid1: 85, mid2: 85, project: 70, final: 75 },
];

// Function to update the section dropdown based on the selected course
function updateSection() {
	const courseDropdown = document.getElementById("course");
	const sectionDropdown = document.getElementById("section");
	const selectedCourse = courseDropdown.value;

	// Clear the section dropdown
	sectionDropdown.innerHTML = '<option value="">Select Section</option>';

	if (selectedCourse === "") {
		return;
	}

	// Add options to the section dropdown based on the selected course
	if (selectedCourse === "CS101") {
		sectionDropdown.innerHTML += '<option value="A">A</option>';
		sectionDropdown.innerHTML += '<option value="B">B</option>';
	} else if (selectedCourse === "CS201") {
		sectionDropdown.innerHTML += '<option value="C">C</option>';
		sectionDropdown.innerHTML += '<option value="D">D</option>';
	} else if (selectedCourse === "CS301") {
		sectionDropdown.innerHTML += '<option value="E">E</option>';
		sectionDropdown.innerHTML += '<option value="F">F</option>';
	}
}

// Function to update the evaluation table based on the selected section
function updateEvaluationTable() {
	const sectionDropdown = document.getElementById("section");
	const selectedSection = sectionDropdown.value;
	const evaluationTable = document.getElementById("evaluation-table");

	// Clear the evaluation table
	evaluationTable.innerHTML = `
		<thead>
			<tr>
				<th>Student ID</th>
				<th>Assignments</th>
				<th>Quizzes</th>
				<th>Mid 1</th>
				<th>Mid 2</th>
				<th>Project</th>
				<th>Final</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	`;

	if (selectedSection === "") {
		return;
	}

	// Add data to the evaluation table based on the selected section
	for (const data of evaluationData) {
		if (data.id.startsWith(selectedSection)) {
			const row = evaluationTable.insertRow();
			row.insertCell().textContent = data.id;
			row.insertCell().textContent = data.assignments;
			row.insertCell().textContent = data.quizzes;
			row.insertCell().textContent = data.mid1;
			row.insertCell().textContent = data.mid2;
			row.insertCell().textContent = data.project;
			row.insertCell().textContent = data.final;
		}
	}
}

// Attach event listeners to the course and section dropdowns
const courseDropdown = document.getElementById("course");
const sectionDropdown = document.getElementById("section");
courseDropdown.addEventListener("change", updateSection);
sectionDropdown.addEventListener("change", updateEvaluationTable);
</script>
