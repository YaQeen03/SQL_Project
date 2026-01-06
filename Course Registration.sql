/* ================================
   Course Registration Database
   ================================ */

CREATE DATABASE CourseRegistrationDB;
GO
USE CourseRegistrationDB;
GO

/* ========= Departments ========= */
CREATE TABLE Departments (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL
);

/* ========= Instructors ========= */
CREATE TABLE Instructors (
    Instructor_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department_ID INT,
    Email VARCHAR(100),
    FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);

/* ========= Courses ========= */
CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Instructor_ID INT,
    Credits INT NOT NULL,
    Department_ID INT,
    FOREIGN KEY (Instructor_ID) REFERENCES Instructors(Instructor_ID),
    FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);

/* ========= Students ========= */
CREATE TABLE Students (
    Student_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone_Number VARCHAR(15),
    Enrollment_Date DATE
);

/* ========= Enrollments (M:M) ========= */
CREATE TABLE Enrollments (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,
    Status VARCHAR(20) CHECK (Status IN ('Enrolled','Completed','Withdrawn')),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);

/* ========= Course Requirements ========= */
CREATE TABLE Course_Requirements (
    Course_ID INT,
    Prerequisite_Course_ID INT,
    PRIMARY KEY (Course_ID, Prerequisite_Course_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID),
    FOREIGN KEY (Prerequisite_Course_ID) REFERENCES Courses(Course_ID)
);

/* ========= Sample Data ========= */
INSERT INTO Departments VALUES
(1,'Computer Science'),(2,'IT'),(3,'Business'),(4,'Engineering'),(5,'Math');

INSERT INTO Instructors VALUES
(1,'Dr. Ahmad',1,'ahmad@uni.edu'),
(2,'Dr. Sara',2,'sara@uni.edu'),
(3,'Dr. Ali',3,'ali@uni.edu'),
(4,'Dr. Noor',1,'noor@uni.edu'),
(5,'Dr. Omar',4,'omar@uni.edu');

INSERT INTO Courses VALUES
(101,'Database Systems',1,3,1),
(102,'Web Development',4,3,1),
(103,'Business Management',3,3,3),
(104,'Networking',2,3,2),
(105,'Software Engineering',5,4,4);

INSERT INTO Students VALUES
(1,'Ali','Khaled','ali@student.com','0791111111','2024-09-01'),
(2,'Sara','Ahmad','sara@student.com','0792222222','2024-09-01'),
(3,'Omar','Yousef','omar@student.com','0793333333','2024-09-01'),
(4,'Lina','Hassan','lina@student.com','0794444444','2024-09-01'),
(5,'Noor','Salem','noor@student.com','0795555555','2024-09-01');

INSERT INTO Enrollments VALUES
(1,1,101,'2024-09-10','Enrolled'),
(2,2,101,'2024-09-10','Completed'),
(3,3,102,'2024-09-12','Enrolled'),
(4,4,103,'2024-09-15','Withdrawn'),
(5,5,104,'2024-09-18','Completed');

INSERT INTO Course_Requirements VALUES
(102,101),(105,101);

/* ========= Queries ========= */

-- Students enrolled in a course
SELECT s.First_Name, s.Last_Name
FROM Students s
JOIN Enrollments e ON s.Student_ID=e.Student_ID
WHERE e.Course_ID=101;

-- Add new student
INSERT INTO Students VALUES
(6,'Huda','Mahmoud','huda@student.com','0796666666','2024-10-01');

-- Update enrollment status
UPDATE Enrollments
SET Status='Completed'
WHERE Student_ID=1 AND Course_ID=101;

-- Courses by instructor
SELECT Course_Name FROM Courses WHERE Instructor_ID=1;

-- Students who completed a course
SELECT s.First_Name, s.Last_Name
FROM Students s
JOIN Enrollments e ON s.Student_ID=e.Student_ID
WHERE e.Course_ID=101 AND e.Status='Completed';

-- Courses in a department
SELECT Course_Name FROM Courses WHERE Department_ID=1;
