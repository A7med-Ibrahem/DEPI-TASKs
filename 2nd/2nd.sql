CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    ManagerID INT,
    CreatedAt DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Fname VARCHAR(30) NOT NULL,
    Lname VARCHAR(30) NOT NULL,
    Gender CHAR(1) NOT NULL,
    BirthDate DATE NOT NULL,
    DepartmentID INT NOT NULL,
    CreatedAt DATE DEFAULT GETDATE()
);

ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_Gender
CHECK (Gender IN ('M','F'));

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL UNIQUE,
    LocationCity VARCHAR(50),
    DepartmentID INT NOT NULL
);

CREATE TABLE Dependent (
    EmployeeID INT NOT NULL,
    DependentName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    BirthDate DATE NOT NULL,
    CONSTRAINT PK_Dependent PRIMARY KEY (EmployeeID, DependentName),
    CONSTRAINT CK_Dependent_Gender CHECK (Gender IN ('M','F'))
);

CREATE TABLE Works_On (
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,
    WorkingHours INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_WorksOn PRIMARY KEY (EmployeeID, ProjectID),
    CONSTRAINT CK_WorkingHours CHECK (WorkingHours >= 0)
);

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (DepartmentID)
REFERENCES Department(DepartmentID)
ON UPDATE CASCADE;

ALTER TABLE Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (ManagerID)
REFERENCES Employee(EmployeeID)
ON UPDATE CASCADE;

ALTER TABLE Project
ADD CONSTRAINT FK_Project_Department
FOREIGN KEY (DepartmentID)
REFERENCES Department(DepartmentID)
ON DELETE NO ACTION;

ALTER TABLE Dependent
ADD CONSTRAINT FK_Dependent_Employee
FOREIGN KEY (EmployeeID)
REFERENCES Employee(EmployeeID)
ON DELETE CASCADE;

ALTER TABLE Works_On
ADD CONSTRAINT FK_WorksOn_Employee
FOREIGN KEY (EmployeeID)
REFERENCES Employee(EmployeeID);

ALTER TABLE Works_On
ADD CONSTRAINT FK_WorksOn_Project
FOREIGN KEY (ProjectID)
REFERENCES Project(ProjectID);

ALTER TABLE Employee
ADD Email VARCHAR(100);

ALTER TABLE Employee
ALTER COLUMN Fname VARCHAR(50);

ALTER TABLE Department
DROP CONSTRAINT FK_Department_Manager;

ALTER TABLE Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (ManagerID)
REFERENCES Employee(EmployeeID);

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee
(EmployeeID, Fname, Lname, Gender, BirthDate, DepartmentID, Email)
VALUES
(1, 'Ahmed', 'Ali', 'M', '1985-01-01', 1, 'ahmed@company.com'),
(2, 'Sara', 'Mohamed', 'F', '1988-05-10', 2, 'sara@company.com'),
(3, 'Omar', 'Hassan', 'M', '1990-03-15', 3, 'omar@company.com'),
(4, 'Mona', 'Said', 'F', '1995-07-20', 1, 'mona@company.com'),
(5, 'Khaled', 'Youssef', 'M', '1992-11-11', 1, 'khaled@company.com');

UPDATE Department SET ManagerID = 1 WHERE DepartmentID = 1;
UPDATE Department SET ManagerID = 2 WHERE DepartmentID = 2;
UPDATE Department SET ManagerID = 3 WHERE DepartmentID = 3;

INSERT INTO Project
(ProjectID, ProjectName, LocationCity, DepartmentID)
VALUES
(101, 'Website', 'Cairo', 1),
(102, 'Recruitment', 'Giza', 2),
(103, 'BudgetSystem', 'Alex', 3);

INSERT INTO Works_On
(EmployeeID, ProjectID, WorkingHours)
VALUES
(1, 101, 20),
(4, 101, 30),
(5, 101, 15),
(2, 102, 25),
(3, 103, 40);

INSERT INTO Dependent
(EmployeeID, DependentName, Gender, BirthDate)
VALUES
(1, 'AliJr', 'M', '2012-01-01'),
(4, 'Mariam', 'F', '2018-03-05');