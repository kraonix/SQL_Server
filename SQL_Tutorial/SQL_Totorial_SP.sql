-- =============================================
-- Author:		Sachim
-- Create date: 22-01-2026
-- Description:	Sample SP
-- =============================================
GO
CREATE PROCEDURE [dbo].[SP_GetCustomerByNameAndCity]
	-- Add the parameters for the stored procedure here
	@Name VARCHAR(100),
	@City VARCHAR(50)
AS
BEGIN
	SELECT * FROM [dbo].[Customers] WHERE FullName = @Name AND City = @City
END
GO

EXEC [dbo].[SP_GetCustomerByNameAndCity] 'Gopi Suresh', 'Coimbatore'