-- A
-- The Curriculum Planning Committee attempts to fill in gaps in the current course offerings. 
-- You need to provide them with a query that lists each department and the number of courses offered by that department. 
-- The two columns should have headers “Department Name” and “# Courses,” and the output should be sorted by “# Courses” in each department (ascending).
SELECT d.name AS "Department Name",
COUNT(c.id) as "# Courses"
FROM department d
join course c on d.id = c.deptid
GROUP BY d.name
ORDER BY COUNT(c.id) ASC;

-- B
-- The recruiting department needs to know which courses are most popular with the students. 
-- Please provide them with a query that lists the name of each course and the number of students in that course. 
-- The two columns should have headers “Course Name” and “# Students,” and the output should be sorted first by # Students descending and then by course name ascending. 
SELECT c.name as "Course Name",
COUNT(s.id) as "# students"
FROM course c
INNER JOIN student s on c.id = s.majorid
GROUP BY c.name
ORDER BY "# students" DESC, c.name ASC;


-- C1
-- Write a query to list the names of all courses where the number(#) of the faculty assigned to those courses is zero. 
-- The output should be in alphabetical order by course name.
SELECT name
FROM course
WHERE id NOT IN (SELECT courseId FROM facultyCourse)
ORDER BY name;

-- C2
-- Using the above, write a query to list the course names and the # of students in those courses for all courses where there are no assigned faculty. 
-- The output should be ordered first by # of students descending and then by course name ascending.
SELECT c.name AS "Course Name", 
COUNT(s.studentId) AS "# students"
FROM course c 
INNER JOIN StudentCourse s ON c.id = s.courseId
WHERE c.id NOT IN (SELECT courseId FROM facultyCourse)
GROUP BY c.name
ORDER BY COUNT(s.studentId) DESC, c.name ASC;

-- D
-- The enrollment team is gathering analytics about student enrollment throughout the years. 
-- Write a query that lists the total # of students that were enrolled in classes during each school year. 
-- The first column should have the header “Students.”  Provide a second “Year” column showing the enrollment year
SELECT COUNT(*) AS "Students", YEAR(StartDate) AS "Year"
FROM studentCourse
GROUP BY YEAR(StartDate);

-- E
-- The enrollment team is gathering analytics about student enrollment, and they now want to know about August admissions specifically. 
-- Write a query that lists the Start Date and "#" of Students who enrolled in classes in August of each year. 
-- The output should be ordered by the start date ascending.
SELECT StartDate, COUNT(*) AS "# Students"
FROM studentCourse 
WHERE MONTH(StartDate) = 8
GROUP BY YEAR(StartDate), MONTH(StartDate), StartDate
ORDER BY StartDate ASC;

-- F
-- Students are required to take four courses, and at least two of these courses must be from the department of their major.
--  Write a query to list students’ “First Name,” “Last Name,” and Number of Courses they are taking in their major department.  
--  The output should be sorted first in increasing order of the number of courses, then by the student's last name
SELECT s.FirstName, s.LastName, COUNT(*) AS "Number of Courses"
FROM Student s
JOIN studentCourse sc ON s.Id = sc.studentId
JOIN course c ON sc.courseId = c.id
WHERE S.majorId = c.deptId
GROUP BY S.FirstName, S.LastName
ORDER BY "Number of Courses" ASC, s.LastName ASC;

-- G
-- Students making average progress in their courses of less than 50% need to be offered tutoring assistance. 
-- Write a query to list First Name, Last Name, and Average Progress of all students achieving average progress of less than 50%.
--  The average progress as displayed should be rounded to one decimal place. Sort the output by average progress descending 
SELECT s.FirstName, s.LastName, ROUND(AVG(sc.Progress), 1) AS "Average Progress"
FROM Student s
JOIN studentCourse sc ON s.id = sc.studentID
GROUP BY s.FirstName, s.LastName
HAVING "Average Progress" < 50
ORDER BY "Average Progress" DESC;









