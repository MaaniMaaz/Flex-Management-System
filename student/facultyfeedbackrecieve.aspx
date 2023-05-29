<!DOCTYPE html>
<html>
<head>
	<title>Faculty Feedback</title>
<style>body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
}

h1 {
    text-align: center;
    margin-top: 50px;
    color: #333;
}

form {
    width: 80%;
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

label {
    display: block;
    margin-bottom: 10px;
    color: #333;
}

select {
    display: block;
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: none;
    background-color: #f2f2f2;
    margin-bottom: 20px;
    color: #333;
}

input[type="submit"] {
    display: block;
    margin: 0 auto;
    padding: 10px 20px;
    background-color: #107eeb;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: all 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #0066cc;
}

table {
    width: 100%;
    margin-top: 50px;
    border-collapse: collapse;
}

th,
td {
    width: 20%;
    padding: 10px;
    text-align: center;
    border: 1px solid #ddd;
}
th:first-child {
    width: 10%;
    text-align: center;
}

thead {
    background-color: #f2f2f2;
}

.comments {
    margin-top: 50px;
}

.comments label {
    display: block;
    margin-bottom: 10px;
    color: #333;
}

.comments ol {
    padding: 0;
    margin: 0;
    list-style: none;
}

.comments li {
    margin-bottom: 10px;
    color: #555;
    font-style: italic;
}

#feedback {
    display: none;
}
</style>
</head>
<body>
	<h1>Faculty Feedback</h1>
	<form>
		<label for="class">Class and Section:</label>
		<select id="class" name="class">
			<option value="">-- Select Class and Section --</option>
			<option value="1A">1A</option>
			<option value="1B">1B</option>
			<option value="2A">2A</option>
			<option value="2B">2B</option>
		</select>
		<input type="submit" value="Submit">
	</form>
	<div id="feedback">
		<table>
			<thead>
				<tr>
					<th>Date</th>
					<th>Appearance and Personal Presentation</th>
					<th>Professional Practices</th>
					<th>Teaching Methods</th>
					<th>Disposition Towards Students</th>
				</tr>
			</thead>
			<tbody id="ratings">
			</tbody>
		</table>
		<div class="comments">
			<label for="comments">Top Comments:</label>
			<ol id="comments"></ol>
		</div>
	</div>
	<script>
    const form = document.querySelector('form');
    const feedback = document.getElementById('feedback');
    const ratings = document.getElementById('ratings');
    const comments = document.getElementById('comments');

    form.addEventListener('submit', (event) => {
        event.preventDefault();
        const classSelected = form.elements['class'].value;
        if (classSelected) {
            ratings.innerHTML = '';
            comments.innerHTML = '';
            feedback.style.display = 'block';
            for (let i = 1; i <= 5; i++) {
                const tr = document.createElement('tr');
                const dateTd = document.createElement('td');
                const appearanceTd = document.createElement('td');
                const practicesTd = document.createElement('td');
                const methodsTd = document.createElement('td');
                const dispositionTd = document.createElement('td');
                dateTd.textContent = `10/${i}/2023`;
                appearanceTd.textContent = Math.floor(Math.random() * 5) + 1;
                practicesTd.textContent = Math.floor(Math.random() * 5) + 1;
                methodsTd.textContent = Math.floor(Math.random() * 5) + 1;
                dispositionTd.textContent = Math.floor(Math.random() * 5) + 1;
                tr.appendChild(dateTd);
                tr.appendChild(appearanceTd);
                tr.appendChild(practicesTd);
                tr.appendChild(methodsTd);
                tr.appendChild(dispositionTd);
                ratings.appendChild(tr);
            }
            const commentsList = [
                'Excellent teacher, very clear and concise explanations',
                'Engaging lectures and activities, great use of technology',
                'Good feedback on assignments and assessments',
                'Could be more organized and punctual',
                'Not very approachable outside of class'
            ];
            commentsList.forEach(comment => {
                const li = document.createElement('li');
                li.textContent = comment;
                comments.appendChild(li);
            });
            ratings.style.display = 'block';
            comments.style.display = 'block';
        }
    });
</script>
</body></html>