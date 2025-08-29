USE exercise2

GO

CREATE OR ALTER VIEW vw_ActiveProjects 
AS
SELECT *
FROM Project
WHERE EndDate IS NULL

GO

CREATE OR ALTER VIEW vw_HighPriorityTasks
AS
SELECT *
FROM Task
WHERE Priority ='High'

GO

--Cursor
CREATE OR ALTER PROCEDURE ActiveProjectList
AS
BEGIN
	Declare 
	@ProjectName VARCHAR(200)

	--Declare Cursor For Active Projects
	Declare active_Project CURSOR FOR
	SELECT ProjectName
	FROM Project
	WHERE EndDate IS NULL

	--Open The Cursor
	OPEN active_Project 

	--Fetch First Row
	FETCH NEXT FROM active_Project INTO @ProjectName

	--Loop To Display result
	WHILE @@FETCH_STATUS =0
	BEGIN
		PRINT 'Active Projects'+@ProjectName
		SELECT ProjectName
		FROM Project
		WHERE EndDate IS NULL
		FETCH NEXT FROM active_Project INTO @ProjectName
	END

	CLOSE active_Project
	DEALLOCATE active_Project
END

EXEC ActiveProjectList

GO
-- Second Cursor
CREATE OR ALTER PROCEDURE UpdateOverDueTasks
AS
BEGIN
	BEGIN TRY
		DECLARE
			@TaskID INT,
			@TaskName VARCHAR(200),
			@DueDate DATE,
			@Status VARCHAR(200)

			--Declare Cursor
			DECLARE update_OverDue CURSOR FOR
			SELECT TaskID,TaskName,DueDate,Status
			FROM Task

			--Open Cursor
			OPEN update_OverDue

			FETCH NEXT FROM update_OverDue INTO @TaskID,@TaskName,@DueDate,@Status

			WHILE @@FETCH_STATUS=0
			BEGIN
				IF @DueDate IS NOT NULL AND @DueDate < CAST(GETDATE() AS DATE) AND @Status NOT IN ('Completed','OverDue')
				BEGIN
					UPDATE Task
					SET Status='OverDue'
					Where TaskID=@TaskID
				END
				FETCH NEXT FROM update_OverDue INTO @TaskID,@TaskName,@DueDate,@Status
			END
			CLOSE update_OverDue
			DEALLOCATE update_OverDue
		END TRY
		BEGIN CATCH
			PRINT 'Error '+ERROR_MESSAGE();
		END CATCH
END


EXEC UpdateOverDueTasks
