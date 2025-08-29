
CREATE DATABASE exercise2

GO

USE exercise2

GO

DROP TABLE IF EXISTS Project

GO

CREATE TABLE Project(
	ProjectID INT IDENTITY(1,1) PRIMARY KEY,
	ProjectName varchar(200) UNIQUE,
	StartDate DATE,
	EndDate DATE,
	BudGet DECIMAL(10, 2),
	Status VARCHAR(200) DEFAULT 'Not Started',
	CHECK (EndDate > StartDate)
);

GO

CREATE TABLE Task(
	TaskID INT IDENTITY(1,1) PRIMARY KEY,
	TaskName varchar(200) unique,
	Description varchar(200),
	StartDate DATE,
	DueDate DATE,
	Priority VARCHAR(200),
	Status VARCHAR(200)  DEFAULT 'Pending',
	CHECK (DueDate > StartDate),
	ProjectID int,
	FOREIGN KEY(ProjectID)REFERENCES Project(ProjectID),
	CHECK (Priority ='High' OR  Priority ='Medium' OR  Priority ='Low')
);

GO

INSERT INTO Project (ProjectName, StartDate, EndDate, Budget, Status)
VALUES 
	('Website Redesign', '2024-01-01', '2024-06-30', 15000.00, 'In Progress'),
	('Mobile App Development', '2024-02-15', '2024-07-15', 25000.00, 'Not Started'),
    ('Market Research', '2024-03-01', '2024-05-31', 10000.00, 'Completed'),
    ('Annual Report Preparation', '2024-04-01', '2024-12-31', 12000.00, 'In Progress');

GO

INSERT INTO Task (TaskName, Description, StartDate, DueDate, Priority, Status, ProjectID)
VALUES 
    ('Initial Design', 'Design phase for the new website', '2024-01-02', '2024-02-28', 'High', 'Completed', 1),
    ('UI Development', 'Development of user interface components', '2024-03-01', '2024-05-15', 'Medium', 'In Progress', 1),
    ('Quality Assurance', 'Testing and quality assurance', '2024-05-16', '2024-06-15', 'High', 'Pending', 1),
    ('API Development', 'Developing APIs for the mobile app', '2024-02-16', '2024-04-30', 'Medium', 'Completed', 2),
    ('Beta Testing', 'Conducting beta testing for the mobile app', '2024-05-01', '2024-06-30', 'High', 'In Progress', 2),
    ('Survey Analysis', 'Analyzing market research surveys', '2024-03-02', '2024-04-15', 'Low', 'Completed', 3),
    ('Report Drafting', 'Drafting the final report based on research', '2024-04-16', '2024-05-30', 'Medium', 'Pending', 3),
    ('Financial Statements', 'Preparing financial statements for the annual report', '2024-04-02', '2024-07-15', 'High', 'In Progress', 4),
    ('Final Review', 'Final review and submission of the annual report', '2024-07-16', '2024-12-15', 'High', 'Pending', 4),
    ('Client Feedback Incorporation', 'Incorporating feedback from the client into the project', '2024-02-01', '2024-03-15', 'Medium', 'In Progress', 1),
    ('Launch Preparation', 'Preparing for the official launch of the mobile app', '2024-06-01', '2024-07-01', 'High', 'Pending', 2);


