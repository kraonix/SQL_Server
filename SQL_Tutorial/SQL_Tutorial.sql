-- Drop if already exists (safe rerun)
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;


-- Customers table
CREATE TABLE dbo.Customers
(
    CustomerId   INT PRIMARY KEY,
    FullName     VARCHAR(100) NOT NULL,
    City         VARCHAR(50)  NOT NULL,
    Segment      VARCHAR(20)  NOT NULL,   -- Retail / Corporate
    IsActive     BIT          NOT NULL,
    CreatedOn    DATE         NOT NULL
);

-- Orders table
CREATE TABLE dbo.Orders
(
    OrderId      INT PRIMARY KEY,
    CustomerId   INT NOT NULL,
    OrderDate    DATE NOT NULL,
    Amount       DECIMAL(10,2) NOT NULL,
    Status       VARCHAR(20) NOT NULL,    -- Delivered/Cancelled/Pending
    PaymentMode  VARCHAR(20) NOT NULL,    -- UPI/Card/Cash
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerId) REFERENCES dbo.Customers(CustomerId)
);


-- Insert Customers
INSERT INTO dbo.Customers (CustomerId, FullName, City, Segment, IsActive, CreatedOn) VALUES
(101, 'Gopi Suresh',   'Coimbatore', 'Retail',    1, '2025-11-12'),
(102, 'Anita Ravi',    'Chennai',    'Corporate', 1, '2025-10-05'),
(103, 'Karthik Mohan', 'Bengaluru',  'Retail',    1, '2025-09-15'),
(104, 'Meena Kumar',   'Chennai',    'Retail',    0, '2024-12-20'),
(105, 'Suresh Babu',   'Hyderabad',  'Corporate', 1, '2025-01-10');


-- Insert Orders
INSERT INTO dbo.Orders (OrderId, CustomerId, OrderDate, Amount, Status, PaymentMode) VALUES
(5001, 101, '2026-01-10', 1200.00, 'Delivered', 'UPI'),
(5002, 101, '2026-01-15',  850.00, 'Pending',   'Card'),
(5003, 102, '2026-01-05', 5000.00, 'Delivered', 'Card'),
(5004, 103, '2025-12-30',  300.00, 'Cancelled', 'Cash'),
(5005, 105, '2026-01-18', 2500.00, 'Delivered', 'UPI'),
(5006, 102, '2026-01-20', 1500.00, 'Pending',   'UPI');


--SELECT * (All Columns)
SELECT * FROM Customers;

--SELECT specific columns
SELECT CustomerId, FullName, City FROM dbo.Customers;

--SELECT DISTINCT
SELECT DISTINCT City FROM dbo.Customers;

--Column Alias (AS)
SELECT FullName AS CustomerName, City AS CustomerCity FROM dbo.Customers;

--WHERE (Filter rows)
SELECT * FROM dbo.Customers WHERE City = 'Chennai';

--WHERE with AND / OR
SELECT * FROM dbo.Orders WHERE Status = 'Delivered' AND PaymentMode = 'UPI';

--IN (Match a list)
SELECT * FROM dbo.Customers WHERE City IN ('Chennai', 'Coimbatore');

--BETWEEN (Range)
SELECT * FROM dbo.Orders WHERE Amount BETWEEN 800 AND 3000;

--LIKE (Pattern search)
SELECT * FROM dbo.Customers WHERE FullName LIKE 'S%';

--ORDER BY (Sorting)
SELECT * FROM dbo.Orders ORDER BY Amount DESC;

--TOP (Limit rows)
SELECT TOP 3 * FROM dbo.Orders ORDER BY Amount DESC;

--OFFSET-FETCH (Pagination)
SELECT * FROM dbo.Orders ORDER BY OrderDate DESC OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

--GROUP BY + Aggregates
SELECT Status, COUNT(*) AS TotalOrders, SUM(Amount) AS TotalAmount FROM dbo.Orders GROUP BY Status;

--HAVING (Filter grouped result)
SELECT CustomerId, SUM(Amount) AS TotalSpent FROM dbo.Orders GROUP BY CustomerId HAVING SUM(Amount) > 2000;

--INNER JOIN (Combine tables)
SELECT c.FullName, o.OrderId, o.Amount, o.Status FROM dbo.Customers c INNER JOIN dbo.Orders o ON c.CustomerId = o.CustomerId;

--LEFT JOIN (Keep all from left)
SELECT c.FullName, o.OrderId, o.Status FROM dbo.Customers c LEFT JOIN dbo.Orders o ON c.CustomerId = o.CustomerId;

--Subquery (IN)
SELECT * FROM dbo.Customers WHERE CustomerId IN (
    SELECT CustomerId FROM dbo.Orders WHERE Status = 'Delivered'
);

--CASE (Conditional column)
SELECT OrderId, Amount,
       CASE 
           WHEN Amount >= 3000 THEN 'High'
           WHEN Amount >= 1000 THEN 'Medium'
           ELSE 'Low'
       END AS OrderSize
FROM dbo.Orders;

--EXISTS (Check presence)
SELECT c.CustomerId, c.FullName FROM dbo.Customers c WHERE EXISTS (
    SELECT 1 FROM dbo.Orders o WHERE o.CustomerId = c.CustomerId AND o.Status = 'Pending'
);

--UNION (Combine result sets)
SELECT City FROM dbo.Customers WHERE City = 'Chennai'
UNION
SELECT City FROM dbo.Customers WHERE City = 'Coimbatore';

--SELECT INTO (Create a new table from SELECT)
SELECT * INTO dbo.DeliveredOrders FROM dbo.Orders WHERE Status = 'Delivered';

--Common Table Expression (CTE)
WITH BigOrders AS (
    SELECT OrderId, CustomerId, Amount FROM dbo.Orders WHERE Amount >= 2000
)
SELECT * FROM BigOrders;


--22/01/26
GO
CREATE PROCEDURE dbo.MyPractice
    @City VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM dbo.customers
    WHERE city = @City;
END
GO


ALTER PROCEDURE dbo.MyPractice
    @City VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM dbo.customers
    WHERE city = @City;
END
GO

EXEC dbo.MyPractice 'Delhi';