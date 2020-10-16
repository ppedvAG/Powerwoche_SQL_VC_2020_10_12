-- VIEWS
-- (Sichten)




CREATE VIEW v_Customers
AS
SELECT CustomerID, CompanyName
FROM Customers
GO



SELECT * 
FROM v_Customers


CREATE VIEW v_Customers_DE
AS
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, ContactTitle
		, Phone
FROM Customers
WHERE Country IN('Germany', 'Austria', 'Switzerland')
GO


SELECT ContactName, Phone
FROM v_Customers_DE


-- für Rechnung
CREATE VIEW v_Rechnung
AS
SELECT	  c.CustomerID
		, c.CompanyName
		, c.Address
		, o.OrderID
		, od.Quantity
		, p.ProductID
		, p.ProductName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
GO


SELECT	  CustomerID
		, OrderID
		, Quantity
		, ProductName
FROM v_Rechnung

-- Vorsicht!
-- Welche Abfrage passiert da im Hintergrund?
-- wenn ich alle Kunden will, stimmt das nicht!!
-- hiermit bekommen wir nur die, die schon etwas bestellt haben, weil in dieser VIEW v_Rechnung ein INNER JOIN gemacht wurde!
--SELECT DISTINCT	  CompanyName
--		, Address
--FROM v_Rechnung

