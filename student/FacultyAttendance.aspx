<!DOCTYPE html>
<html>
<head>
	<title>Faculty Attendance Interface</title>
	<style>
		body {
			font-family: Arial, sans-serif;
			margin: 0;
			padding: 0;
			background-color: #f2f2f2;
		}

		.container {
			max-width: 800px;
			margin: 20px auto;
			background-color: #fff;
			padding: 20px;
			border-radius: 5px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		}

		h1 {
			text-align: center;
			margin-top: 0;
		}

		form {
			display: flex;
			flex-direction: column;
			align-items: center;
			margin-top: 20px;
		}

		label {
			display: block;
			margin-bottom: 10px;
		}

		input[type="text"], select {
			width: 100%;
			padding: 10px;
			margin-bottom: 20px;
			border: 1px solid #ccc;
			border-radius: 5px;
			box-sizing: border-box;
		}

		table {
			border-collapse: collapse;
			width: 100%;
			margin-bottom: 20px;
		}

		th, td {
			text-align: left;
			padding: 8px;
			border-bottom: 1px solid #ddd;
		}

		th {
			background-color: #f2f2f2;
		}

		button {
			padding: 10px 20px;
			background-color: #0066cc;
			color: #fff;
			border: none;
			border-radius: 5px;
			cursor: pointer;
		}

		button:hover {
			background-color: #0066cc;
		}

	</style>
</head>
<body>
	<div class="container">
		<h1>Faculty Attendance Interface</h1>
		<form>
			<label for="campus">Campus:</label>
			<input type="text" id="campus" name="campus" value = "Islamabad" readonly>

			<label for="semester">Semester:</label>
			<input type="text" id="semester" name="semester" value = "Spring 2023" readonly>

			<label for="course">Select a course and section:</label>
			<select id="course" name="course" onchange="showAttendance()">
				<option value="">Select a course and section</option>
				<option value="cse101a">CSE 101 (Section A)</option>
				<option value="cse101b">CSE 101 (Section B)</option>
				<option value="cse102a">CSE 102 (Section A)</option>
				<option value="cse102b">CSE 102 (Section B)</option>
			</select>

			<table id="attendanceTable" style="display:none">
				<thead>
					<tr>
						<th>Roll Number</th>
						<th>Name</th>
						<th>Present</th>
						<th>Late</th>
						<th>Absent</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>John Doe</td>
						<td><input type="radio" name="1" value="present" checked></td>
						<td><input type="radio" name="1" value="late"></td>
						<td><input type="radio" name="1" value="absent"></td>
					</tr>
					<tr>
						<td>2</td>
						<td>Jane Smith</td>
						<td><input type="radio" name="2" value="present"></td>
						<td><input type="radio" name="2" value="late"></td>
						<td><input type="radio" name="2" value="absent" checked></td>
					</tr>
					<tr>
						<td>3</td>
						<td>Bob Johnson</td>
						<td><input type="radio" name="3" value="present"></td>
						<td><input type="radio" name="3" value="late"></td>
						<td><input type="radio" name="3" value="absent"></td>
					</tr>
				</tbody>
			</table>

			<button type="submit">Submit Attendance</button>
		</form>
	</div>

	<script>
		function showAttendance() {
			var courseSelect = document.getElementById("course");
			var attendanceTable = document.getElementById("attendanceTable");
			if (courseSelect.value !== "") {
				attendanceTable.style.display = "table";
			} else {
				attendanceTable.style.display = "none";
			}
		}
	</script>
</body>
</html>