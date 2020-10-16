-- Procedures (Prozeduren)



CREATE PROC p_Demo
AS
SELECT TOP 1 * FROM Orders ORDER BY Freight
SELECT TOP 1 * FROM Orders ORDER BY Freight DESC
SELECT Country FROM Customers WHERE Region IS NOT NULL
GO


-- aufrufen mit EXEC (execute - ausführen)
EXEC p_Demo



CREATE PROC p_Customers_Cities @City varchar(30)
AS
SELECT * FROM Customers WHERE City = @City
GO


EXEC p_Customers_Cities @City = 'Buenos Aires'




CREATE PROC p_Customers_City_Country @City varchar(30), @Country varchar(30)
AS
SELECT    CustomerID
		, CompanyName
		, ContactName
		, City
		, Country
		, Phone 
FROM Customers
WHERE City = @City AND Country = @Country
GO

-- drop proc p_Customers_City_Country

EXEC p_Customers_City_Country @City = 'Berlin', @Country = 'Germany'
