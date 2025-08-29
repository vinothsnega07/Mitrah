USE exercise2

GO

--1
SELECT TaskName ,StartDate
FROM Task
ORDER BY StartDate

GO

--2
SELECT P.ProjectID,P.ProjectName, count(*) AS TaskCount
FROM Project P
join Task T ON P.ProjectID=T.ProjectID
group by P.ProjectID,P.ProjectName
ORDER BY TaskCount desc

GO

--3
SELECT P.ProjectName AS ProjectName,count(*) AS TotalNumberOfTasks,Sum(P.BudGet) AS TotalBudget 
FROM Project P
join Task T on P.ProjectID=T.ProjectID
GROUP BY  P.BudGet,P.ProjectName 
ORDER BY TotalBudget 

GO

--4
SELECT ProjectName,BudGet 
FROM Project
WHERE STATUS='In Progress' and BudGet between 10000 and 50000;

GO

--5
SELECT TaskName ,Status
FROM Task
WHERE year (StartDate) = 2024 and Status='completed'

GO

--6
SELECT TaskName ,Status ,StartDate,DueDate
FROM Task
WHERE Status='Pending' AND MONTH (DueDate)=MONTH(DATEADD(MONTH ,1,GETDATE()))

GO

--7
SELECT P.ProjectName,T.TaskName,T.Priority
FROM Project p
JOIN TASK T ON P.PROJECTID=T.PROJECTID
WHERE P.PROJECTNAME = 'WEBSITE REDESIGN' AND PRIORITY ='HIGH'

GO

--8
SELECT ProjectName
FROM Project
WHERE ProjectID IN
(SELECT ProjectID
FROM Task
WHERE DueDate < GETDATE() and Status!='completed');

GO

--9
SELECT *
FROM Task
WHERE ProjectID In 
(SELECT ProjectID
FROM Project
WHERE StartDate=
(SELECT max(StartDate)
FROM Project));

GO

--10
SELECT P.ProjectName,T.TaskName,T.Priority
FROM Project P,Task T
WHERE P.ProjectID = T.ProjectID AND T.Priority IN ('High','low')
AND P.ProjectID IN (SELECT ProjectID 
FROM Task WHERE Priority IN ('High','low')) 



GO

update Task set Priority='High'where TaskID=3
--11
SELECT TaskName
FROM Task
WHERE TaskName like 'Design%'

GO

--12
SELECT TaskName
FROM Task
WHERE TaskName like '%review%' and TaskName  not like 'pre%'

GO

--13
SELECT TaskName
FROM Task
WHERE TaskName like '[A-Ma-m]___'




SELECT P.ProjectName,P.ProjectID
FROM Project P
WHERE P.ProjectID IN (SELECT ProjectID
FROM Task WHERE Priority ='High' or Priority = 'Low')

select * from Task
select * from Project
select P.ProjectName,T.TaskName,T.Priority,P.ProjectID
From Project p , Task T
where p.ProjectID=1
Insert into Task values('Initial Design','Design Phase for Web',Null,null,'High','In Progress',1)