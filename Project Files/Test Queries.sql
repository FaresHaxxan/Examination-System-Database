-- ======================== Test Queries =======================

USE Examination_DB;
go

-- ======================== Test Views =======================

-- Testing InstructorCourseView
SELECT * FROM [dbo].[InstructorCourseView];

-- Testing StudentView
SELECT * FROM [dbo].[StudentView];

-- Testing ExamInstructorView
SELECT * FROM [Instructor].[ExamInstructorView];

-- Testing StudentCourseView
SELECT * FROM [Instructor].[StudentCourseView];

-- Testing ClassDetailsView
SELECT * FROM [T_Manager].[ClassDetailsView];

-- Testing CourseView
SELECT * FROM [T_Manager].[CourseView];

-- Testing StudentCourseView
SELECT * FROM [T_Manager].[StudentCourseView];

-- Testing StudentExamView
SELECT * FROM [T_Manager].[StudentExamView];

-- ======================== Test Triggers =======================

-- Testing Exam Created Trigger
INSERT INTO Exam (Type_Exam, Exam_Date, exam_StartTime, exam_TotalDuration, TotalDegree, Crs_Id, class_Id, Ins_Exam)
VALUES ('Midterm', '2024-02-15', '10:00:00', 120, 100, 1, 1, 1);

-- Testing Update Student Answer Trigger
UPDATE [dbo].[StudentExam] SET StudentAnswer = 'New Answer' WHERE ExamID = 1 AND QuestionID = 'Q1' AND StudentID = 1;

-- Testing Add Student to Exam Trigger
INSERT INTO [dbo].[StudentExam] (ExamID, QuestionID, StudentID, StudentAnswer, Result)
VALUES (1, 'Q2', 2, 'True', 1);

-- Testing Mark Exam Trigger
UPDATE [dbo].[StudentExam] SET Result = 2 WHERE ExamID = 1 AND QuestionID = 'Q2' AND StudentID = 2;

-- Testing Insert Data in ExamQuestion Table Trigger
INSERT INTO ExamQuestion (ExamID, QuestionID, Degree)
VALUES (1, 'Q3', 10);

-- Testing Update Final Result Trigger
INSERT INTO [StudentCourse] (StudentID, CourseID, TotalDegree, FinalResult)
VALUES (1, 1, 80, NULL);

-- OR

UPDATE [StudentCourse] SET TotalDegree = 40 WHERE StudentID = 1 AND CourseID = 1;

-- ======================== Test Functions =======================

-- Test for InstructorDataOrderedBy_Function
SELECT * FROM dbo.InstructorDataOrderedBy_Function('InstructorName');
SELECT * FROM dbo.InstructorDataOrderedBy_Function('ExamDate');
SELECT * FROM dbo.InstructorDataOrderedBy_Function('CourseName');
SELECT * FROM dbo.InstructorDataOrderedBy_Function('CourseID');
SELECT * FROM dbo.InstructorDataOrderedBy_Function('InstructorID');

-- Test for InstructorSearchByPattern_FN
SELECT * FROM Instructor.InstructorSearchByPattern_FN('InstructorName', 'John');
SELECT * FROM Instructor.InstructorSearchByPattern_FN('CourseName', 'Math');
SELECT * FROM Instructor.InstructorSearchByPattern_FN('CourseID', '1');
SELECT * FROM Instructor.InstructorSearchByPattern_FN('InstructorID', '2');
SELECT * FROM Instructor.InstructorSearchByPattern_FN('ExamID', '3');

-- Test for StdCourseInfoByStudentID_FN
SELECT * FROM Student.StdCourseInfoByStudentID_FN(1);

-- Test for T_Manager.InstructorSearchByPattern_FN
SELECT * FROM T_Manager.InstructorSearchByPattern_FN('InstructorName', 'John');
SELECT * FROM T_Manager.InstructorSearchByPattern_FN('CourseName', 'Math');
SELECT * FROM T_Manager.InstructorSearchByPattern_FN('CourseID', '1');
SELECT * FROM T_Manager.InstructorSearchByPattern_FN('InstructorID', '2');
SELECT * FROM T_Manager.InstructorSearchByPattern_FN('ExamID', '3');

-- Test for T_Manager.ManagerSearchByPattern_FN
SELECT * FROM T_Manager.ManagerSearchByPattern_FN('StudentName', 'John');
SELECT * FROM T_Manager.ManagerSearchByPattern_FN('StudentEmail', 'john@example.com');
SELECT * FROM T_Manager.ManagerSearchByPattern_FN('StudentCity', 'City');
SELECT * FROM T_Manager.ManagerSearchByPattern_FN('BrancheName', 'Branch');
SELECT * FROM T_Manager.ManagerSearchByPattern_FN('TrackName', 'Track');
SELECT * FROM T_Manager.ManagerSearchByPattern_FN('IntakeName', 'Intake');

-- Test for T_Manager.SearchByPatternStdTable_FN
SELECT * FROM T_Manager.SearchByPatternStdTable_FN('Name', 'John');
SELECT * FROM T_Manager.SearchByPatternStdTable_FN('Email', 'john@example.com');
SELECT * FROM T_Manager.SearchByPatternStdTable_FN('City', 'City');

-- ======================== Test Procedures =======================

-- Test for [Instructor].[AddQuestions_Proc]
-- Declare variables
DECLARE @InstructorID INT = 2; 
DECLARE @CourseID INT = 1; 
DECLARE @RandomSelection VARCHAR(15) = 'Random'; 
DECLARE @ExamID INT = 1; 
DECLARE @NumberOfRandomQuestion INT = 3; 

