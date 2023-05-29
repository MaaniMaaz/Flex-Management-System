<!DOCTYPE html>
<html>
<head>
	<title>Student Information</title>
	<style>
		form {
			margin: 50px auto;
			width: 400px;
			padding: 20px;
			border: 1px solid #ccc;
			border-radius: 5px;
			background-color: #f4f4f4;
			font-family: Arial, sans-serif;
		}

		label {
			display: block;
			margin-bottom: 10px;
			font-weight: bold;
			color: #333;
		}

		input[type=text], select {
			display: block;
			width: 100%;
			padding: 10px;
			border: 1px solid #ccc;
			border-radius: 3px;
			box-sizing: border-box;
			font-size: 16px;
			margin-bottom: 20px;
		}

		input[type=submit] {
			background-color: #0066cc;
			color: #fff;
			padding: 10px 20px;
			border: none;
			border-radius: 3px;
			font-size: 16px;
			cursor: pointer;
		}

		input[type=submit]:hover {
			background-color: #0066cc;
		}

		.result {
			margin-top: 50px;
			font-size: 18px;
			color: #333;
		}
	</style>
</head>
<body>
	<form>
		<label for="role">Role:</label>
		<select id="role" name="role">
			<option value="student">Student</option>
			<option value="teacher">Teacher</option>
			<option value="instructor">Instructor</option>
		</select>

		<div id="studentFields">
			<label for="studentName">Name:</label>
			<input type="text" id="studentName" name="studentName">

			<label for="department">Department:</label>
			<select id="department" name="department">
				<option value="CS">CS</option>
				<option value="SE">SE</option>
				<option value="AI">AI</option>
			</select>

			<label for="section">Section:</label>
			<select id="section" name="section">
				<option value="A">A</option>
				<option value="B">B</option>
				<option value="C">C</option>
			</select>

			<label for="roll">Roll Number:</label>
			<input type="text" id="roll" name="roll" required>
		</div>

		<div id="teacherFields" style="display: none;">
			<label for="teacherName">Name:</label>
			<input type="text" id="teacherName" name="teacherName">

			<label for="teacherRegistration">Registration Number:</label>
			<input type="text" id="teacherRegistration" name="teacherRegistration">

			<label for="teacherDepartment">Department:</label>
			<input type="text" id="teacherDepartment" name="teacherDepartment">
		</div>

		<div id="instructorFields" style="display: none;">
			<label for="instructorName">Name:</label>
			<input type="text" id="instructorName" name="instructorName">

			<label for="instructorRegistration">Registration Number:</label>
			<input type="text" id="instructorRegistration" name="instructorRegistration">

			<label for="instructorDepartment">Department:</label>
			<input type="text" id="instructorDepartment" name="instructorDepartment">
		</div>

		<input type="submit" value="Add">

		<div class="result"></div>
	</form>

	<script>
		const form = document.querySelector('form');
		const result = document.querySelector('.result');

		const roleDropdown = form.querySelector('#role');
		const studentFields = form.querySelector('#studentFields');
		const teacherFields = form.querySelector('#teacherFields');
		const instructorFields = form.querySelector('#instructorFields');

		roleDropdown.addEventListener('change', () => {
			const selectedRole = roleDropdown.value;

			studentFields.style.display = 'none';
			teacherFields.style.display = 'none';
			instructorFields.style.display = 'none';

			if (selectedRole === 'student') {
				studentFields.style.display = 'block';
			} else if (selectedRole === 'teacher') {
				teacherFields.style.display = 'block';
			} else if (selectedRole === 'instructor') {
				instructorFields.style.display = 'block';
			}
		});

		form.addEventListener('submit', e => {
    e.preventDefault();

    // Get the role
    const role = roleDropdown.value;

    // Get the form data based on the role
    let formData = '';
    if (role === 'student') {
        const studentName = form.querySelector('#studentName').value;
        const department = form.querySelector('#department').value;
        const section = form.querySelector('#section').value;
        const roll = form.querySelector('#roll').value;
        formData = `Name: ${studentName}<br>Department: ${department}<br>Section: ${section}<br>Roll Number: ${roll}`;
    } else if (role === 'teacher') {
        const teacherName = form.querySelector('#teacherName').value;
        const teacherRegistration = form.querySelector('#teacherRegistration').value;
        const teacherDepartment = form.querySelector('#teacherDepartment').value;
        formData = `Name: ${teacherName}<br>Registration Number: ${teacherRegistration}<br>Department: ${teacherDepartment}`;
    } else if (role === 'instructor') {
        const instructorName = form.querySelector('#instructorName').value;
        const instructorRegistration = form.querySelector('#instructorRegistration').value;
        const instructorDepartment = form.querySelector('#instructorDepartment').value;
        formData = `Name: ${instructorName}<br>Registration Number: ${instructorRegistration}<br>Department: ${instructorDepartment}`;
    }

    result.innerHTML = formData;
});
	</script>
</body>
</html>