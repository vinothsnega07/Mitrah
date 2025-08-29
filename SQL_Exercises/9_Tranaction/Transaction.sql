USE exercise2

GO

BEGIN TRY
	BEGIN TRANSACTION
	DECLARE @NewProjectID INT
	INSERT INTO Project(ProjectName,StartDate,EndDate,BudGet,Status,ParentProjectId)
	Values('Digital Marketing',GETDATE(),Null,'20000','In Proigress',Null);

	SET @NewProjectID=SCOPE_IDENTITY();

	INSERT INTO Task(ProjectID, TaskName,Description,StartDate,DueDate,Priority,Status)
	VALUES(@NewProjectID,'API Intagration','How To Integrate API','2025-8-20','2025-10-20','Low','In Progress'),
	(@NewProjectID,'BackEnd','Logics','2025-7-20','2025-8-26','Low','In Progress'),
	(@NewProjectID,'Research','Research Operations','2025-9-28','2025-10-28','Medium','In Progress');

	COMMIT
		PRINT 'Transaction Sucessful'
END TRY
BEGIN CATCH
	ROLLBACK
	PRINT'Transaction Failed'
	PRINT ERROR_MESSAGE();
END CATCH;

--Second Transaction
BEGIN TRY
	BEGIN TRANSACTION
	 DECLARE @TargetProjectID INT=1;
	 DECLARE @NewBudGet DECIMAL(10,2)=30000;

	 UPDATE Project
	 SET BudGet=@NewBudGet
	 WHERE ProjectID=@TargetProjectID

	 --Update priority of all associated task
	 UPDATE Task
	 SET Priority='Low'
	 WHERE ProjectID=@TargetProjectID

	 COMMIT
	 PRINT 'Budget And Task Priority Updated Sucessfully'
END TRY
BEGIN CATCH
ROLLBACK
PRINT 'Transaction Failed All Changes Are Rollback'
PRINT ERROR_MESSAGE();
END CATCH

GO

--Third Transaction
CREATE OR ALTER PROCEDURE CrudTransaction
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
			BEGIN TRANSACTION
		--Insert
			IF UPPER(@Action) = 'INSERT'	
			BEGIN
				INSERT INTO Task (TaskName,Description,StartDate,DueDate,Priority,Status,ProjectID) 
				VALUES (@TaskName,@Description,@StartDate,@DueDate,@Priority,@Status,@ProjectID);
				PRINT 'Data Inserted Sucessfully'
			END


		--Update
			ELSE IF UPPER(@Action)='UPDATE'
			BEGIN
				IF EXISTS (SELECT * FROM Task WHERE TaskID=@TaskID)
				BEGIN
					Update Task 
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
				ELSE
					BEGIN
						PRINT 'Updated Data Not Found'
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
					PRINT  'Invalid ID'
				END
			END
			COMMIT
			
		END TRY
		BEGIN CATCH
			ROLLBACK;
			PRINT 'All Crud Transactions Are Rolled Back'
			PRINT'Error Message '+ERROR_Message()
		END CATCH
	END


	--Insert
	EXEC CrudTransaction
	@Action='INSERT',
	@TaskName='Alp',
	@Description='Conducting Alpha Testing For Mobile App',
	@StartDate='2024-06-05',
	@DueDate='2024-07-05',
	@Priority='High',
	@Status='Pending',
	@ProjectID=2

	--Update
	EXEC CrudTransaction
	@Action='Update',
	@TaskName='Alpha',
	@Description='Conduct alpha testing',
	@StartDate='2024-07-05',
	@DueDate='2024-08-05',
	@Priority='Low',
	@Status='Not Started',
	@ProjectID=3,
	@TaskID=12


	--Delete
	EXEC CrudTransaction
	@Action='Delete',
	@TaskID=19

	--Select
	EXEC CrudTransaction
	@Action='SELECT'

	EXEC CrudTransaction
	@Action ='SELECT' ,@TaskID=102


