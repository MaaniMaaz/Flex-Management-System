<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Faculty Interface</title>
    <style>
        body {
          font-family: Arial, sans-serif;
          margin: 0;
          padding: 0;
        }
  
        h1 {
          text-align: center;
          margin: 1rem 0;
        }
  
        form {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin-bottom: 1rem;
        }
  
        label {
          font-weight: bold;
          margin-bottom: 0.5rem;
        }
  
        input[type="text"], select {
          padding: 0.5rem;
          border-radius: 0.25rem;
          border: 1px solid #ccc;
          margin-bottom: 1rem;
          width: 100%;
          max-width: 20rem;
        }
  
        select {
          max-width: none;
        }
  
        table {
          border-collapse: collapse;
          width: 100%;
          max-width: 40rem;
          margin: 0 auto;
        }
  
        th, td {
          padding: 0.5rem;
          text-align: left;
          border-bottom: 1px solid #ccc;
        }
  
        th {
          background-color: #0066cc;
        }
  
        tr:nth-child(even) {
          background-color: #f2f2f2;
        }
  
        tr:hover {
          background-color: #e6f7ff;
        }
      </style>
  </head>
  <body>
    <h1>Faculty Interface For Grades</h1>
    <form>
      <label for="campus">Campus:</label>
      <input type="text" id="campus" value="Islamabad" disabled>
      <br>
      <label for="semester">Semester:</label>
      <input type="text" id="semester" value="Spring 2023" disabled>
      <br>
      <label for="course">Course:</label>
      <select id="course" onchange="updateTable()">
        <option value="">Select a course</option>
        <option value="CS101">CS101: Introduction to Computer Science</option>
        <option value="MATH201">MATH201: Calculus II</option>
      </select>
      <br>
    </form>
    <table id="marks-table">
      <thead>
        <tr>
          <th>Roll No.</th>
          <th>Name</th>
          <th>Marks</th>
          <th>Grade</th>
        </tr>
      </thead>
      <tbody>
        <!--  rows for demo data -->

      </tbody>
    </table>
    <script>
      function updateTable() {
        // Get the selected course
        const courseSelect = document.getElementById("course");
        const courseCode = courseSelect.value;

        // Generate demo data for the selected course
        const demoData = generateDemoData(courseCode);

        // Update the table with the demo data
        const tableBody = document.querySelector("#marks-table tbody");
        tableBody.innerHTML = "";
        for (const student of demoData) {
          const row = document.createElement("tr");
          const rollNoCell = document.createElement("td");
          const nameCell = document.createElement("td");
          const marksCell = document.createElement("td");
          const gradeCell = document.createElement("td");
          rollNoCell.textContent = student.rollNo;
          nameCell.textContent = student.name;
          marksCell.textContent = student.marks;
          gradeCell.textContent = student.grade;
          row.appendChild(rollNoCell);
          row.appendChild(nameCell);
          row.appendChild(marksCell);
          row.appendChild(gradeCell);
          tableBody.appendChild(row);
        }
      }

      function generateDemoData(courseCode) {
        // Generate demo data based on the selected course
        switch (courseCode) {
case "CS101":
return [
{ rollNo: "12345", name: "Alice", marks: "85", grade: "A" },
{ rollNo: "67890", name: "Bob", marks: "72", grade: "B" },
{ rollNo: "13579", name: "Charlie", marks: "90", grade: "A" }
];
case "MATH201":
return [
{ rollNo: "24680", name: "David", marks: "80", grade: "A" },
{ rollNo: "86420", name: "Eve", marks: "63", grade: "C" },
{ rollNo: "97531", name: "Frank", marks: "92", grade: "A" },
{ rollNo: "12341", name: "Grace", marks: "75", grade: "B" }
];
default:
return [];
}
}
</script>

  </body>
</html>





