USE exercise2

GO


ALTER TABLE Project
ADD DESCRIPTION VARCHAR(200) Not Null DEFAULT ''

GO

EXEC sp_rename 'Project.description', 'ProjectDescription', 'COLUMN'

GO

ALTER TABLE Project 
ALTER COLUMN ProjectDescription VARCHAR(200)  null;