-- Declare a table variable for manual questions
DECLARE @QuestionDegrees QuestionDegreesType;
INSERT INTO @QuestionDegrees (QuestionID, QuestionDegree)
VALUES ('Q1', 50), ('Q2', 100), ('Q3', 30);

-- Execute the stored procedure
EXEC [Instructor].[AddQuestions_Proc]
    @InstructorID,
    @CourseID,
    @RandomSelection,
    @ExamID,
    @NumberOfRandomQuestion,
    @QuestionDegrees;
go

-- Test for [Instructor].[AddStudentsToExam]
-- Declare variables
DECLARE @InstructorID INT = 1;
DECLARE @StudentIDs NVARCHAR(MAX) = '1,2,3';
DECLARE @ExamID INT = 1;

-- Execute the stored procedure
EXEC [Instructor].[AddStudentsToExam]
    @InstructorID,
    @StudentIDs,
    @ExamID;
go

-- Test for [Instructor].[CreateExam]
-- Declare variables
DECLARE @Type NVARCHAR(50) = 'Midterm';
DECLARE @ExamDate DATE = '2024-02-20';
DECLARE @StartTime NVARCHAR(8) = '10:00:00';
DECLARE @TotalTime INT = 120;
DECLARE @TotalDegree INT = 100;
DECLARE @Crs_Id INT = 1;
DECLARE @Class_Id INT = 1;
DECLARE @InstructorId INT = 1;

-- Execute the stored procedure
EXEC [Instructor].[CreateExam]
    @Type,
    @ExamDate,
    @StartTime,
    @TotalTime,
    @TotalDegree,
    @Crs_Id,
    @Class_Id,
    @InstructorId;
go

-- Test for [Instructor].[GetExamsByYearCourseInstructor]
-- Declare variables
DECLARE @year INT = 2022;
DECLARE @courseId INT = 1;
DECLARE @instructorId INT = 1;

-- Execute the stored procedure
EXEC [Instructor].[GetExamsByYearCourseInstructor]
    @year,
    @courseId,
    @instructorId;
go

-- Test for [Instructor].[OrderBYStd_Proc]
-- Declare variables
DECLARE @option1 NVARCHAR(100) = 'Age';

-- Execute the stored procedure
EXEC [Instructor].[OrderBYStd_Proc]
    @option1;
go

-- Test for [Instructor].[StudentDataOrderedBy_Proc]
-- Declare variables
DECLARE @OrderByColumn VARCHAR(100) = 'Name';

-- Execute the stored procedure
EXEC [Instructor].[StudentDataOrderedBy_Proc]
    @OrderByColumn;
go

-- Test for [Instructor].[UpdateResults]
-- Declare variables
DECLARE @std_id INT = 1;
DECLARE @exam_id INT = 1;

-- Execute the stored procedure
EXEC [Instructor].[UpdateResults]
    @std_id,
    @exam_id;
go

-- Test for [Student].[StoreStudentAnswers]
-- Declare variables
DECLARE @std_id INT = 1;
DECLARE @exam_id INT = 1;

-- Declare a table variable for student answers
DECLARE @student_answers AnswerTableType;
INSERT INTO @student_answers (QuestionID, StudentAnswer)
VALUES 
    ('Q1', 'Option A'),
    ('Q2', 'True'),
    ('Q3', 'Oxygen');

-- Execute the stored procedure
EXEC [Student].[StoreStudentAnswers]
    @std_id,
    @exam_id,
    @student_answers;
go

-- Test for [T_Manager].[CreateUserLogin]
-- Declare variables
DECLARE @Name NVARCHAR(255) = 'NewUser';
DECLARE @Password NVARCHAR(255) = 's123';
DECLARE @UserType NVARCHAR(255) = 'Student';

-- Execute the stored procedure
EXEC [T_Manager].[CreateUserLogin]
    @Name,
    @Password,
    @UserType;
go

-- Test for [T_Manager].[crs_std_inst_INFO_by_course_id]
-- Declare variables
DECLARE @CourseID INT = 1;

-- Execute the stored procedure
EXEC [T_Manager].[crs_std_inst_INFO_by_course_id]
    @CourseID;
go

-- Test for [T_Manager].[InstructorDataOrderedBy_Proc]
-- Declare variables
DECLARE @OrderByColumn NVARCHAR(MAX) = 'InstructorName';

-- Execute the stored procedure
EXEC [T_Manager].[InstructorDataOrderedBy_Proc]
    @OrderByColumn;
go

-- Test for [T_Manager].[MangerDataOrderedBy_Proc]
-- Declare variables
DECLARE @Option1 NVARCHAR(MAX) = 'StudentName';

-- Execute the stored procedure
EXEC [T_Manager].[MangerDataOrderedBy_Proc]
    @Option1;
go

-- Test for [T_Manager].[OrderBYStd_Proc]
-- Declare variables
DECLARE @option1 VARCHAR(100) = 'Name';

-- Execute the stored procedure
EXEC [T_Manager].[OrderBYStd_Proc]
    @option1;
go

-- Test for [T_Manager].[ShowDataByYear]
-- Declare variables
DECLARE @inputYear INT = 2022;

-- Execute the stored procedure
EXEC [T_Manager].[ShowDataByYear]
    @inputYear;
go

-- Test for [T_Manager].[UpdateYearOnIntakeInsert]
-- Declare variables
DECLARE @intake VARCHAR(50) = '2025';
DECLARE @id INT = 1;

-- Execute the stored procedure
EXEC [T_Manager].[UpdateYearOnIntakeInsert]
    @intake,
    @id;
