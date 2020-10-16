-- Indices, Indizes, Indexe
-- indexes

-- clustered Index
-- verantwortlich für die physische Speicherung auf dem Datenträger
-- davon gibt es nur 1 pro Tabelle


-- nonclustered Index
-- theoretisch dürften wir 999 pro Tabelle haben
	-- zusammengesetzten Index (multicolumn index)
	-- Index mit eingeschlossenen Spalten (index with included columns)
	-- abdeckender Index (covering index)
	-- eindeutiger Index (unique index)
	-- gefilterter Index (filtered index)


	-- columnstore index



CREATE CLUSTERED INDEX IX_Orders_OrderID
ON Orders (OrderID)


-- CREATE NONCLUSTERED INDEX IX_Name
-- ON Tabelle (Spalte)


SET STATISTICS IO, TIME ON

SET STATISTICS IO, TIME OFF

SELECT CompanyName, City
FROM Customers
WHERE CustomerID LIKE '[a-c]%'



CREATE CLUSTERED INDEX IX_Customers_CustomerID
ON Customers (CustomerID)


SELECT Country, City
FROM Customers


-- CREATE NONCLUSTERED INDEX
-- ON Customers (Country, City)


SELECT  c.CustomerID
		, c.CompanyName
		, c.ContactName
		, c.ContactTitle
		, c.City
		, c.Country
		, o.EmployeeID
		, o.OrderDate
		, o.freight
		, o.shipcity
		, o.shipcountry
		, od.OrderID
		, od.ProductID
		, od.UnitPrice
		, od.Quantity
		, p.ProductName
		, e.LastName
		, e.FirstName
		, e.birthdate
into dbo.KundenUmsatz
FROM	Northwind.dbo.Customers c
		INNER JOIN Northwind.dbo.Orders o ON c.CustomerID = o.CustomerID
		INNER JOIN Northwind.dbo.Employees e ON o.EmployeeID = e.EmployeeID
		INNER JOIN Northwind.dbo.[Order Details] od ON o.orderid = od.orderid
		INNER JOIN Northwind.dbo.Products p ON od.productid = p.productid


INSERT INTO KundenUmsatz
SELECT * FROM KundenUmsatz
GO 9


SELECT COUNT(*) FROM KundenUmsatz

SELECT *
INTO KU2
FROM KundenUmsatz


ALTER TABLE KU2
ADD kid int IDENTITY



SET STATISTICS IO, TIME ON


SELECT kid
FROM KU2
WHERE kid = 1000

-- ohne Index: ~ 56.500 Seiten gelesen!!!
-- mit Index: 3 Seiten!!!


SELECT    kid
		, CompanyName
FROM KU2
WHERE kid = 1000

-- CompanyName ist Lookup (Heap) - so ähnlich wie Scan - nicht gut

-- neuer Index für diese Anforderung

SELECT	kid
		, CompanyName
		, Country
		, City
FROM KU2
WHERE kid = 1000









