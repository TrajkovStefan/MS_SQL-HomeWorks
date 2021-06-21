USE [SEDCHome]
GO

--Find all Students with FirstName = Antonio
select FirstName, LastName from Student
where FirstName = 'Antonio'
GO

--Find all Students with DateOfBirth greater than '01.01.1999'
select FirstName, LastName, DateOfBirth from Student
where DateOfBirth > '01.01.1999'
ORDER BY DateOfBirth ASC
GO

--Find all Male Students
select FirstName, LastName, Gender from Student
where Gender = 'M'
GO

--Find all Students with LastName starting with 'T'
select FirstName, LastName from Student 
where LastName like ('T%')
GO

--Find all Students Enrolled in January/1998
select FirstName, LastName, EnrolledDate from Student
where EnrolledDate >= '1998-01-01'
and EnrolledDate < '1998-02-01'
GO

--Find all Students with LastNamestarting With ‘J’ enrolled in January/1998
select FirstName, LastName, EnrolledDate from Student
where EnrolledDate >= '1998-01-01'
and EnrolledDate < '1998-02-01'
GO

--Find all Students with FirstName= Antonio ordered by Last Name
select FirstName, LastName from Student
where FirstName = 'Antonio' 
order by LastName asc
GO

--List all Students ordered by FirstName
select FirstName, LastName from Student
order by FirstName asc
GO

--Find all Male students ordered by EnrolledDate, starting from the last enrolled
select FirstName, LastName, EnrolledDate from Student
order by EnrolledDate desc
GO

--List all Teacher First Names and Student First Names in single result set with duplicates
select FirstName from Teacher
union all
select FirstName from Student
GO

--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
select LastName from Teacher 
union
select LastName from Student
GO

--List all common First Names for Teachers and Students
select FirstName from Teacher
intersect
select FirstName from Student
GO

--Change GradeDetailstable always to insert value 100 in AchievementMaxPointscolumn if no value is provided on insert
alter table [GradeDetails]
add constraint DF_Achievement_Max_Points
default 100 for [AchievementMaxPoints]
GO

--Change GradeDetailstable to prevent inserting AchievementPointsthat will more than AchievementMaxPoints
alter table [GradeDetails]
add constraint chk_Achievement_Points
check (AchievementMaxPoints >= AchievementPoints)
GO

--Change AchievementTypetable to guarantee unique names across the Achievement types
alter table [AchievementType]
with check
add constraint unique_Achievement_Type unique (Name)
GO

--Create Foreign key constraints from diagram or with script
alter table Grade
add foreign key (StudentID)
references Student(ID)
GO

alter table Grade
add foreign key (CourseID)
references Course(ID)
GO

alter table Grade
add foreign key(TeacherID)
references Teacher(ID)
GO

alter table GradeDetails
add foreign key(GradeID)
references Grade(ID)
GO

alter table GradeDetails
add foreign key(AchievementTypeID)
references AchievementType(ID)
GO

--List all possible combinations of Courses names and AchievementTypenames that can be passed by student
select distinct Name from Course
GO

select distinct Name from AchievementType
GO

--List all Teachers that has any exam Grade
select * from Grade
where TeacherID <> 0
GO

--List all Teachers without exam Grade
select * from Grade
where TeacherID = 0
GO

--List all Students without exam Grade (using Right Join)
select Student.FirstName, Student.LastName, Grade.Grade
from Grade 
right join Student on Student.ID = 0 and Grade.StudentID = 0
where StudentID is null
GO