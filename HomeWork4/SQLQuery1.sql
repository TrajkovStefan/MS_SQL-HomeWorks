--Declare scalar variable for storing FirstName values
--Assign value ‘Antonio’ to the FirstName variable
--Find all Students  having FirstName  same as the variable

DECLARE
@FirstName NVARCHAR(50)
SET @FirstName = 'Antonio'
SELECT * FROM [Student]
WHERE FirstName = @FirstName
GO

--Declare table variable that will contain StudentId, StudentNameand DateOfBirth
--Fill the  table variable with all Female  students

DECLARE @FemaleStudents TABLE
(StudentID INT NOT NULL, FirstName NVARCHAR(50) NULL, DateOfBirth Date)
INSERT INTO @FemaleStudents (StudentID, FirstName, DateOfBirth)
SELECT ID, FirstName, DateOfBirth
FROM [Student]
WHERE Gender = 'F'
SELECT * FROM @FemaleStudents
GO

--Declare temp table that will contain LastNameand EnrolledDatecolumns
--Fill the temp table with all Male students having First Name starting with ‘A’
--Retrieve  the students  from the  table which last name  is with 7 characters

CREATE TABLE #MaleStudents
(LastName NVARCHAR(50) NOT NULL,EnrolledDate DATE)
INSERT INTO #MaleStudents(LastName, EnrolledDate)
SELECT LastName,EnrolledDate
FROM Student
WHERE Gender='M' AND FirstName LIKE 'A%'
SELECT * FROM #MaleStudents
WHERE LEN(LastName)=7
GO
DROP TABLE #MaleStudents
GO

--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName  and LastName are the same
SELECT FirstName,
LEN(FirstName),
LEFT(FirstName,3),
LEFT(LastName,3)
FROM Teacher 
WHERE LEN(FirstName) < 5 AND LEFT(FirstName,3) = LEFT(LastName,3) 
GO

--Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentIdin the following format:
--StudentCardNumberwithout “sc-”
--“ –“
--First character  of student  FirstName
--“.”
--Student LastName

CREATE OR ALTER FUNCTION dbo.fn_FormatStudentName(@StudentID INT)
RETURNS NVARCHAR(100)
AS
BEGIN

DECLARE @Output NVARCHAR(100)
SELECT @Output = REPLACE(Student.StudentCardNumber, 'sc-', '')+'-'+LEFT(FirstName,1)+'.'+LastName
FROM [Student]
WHERE ID = @StudentID
RETURN @Output
END
GO

SELECT * ,dbo.fn_FormatStudentName(ID) AS Result
FROM [Student]
GO


