<!-----Form for Teacher To see the course wise grades and Number of Students got A,B,C or F etc Grade-->
<!DOCTYPE html>
<html>
<head>
	<title>Course Grades</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<div class="container">
		<h1>Course Grades</h1>
		<form>
			<label for="courses">Select a course:</label>
			<select id="courses" name="courses">
				<option value="course1">Course 1</option>
				<option value="course2">Course 2</option>
				<option value="course3">Course 3</option>
			</select>
		</form>
		<table id="grades-table">
			<thead>
				<tr>
					<th>Grade</th>
					<th>No. of Students</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>A+</td>
					<td id="grade-a-plus">0</td>
				</tr>
				<tr>
					<td>A</td>
					<td id="grade-a">0</td>
				</tr>
				<tr>
					<td>A-</td>
					<td id="grade-a-minus">0</td>
				</tr>
				<tr>
					<td>B+</td>
					<td id="grade-b-plus">0</td>
				</tr>
				<tr>
					<td>B</td>
					<td id="grade-b">0</td>
				</tr>
				<tr>
					<td>B-</td>
					<td id="grade-b-minus">0</td>
				</tr>
				<tr>
					<td>C+</td>
					<td id="grade-c-plus">0</td>
				</tr>
				<tr>
					<td>C</td>
					<td id="grade-c">0</td>
				</tr>
				<tr>
					<td>C-</td>
					<td id="grade-c-minus">0</td>
				</tr>
				<tr>
					<td>D+</td>
					<td id="grade-d-plus">0</td>
				</tr>
				<tr>
					<td>D</td>
					<td id="grade-d">0</td>
				</tr>
				<tr>
					<td>D-</td>
					<td id="grade-d-minus">0</td>
				</tr>
				<tr>
					<td>F</td>
					<td id="grade-f">0</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>Average Grade:</td>
					<td id="average-grade">N/A</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<script src="script.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
}

.container {
	margin: 0 auto;
	padding: 20px;
	max-width: 800px;
}

h1 {
	text-align: center;
}

form {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 5px;
}

select {
	font-size: 16px;
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	text-align: left;
	padding: 8px;
border: 1px solid #ddd;
}

th {
	background-color: #0066cc;
}

td:first-child {
	font-weight: bold;
}

tfoot td {
	font-weight: bold;
}

#average-grade {
	font-weight: bold;
	color: #0066cc;
}

</style>
<script>document.addEventListener("DOMContentLoaded", function() {
    // Define the demo data
    var demoData = [
      { grade: "A+", count: 10 },
      { grade: "A", count: 20 },
      { grade: "A-", count: 5 },
      { grade: "B+", count: 15 },
      { grade: "B", count: 25 },
      { grade: "B-", count: 8 },
      { grade: "C+", count: 12 },
      { grade: "C", count: 18 },
      { grade: "C-", count: 7 },
      { grade: "D+", count: 6 },
      { grade: "D", count: 14 },
      { grade: "D-", count: 3 },
      { grade: "F", count: 2 }
    ];
  
    // Function to populate the table with demo data
    function populateTable() {
      var table = document.getElementById("grades-table");
  
      for (var i = 0; i < demoData.length; i++) {
        var grade = demoData[i].grade;
        var count = demoData[i].count;
  
        var gradeCell = document.getElementById("grade-" + grade.toLowerCase());
        if (gradeCell) {
          gradeCell.textContent = count;
        }
      }
    }
  
    // Function to calculate the average grade
    // Function to calculate the average grade
function calculateAverage() {
  var totalStudents = 0;
  var totalGrades = 0;

  for (var i = 0; i < demoData.length; i++) {
    var grade = demoData[i].grade;
    var count = demoData[i].count;

    var gradeCell = document.getElementById("grade-" + grade.toLowerCase());
    if (gradeCell) {
      var gradeCount = parseInt(gradeCell.textContent);
      totalStudents += gradeCount;
      totalGrades += gradeCount * getGradePoint(grade);
    }
  }

  if (totalStudents > 0) {
    var averageGradePoint = totalGrades / totalStudents;
    var averageGrade = getGradeFromPoint(averageGradePoint);
    var averageCell = document.getElementById("average-grade");
    if (averageCell) {
      averageCell.textContent = averageGrade;
    }
  }
}

// Helper function to assign grade points
function getGradePoint(grade) {
  switch (grade) {
    case "A+":
      return 4.0;
    case "A":
      return 4.0;
    case "A-":
      return 3.7;
    case "B+":
      return 3.3;
    case "B":
      return 3.0;
    case "B-":
      return 2.7;
    case "C+":
      return 2.3;
    case "C":
      return 2.0;
    case "C-":
      return 1.7;
    case "D+":
      return 1.3;
    case "D":
      return 1.0;
    case "D-":
      return 0.7;
    case "F":
      return 0.0;
    default:
      return 0.0;
  }
}

// Helper function to assign grades from grade points
// Helper function to assign grades from grade points
function getGradeFromPoint(gradePoint) {
  if (gradePoint >= 4.0) {
    return "A+";
  } else if (gradePoint >= 3.9) {
    return "A";
  } else if (gradePoint >= 3.7) {
    return "A-";
  } else if (gradePoint >= 3.3) {
    return "B+";
  } else if (gradePoint >= 3.0) {
    return "B";
  } else if (gradePoint >= 2.7) {
    return "B-";
  } else if (gradePoint >= 2.3) {
    return "C+";
  } else if (gradePoint >= 2.0) {
    return "C";
  } else if (gradePoint >= 1.7) {
    return "C-";
  } else if (gradePoint >= 1.3) {
    return "D+";
  } else if (gradePoint >= 1.0) {
    return "D";
  } else {
    return "F";
  }
}



    // Populate the table and calculate average on page load
    populateTable();
    calculateAverage();
  });
  </script>
</body>
</html>