USE [SEDCHome]
GO

--Calculate the count of all grades in the system
SELECT COUNT(*) AS [Total Grades]
FROM [Grade] AS G
GO

--Calculate the count of all grades per Teacher in the system
SELECT COUNT(*) AS [Total Grades], [TeacherID] AS [Teacher ID]
FROM [Grade]
GROUP BY TeacherID
ORDER BY COUNT(*) ASC
GO

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
SELECT T.ID, T.FirstName, COUNT(G.Grade) AS [Total Grades]
FROM [Grade] AS G
INNER JOIN [Teacher] AS T ON T.Id = G.TeacherID
WHERE StudentID < 100
GROUP BY T.ID, T.FirstName
ORDER BY COUNT(G.Grade) ASC
GO

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT S.ID, S.FirstName, MAX(Grade) AS [Max Grade], AVG(Grade) AS [Avg Grade]
FROM [Grade] 
INNER JOIN [Student] AS S ON S.ID = StudentID
GROUP BY S.ID, S.FirstName
ORDER BY AVG(Grade) ASC
GO

--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
SELECT T.ID, T.FirstName, COUNT(Grade) AS [Total Grades]
FROM [Grade] 
INNER JOIN [Teacher] AS T ON T.ID = TeacherID
GROUP BY T.ID, T.FirstName
HAVING COUNT(Grade) > 200
ORDER BY COUNT(Grade) ASC
GO

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
SELECT T.FirstName, COUNT(Grade) AS [Total Grades]
FROM [Grade] 
INNER JOIN [Teacher] AS T ON T.Id = Grade.TeacherID
WHERE Grade.StudentID < 100
GROUP BY T.FirstName
HAVING COUNT(Grade) > 50
ORDER BY COUNT(Grade) ASC
GO

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
SELECT S.ID, S.FirstName, COUNT(Grade) AS [Total Grades], MAX(Grade) AS [Max Grade], AVG(Grade) AS [Avg Grade]
FROM [Grade]
INNER JOIN [Student] AS S ON S.ID = Grade.StudentID
GROUP BY S.ID, S.FirstName
HAVING MAX(Grade) = AVG(Grade)
GO

--List Student First Name and Last Name next to the other details from previous query
SELECT S.ID, S.FirstName, S.LastName, COUNT(Grade) AS [Total Grades], MAX(Grade) AS [Max Grade], AVG(Grade) AS [Avg Grade]
FROM [Grade]
INNER JOIN [Student] AS S ON S.ID = Grade.StudentID
GROUP BY S.ID, S.FirstName, S.LastName
HAVING MAX(Grade) = AVG(Grade)
ORDER BY MAX(Grade) ASC
GO

--Create new view (vv_StudentGrades) that will List all StudentIdsand count of Grades per student
CREATE VIEW vv_StudentGrades
AS
SELECT S.ID , COUNT(Grade) AS [Total Grades]
FROM [Grade]
INNER JOIN [Student] AS S ON S.ID=Grade.StudentID
GROUP BY S.ID
GO

SELECT * FROM vv_StudentGrades
GO

--Change the view to show Student First and Last Names instead of StudentID
ALTER VIEW vv_StudentGrades 
AS
SELECT S.FirstName, S.LastName, COUNT(Grade) AS [Total Grades]
FROM [Grade]
INNER JOIN [Student] AS S ON S.ID = Grade.StudentID
GROUP BY S.FirstName, S.LastName
GO

SELECT * FROM vv_StudentGrades
GO

--List all rows from view ordered by biggest Grade Count
SELECT * FROM vv_StudentGrades
ORDER BY [Total Grades] DESC
GO

--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
CREATE VIEW vv_StudentGradeDetails
AS 
SELECT S.FirstName, S.LastName, COUNT(Grade) AS [Total passed courses], A.Name
FROM [Grade]
INNER JOIN [Student] AS S ON S.ID = Grade.StudentID
INNER JOIN [GradeDetails] AS GD ON GD.GradeID = Grade.ID
INNER JOIN [AchievementType] AS A ON A.ID = GD.AchievementTypeID
WHERE GD.AchievementPoints > A.ParticipationRate
AND A.Name = 'ISPIT'
GROUP BY S.FirstName, S.LastName, A.Name
GO

SELECT * FROM vv_StudentGradeDetails
ORDER BY [Total passed courses] DESC
GO