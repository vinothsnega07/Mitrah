USE exercise2

GO

CREATE OR ALTER TRIGGER trg_UpdateProjectStatus
ON PROJECT
AFTER UPDATE
AS
BEGIN
	BEGIN TRY
		UPDATE P
		SET P.Status='Completed'
		FROM Project P
		JOIN INSERTED I ON P.PROJECTID=I.PROJECTID
		WHERE I.ENDDATE IS NOT NULL;
		IF @@ROWCOUNT =0
			PRINT'Invalid Id'
		ELSE
			PRINT 'Status Are Updated'
	END TRY
	BEGIN CATCH
		PRINT 'Error '+ERROR_MESSAGE();
	END CATCH
END


GO

--Task Audit Table
DROP TABLE IF EXISTS TaskAudit

CREATE TABLE TaskAudit(
	AuditID INT IDENTITY(1,1),
	TaskID INT,
	OldTaskName VARCHAR(200),
	OldDescription VARCHAR(200),
	OldStartDate DATE,
	OldDueDate DATE,
	OldPriority VARCHAR(200),
	OldStatus VARCHAR(200),
	OldProjectID INT,
	ChangedON DateTime DEFAULT GETDATE()
	
);

GO

CREATE OR ALTER TRIGGER trg_AuditTaskChanges
ON Task
AFTER UPDATE
AS
BEGIN
	BEGIN TRY
		INSERT INTO TaskAudit(TaskID,OldTaskName,OldDescription,OldStartDate,OldDueDate,OldPriority,OldStatus,OldProjectID)
		SELECT 
			d.TaskID,
			d.TaskName,
			d.Description,
			d.StartDate,
			d.DueDate,
			d.Priority,
			d.Status,
			d.ProjectID
		FROM deleted d
		IF @@ROWCOUNT = 0
			PRINT 'Rows Are Not Updated'
		ELSE
			PRINT 'New Rows Are Inserted Sucessfully'
	END TRY
	BEGIN CATCH
		PRINT 'Error '+ERROR_MESSAGE()
	END CATCH
END


