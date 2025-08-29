Use exercise2;

GO

CREATE OR ALTER PROCEDURE TaskSP
	@Action VARCHAR(20),
	@TaskID INT =null,
	@TaskName VARCHAR(200)=null,
	@Description VARCHAR(200)=null,
	@StartDate Date=null,
	@DueDate Date=null,
	@Priority VARCHAR(200)=null,
	@Status VARCHAR(200)=null,
	@ProjectID INT=null
	AS
	BEGIN

		BEGIN TRY
		--Insert
			IF UPPER(@Action) = 'INSERT'	
			BEGIN
				IF (@TaskName IS NOT NULL AND @TaskName='')
					PRINT 'TaskName Should Not Contain Null OR Empty Values'
				ELSE IF (@Priority NOT IN ('High','low','Medium'))
					PRINT 'Priority Will Be Allowed High OR Low OR Medium Only These Values Are Allowed'
				ELSE IF (@StartDate > @DueDate) 
					PRINT 'StartDate Must Lesser Than Due Date'
				ELSE IF(@ProjectID='')
					PRINT 'Enter Correct ProjectID'
				ELSE
					BEGIN
						INSERT INTO Task (TaskName,Description,StartDate,DueDate,Priority,Status,ProjectID) 
						VALUES (@TaskName,@Description,@StartDate,@DueDate,@Priority,@Status,@ProjectID);
						PRINT 'Data Inserted Sucessfully'
					END
			END

			

		--Update
			ELSE IF UPPER(@Action)='UPDATE'
			BEGIN
				IF (@TaskName IS NOT NULL AND @TaskName='')
					PRINT 'TaskName Should Not Contain Null OR Empty Values'
				ELSE IF (@Priority NOT IN ('High','low','Medium'))
					PRINT 'Priority Will Be Allowed High OR Low OR Medium Only These Values Are Allowed'
				ELSE IF (@StartDate > @DueDate) 
					PRINT 'StartDate Must Lesser Than Due Date'
				ELSE IF(@ProjectID='' OR @TaskID='')
					PRINT 'Enter Correct ProjectID Or TaskID To Update'
				ELSE
					BEGIN
						IF EXISTS (SELECT * FROM Task WHERE TaskID=@TaskID)
						UPDATE Task 
						Set TaskName=@TaskName,
						Description=@Description,
						StartDate=@StartDate,
						DueDate=@DueDate,
						[Priority]=@Priority,
						Status=@Status,
						ProjectID=@ProjectID
						WHERE TaskID=@TaskID
						PRINT 'Updated Sucessfully'
					END
				
			END

		--Delete 
			ELSE IF UPPER(@Action)='DELETE'
			BEGIN
				IF EXISTS (SELECT * FROM Task WHERE TaskID=@TaskID)
				BEGIN
					DELETE FROM Task
					WHERE TaskID=@TaskID
					PRINT'Data Will Be Deleted Sucessfully'
				END
				ELSE
					BEGIN
						PRINT 'Deletion Will Be Not Found'
					END
			END


		--Select
			ELSE IF UPPER(@Action)='SELECT'
			BEGIN
				IF @TaskID IS NULL
					SELECT * FROM TASK
				ELSE
				BEGIN
					SELECT * FROM Task WHERE TaskID=@TaskID
				END
			END
		END TRY
		BEGIN CATCH
			PRINT'Error Message '+ERROR_Message()
		END CATCH
	END


	--Insert
	EXEC TaskSP
	@Action='INSERT',
	@TaskName='h',
	@Description='Conducting Alpha Testing For Mobile App',
	@StartDate='2024-05-05',
	@DueDate='2024-06-06',
	@Priority='High',
	@Status='',
	@ProjectID=3

	--Update
	EXEC TaskSP
	@Action='UPDATE',
	@TaskName='Quality',
	@Description='Quality testing',
	@StartDate='2024-05-05',
	@DueDate='2024-08-05',
	@Priority='Low',
	@Status='',
	@ProjectID=2,
	@TaskID=''


	--Delete
	EXEC TaskSP
	@Action='Delete',
	@TaskID=110

	--Select
	EXEC TaskSP
	@Action='SELECT'

	EXEC TaskSP
	@Action ='SELECT' ,@TaskID=1
	
GO

CREATE OR ALTER FUNCTION getAllData_ByID (@TaskID INT)
RETURNS TABLE
AS
RETURN
(
	SELECT * FROM Task
	WHERE (@TaskID IS NULL OR TaskID=@TaskID)

);


