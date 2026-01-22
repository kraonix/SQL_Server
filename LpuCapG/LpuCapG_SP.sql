-- =============================================
-- Author:		Sachin
-- Create date: 22-01-2026
-- Description:	Insert into Department
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertIntoDepartment]
	@Id INT,
	@Name VARCHAR(50)
AS
BEGIN
	INSERT INTO [dbo].[DepartmentCapG] (Id, Name) VALUES 
		(@Id, @Name)
END
GO

-- =============================================
-- Author:		Sachin
-- Create date: 22-01-2026
-- Description:	Update into Department By ID
-- =============================================
ALTER PROCEDURE [dbo].[SP_UpdateIntoDepartment]
	@Id INT,
	@Name VARCHAR(50)
AS
BEGIN
	UPDATE DepartmentCapG SET Name = @Name WHERE id = @Id
END
GO



