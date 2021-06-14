CREATE TABLE Student(
[ID] [int] NOT NULL,
[FirstName] [varchar](15),
[LastName] [varchar](15),
[DateOfBirth] [date],
[EnrolledDate] [date],
[Gender] [varchar](6),
[NationalIdNumber] [int],
[CardNumber] [int],
primary key (ID)
);

CREATE TABLE Teacher(
[ID] [int] NOT NULL,
[FirstName] [varchar](15),
[LastName] [varchar](15),
[DateOfBirth] [date],
[AcademyRank] [varchar](40),
[HireData] [date],
primary key(ID)
);

CREATE TABLE GradeDetails(
[ID] [int] NOT NULL,
[GradeID] [int],
[AchievementTypeID] [int],
[AchievementTypePoints] [int],
[AchievementTypeMaxPoints] [int],
[AchievementDate] [date],
primary key(ID)
);

CREATE TABLE Course(
[ID] [int] NOT NULL,
[_name] [varchar](30),
[Credit] [int],
[AcadeicYear] [date],
[Semester] [int],
primary key(ID)
);

CREATE TABLE Grade(
[ID] [int] NOT NULL,
[StudentID] [int],
[CourseID] [int],
[TeacherID] [int],
[Grade] [int],
[Comment] [varchar](150),
[CreatedDate] [date],
primary key(ID),
);

CREATE TABLE AchievementType(
[ID] [int] NOT NULL,
[_name] [varchar](20),
[_description] [varchar](100),
[ParticipationRate] [decimal](2,2),
primary key(ID)
);