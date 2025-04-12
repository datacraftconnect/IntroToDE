--Select
SELECT * FROM [Sales].[Customer]

--Filtering Data
SELECT * FROM [Sales].[SalesOrderHeader]  WHERE OrderDate > '2014-06-29 00:00:00.000'

--Sorting and Limiting Results
SELECT TOP 10 * FROM [Production].[Product] ORDER BY ListPrice DESC

--Joining Tables
SELECT p.BusinessEntityID, p.FirstName, p.LastName, soh.OrderDate
FROM Person.Person p
INNER JOIN Sales.SalesOrderHeader soh ON p.BusinessEntityID = soh.CustomerID;

--Aggregating Data
SELECT ProductID, COUNT(*) AS OrderCount FROM [Sales].[SalesOrderDetail]  GROUP BY ProductID;

--Data Insertion
INSERT INTO [Production].[Product]  (Name, ProductNumber, ListPrice)
VALUES ('New Product', 'NP-001', 99.99);

Select * FROM [Production].[Product]
WHERE [Name] = 'New Product'

--Data Updation
Select * FROM [Production].[Product]
WHERE ProductID = 1

UPDATE [Production].[Product] SET ListPrice = 89.99 WHERE ProductID = 1;

Select * FROM [Production].[Product]
WHERE ProductID = 1

--Data Deletion
DELETE FROM [Production].[Product] WHERE ProductID = 1;

Select * FROM [Production].[Product]
WHERE ProductID = 1