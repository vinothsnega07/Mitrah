USE exercise2

GO

DROP TABLE IF EXISTS #LocalTempTable

GO

CREATE TABLE #LocalTempTable(
ID INT IDENTITY(1,1),
Name NVARCHAR(100),
StartDate DATE,
Priority NVARCHAR(20)
);

GO

INSERT INTO #LocalTempTable(Name,StartDate,Priority) 

SELECT TaskName,StartDate,Priority 
FROM Task 
WHERE Priority='low'

SELECT * FROM #LocalTempTable

DROP TABLE IF EXISTS ##GlobalTempTable

GO

CREATE TABLE ##GlobalTempTable(
ID INT IDENTITY(1,1),
ProjectName VARCHAR(100),
BudGet DECIMAL(18,2),
Priority NVARCHAR(20)
);

GO

INSERT INTO ##GlobalTempTable(ProjectName,BudGet,Priority) 

SELECT P.ProjectName,P.BudGet,T.Priority
FROM Project P
JOIN Task T ON P.ProjectID=T.ProjectID
WHERE Priority='medium';

GO

SELECT * FROM ##GlobalTempTable

GO

DECLARE @TableVariable AS Table(
TaskID INT IDENTITY(1,1),
TaskName VARCHAR(100),
DueDate DATE,
Priority NVARCHAR(20)
);

INSERT INTO @TableVariable(TaskName,DueDate,Priority)

SELECT TaskName,DueDate,Priority
FROM Task
WHERE Priority='high'

SELECT * FROM @TableVariable