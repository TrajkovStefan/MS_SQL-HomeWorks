--Create multi-statement table value function that for specific Teacher and Course will return list of students (FirstName, LastName) 
--who passed the exam, together with Grade and CreatedDate

  
USE SEDCHome
GO

DROP FUNCTION IF EXISTS dbo.fn_StudentDetails_MultiStatement;
GO

CREATE OR ALTER FUNCTION dbo.fn_StudentDetails_MultiStatement(@TeacherId INT,@CourseId INT)
RETURNS @Output TABLE(FirstName NVARCHAR(50), LastName NVARCHAR(50),Grade INT, CreatedDate DATE)
AS
BEGIN

INSERT INTO @Output
	SELECT S.FirstName AS FirstName, S.LastName AS LastName, G.Grade AS Grade, G.CreatedDate AS CreatedDate
	FROM dbo.[Teacher] T
	INNER JOIN dbo.[Grade] AS G ON G.TeacherID = T.ID
	INNER JOIN dbo.[GradeDetails] AS GD ON GD.GradeID = G.ID
	INNER JOIN dbo.[Course] AS C ON C.ID = G.CourseID
	INNER JOIN dbo.[Student] AS S ON S.ID = G.StudentID
	INNER JOIN dbo.[AchievementType] AS A ON A.ID = GD.AchievementTypeID
	WHERE A.ParticipationRate < GD.AchievementPoints AND T.ID = @TeacherId AND C.ID = @CourseId
	GROUP BY S.FirstName, S.LastName, G.Grade, G.CreatedDate
RETURN
END
GO

SELECT *
FROM dbo.fn_StudentDetails_MultiStatement(2,2)
GO

SELECT *
FROM dbo.fn_StudentDetails_MultiStatement(4,4)
GO