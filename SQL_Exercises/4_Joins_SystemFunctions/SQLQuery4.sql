USE exercise2

GO

--1
SELECT *
FROM Task T
join Project P ON P.ProjectID=T.ProjectID

GO

--2
SELECT P.*,T.TaskName,T.StartDate,T.DueDate
FROM Project P
LEFT JOIN Task T ON P.ProjectID=T.ProjectID

GO

--3
SELECT t.*,P.ProjectName,P.StartDate,P.EndDate
FROM Task T
RIGHT JOIN Project P ON P.ProjectID=T.ProjectID

GO


--4
ALTER TABLE Project
ADD ParentProjectId INT NULL

UPDATE Project
SET ParentProjectID=4
WHERE ProjectID=5

SELECT Parent.ProjectID AS ParentProjectID,
Parent.ProjectName AS ParentProjectName,
Child.ProjectID AS ChildProjectID,
Child.ProjectName AS ChildProjectName
FROM Project Child
JOIN Project Parent ON  Parent.ProjectID= Child.ParentProjectId


GO

--5
SELECT GETDATE() AS 'CurrentDateTime'
SELECT CURRENT_TIMESTAMP AS 'CurrentTimeStamp'

GO

--6
SELECT ProjectName,
YEAR (StartDate) AS Year,
MONTH(StartDate) AS Month_Number,
DATENAME(MONTH,StartDate) as Month_Name,
DAY(StartDate) AS Date,
DATENAME(WEEKDAY,StartDate) as Day_Name
FROM Project;

GO

--7
SELECT ProjectName,
DATEDIFF (DAY,StartDate,EndDate) AS DuratiONDays
FROM Project

GO

--8
SELECT ProjectName,CONVERT(varchar,StartDate,23) AS Formatted_Date
FROM Project

GO

--9
SELECT P.ProjectName,T.TASkName
FROM Project P
cross apply(
SELECT TASkName
FROM TASk T
where P.ProjectID=T.ProjectID
)T;



WITH RecursiveOrganizationCTE AS
(
    SELECT ProjectID, ProjectName, StartDate, EndDate,BudGet,Status,ParentProjectId
    FROM Project
    WHERE ParentProjectID IS NULL
    UNION ALL
   
    SELECT P.ProjectID, P.ProjectName, P.StartDate, P.EndDate,P.BudGet,P.Status,P.ParentProjectId
    FROM Project P
    JOIN RecursiveOrganizationCTE r ON P.ParentProjectID = r.ProjectID
)
SELECT * FROM RecursiveOrganizationCTE;


--Recrusive

