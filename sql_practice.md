# SQL Practice Script (Customers & Orders)

## Drop existing tables

``` sql
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
```

## Create Tables

### Customers

``` sql
CREATE TABLE dbo.Customers
(
    CustomerId   INT PRIMARY KEY,
    FullName     VARCHAR(100) NOT NULL,
    City         VARCHAR(50)  NOT NULL,
    Segment      VARCHAR(20)  NOT NULL,
    IsActive     BIT          NOT NULL,
    CreatedOn    DATE         NOT NULL
);
```

### Orders

``` sql
CREATE TABLE dbo.Orders
(
    OrderId      INT PRIMARY KEY,
    CustomerId   INT NOT NULL,
    OrderDate    DATE NOT NULL,
    Amount       DECIMAL(10,2) NOT NULL,
    Status       VARCHAR(20) NOT NULL,
    PaymentMode  VARCHAR(20) NOT NULL,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerId) REFERENCES dbo.Customers(CustomerId)
);
```

## Insert Data

### Customers

``` sql
INSERT INTO dbo.Customers VALUES
(101, 'Gopi Suresh',   'Coimbatore', 'Retail',    1, '2025-11-12'),
(102, 'Anita Ravi',    'Chennai',    'Corporate', 1, '2025-10-05'),
(103, 'Karthik Mohan', 'Bengaluru',  'Retail',    1, '2025-09-15'),
(104, 'Meena Kumar',   'Chennai',    'Retail',    0, '2024-12-20'),
(105, 'Suresh Babu',   'Hyderabad',  'Corporate', 1, '2025-01-10');
```

### Orders

``` sql
INSERT INTO dbo.Orders VALUES
(5001, 101, '2026-01-10', 1200.00, 'Delivered', 'UPI'),
(5002, 101, '2026-01-15',  850.00, 'Pending',   'Card'),
(5003, 102, '2026-01-05', 5000.00, 'Delivered', 'Card'),
(5004, 103, '2025-12-30',  300.00, 'Cancelled', 'Cash'),
(5005, 105, '2026-01-18', 2500.00, 'Delivered', 'UPI'),
(5006, 102, '2026-01-20', 1500.00, 'Pending',   'UPI');
```

## Query Examples

### Basic Select

``` sql
SELECT * FROM Customers;
SELECT CustomerId, FullName, City FROM dbo.Customers;
SELECT DISTINCT City FROM dbo.Customers;
```

### Filtering

``` sql
SELECT * FROM dbo.Customers WHERE City = 'Chennai';
SELECT * FROM dbo.Orders WHERE Status = 'Delivered' AND PaymentMode = 'UPI';
SELECT * FROM dbo.Customers WHERE City IN ('Chennai', 'Coimbatore');
SELECT * FROM dbo.Orders WHERE Amount BETWEEN 800 AND 3000;
SELECT * FROM dbo.Customers WHERE FullName LIKE 'S%';
```

### Sorting & Limiting

``` sql
SELECT * FROM dbo.Orders ORDER BY Amount DESC;
SELECT TOP 3 * FROM dbo.Orders ORDER BY Amount DESC;
SELECT * FROM dbo.Orders ORDER BY OrderDate DESC OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;
```

### Aggregates

``` sql
SELECT Status, COUNT(*) AS TotalOrders, SUM(Amount) AS TotalAmount
FROM dbo.Orders GROUP BY Status;
```

### Joins

``` sql
SELECT c.FullName, o.OrderId, o.Amount
FROM dbo.Customers c
INNER JOIN dbo.Orders o ON c.CustomerId = o.CustomerId;
```

### Subqueries & CTE

``` sql
SELECT * FROM dbo.Customers WHERE CustomerId IN (
    SELECT CustomerId FROM dbo.Orders WHERE Status = 'Delivered'
);

WITH BigOrders AS (
    SELECT * FROM dbo.Orders WHERE Amount >= 2000
)
SELECT * FROM BigOrders;
```
