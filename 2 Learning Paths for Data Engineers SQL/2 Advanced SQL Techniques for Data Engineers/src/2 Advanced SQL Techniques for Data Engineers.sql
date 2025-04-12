--CTE
select * FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43659

select * FROM Sales.SalesOrderHeader
WHERE SalesOrderID = 43659

WITH SalesOrderDetails_CTE AS (
    SELECT SalesOrderID, SUM(LineTotal) AS TotalSalesAmount
    FROM Sales.SalesOrderDetail
    GROUP BY SalesOrderID
)
SELECT sod.SalesOrderID, soh.OrderDate, soh.ShipDate, soh.DueDate, sod.TotalSalesAmount
FROM SalesOrderDetails_CTE sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
AND sod.SalesOrderID = 43659

--Window Functions
Select * FROM Sales.SalesOrderHeader
WHERE CustomerID = 11000;

SELECT 
    SalesOrderID, 
    OrderDate, 
    TotalDue,
    SUM(TotalDue) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM 
    Sales.SalesOrderHeader
WHERE 
    CustomerID = 11000;

--Pivot 
    select * FROM [HumanResources].[Department]

    SELECT * FROM HumanResources.Employee

    select * FROM [HumanResources].[EmployeeDepartmentHistory]

SELECT 
    DepartmentID, 
    [2009], 
    [2010], 
    [2011]
FROM 
    (SELECT EDH.DepartmentID, YEAR(E.HireDate) AS HireYear, E.BusinessEntityID 
     FROM HumanResources.Employee E
     INNER JOIN 
     [HumanResources].[EmployeeDepartmentHistory] EDH
     ON EDH.BusinessEntityID = E.BusinessEntityID
     ) AS SourceTable
PIVOT 
    (COUNT(BusinessEntityID) FOR HireYear IN ([2009], [2010], [2011])) AS PivotTable;


--Unpivot
SELECT 
    DepartmentID, 
    HireYear, 
    EmployeeCount
FROM 
    (SELECT DepartmentID, [2009], [2010], [2011] 
     FROM 
     (SELECT EDH.DepartmentID, YEAR(EDH.StartDate) AS HireYear, COUNT(E.BusinessEntityID) AS EmployeeCount
      FROM HumanResources.Employee E
      INNER JOIN HumanResources.EmployeeDepartmentHistory EDH
      ON EDH.BusinessEntityID = E.BusinessEntityID
      GROUP BY EDH.DepartmentID, YEAR(EDH.StartDate)) AS SourceTable
     PIVOT 
     (SUM(EmployeeCount) FOR HireYear IN ([2009], [2010], [2011])) AS PivotTable) AS PivotTable
UNPIVOT 
    (EmployeeCount FOR HireYear IN ([2009], [2010], [2011])) AS UnpivotTable;
	

--Dynamic SQL with column selection & Filtering
DECLARE @Columns NVARCHAR(MAX);
DECLARE @SQL NVARCHAR(MAX);
DECLARE @Filter NVARCHAR(MAX);

-- Set the columns dynamically
SET @Columns = N'ProductNumber, Name, StandardCost';
SET @Filter  = N'LL Fork'

-- Construct the dynamic SQL query
SET @SQL = N'SELECT ' + @Columns + ' FROM Production.Product Where Name like ''%' + @Filter +'%''';

PRINT @SQL
-- Execute the dynamic SQL query
EXEC sp_executesql @SQL;

--Error Handling with TRY...CATCH
BEGIN TRY
    -- Generate a divide-by-zero error
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

--select 'Welcome to Azure Data Studio'