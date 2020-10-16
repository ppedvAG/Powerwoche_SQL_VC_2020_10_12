-- WH


SELECT 'Testtext'

SELECT DATEDIFF(dd, RequiredDate, ShippedDate)
FROM Orders

SELECT DATEADD(hh, 10, GETDATE()) -- 2020-10-14 19:20:25.703

SELECT DATEADD(hh, -10, GETDATE()) -- 2020-10-13 23:21:06.327


SELECT DATEPART(dd, GETDATE()) -- 14

SELECT DATEPART(dw, GETDATE()) -- 4


SELECT DATENAME(dd, GETDATE()) -- 14

SELECT DATENAME(dw, GETDATE()) -- Wednesday
SELECT DATENAME(month, GETDATE()) -- October

SELECT CONCAT('a', 'b', 'cde') -- abcde

SELECT CONCAT(FirstName, ' ', LastName)
FROM Employees


SELECT CAST('123.5' AS float) + 2

-- mit DB:
SELECT CAST(Freight AS varchar) + 2
FROM Orders
-- Achtung: wenn wir einen numerischen Datentyp in einen String-Datentyp umwandeln, können wir damit nicht weiterrechnen!


-- Convert kann das auch, aber andere Syntax:
SELECT CONVERT(float, '123.5') + 2

-- Convert kann nicht nur konvertieren, sondern über den Style-Parameter auch Datum in einem bestimmten Format ausgeben:

SELECT CONVERT(varchar, GETDATE(), 104) -- 14.10.2020

--101 - US
--103 - GB
--104 - DE

SELECT CONVERT(varchar, BirthDate, 104)
FROM Employees

--SELECT BirthDate
--FROM Employees


SELECT FORMAT(GETDATE(), 'd', 'de-de') -- 14.10.2020

SELECT FORMAT(GETDATE(), 'D', 'de-de') -- Mittwoch, 14. Oktober 2020


-- Bestellung:
-- Wo soll hingeliefert werden?
-- OrderID, RequiredDate, CustomerID, CompanyName, Address, City, Country
SELECT	  o.OrderID
		, FORMAT(o.RequiredDate, 'd', 'de-de')
		, o.CustomerID
		, c.CompanyName
		, c.Address
		, c.City
		, c.Country
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


-- Angenommen, es gab Beschwerden bei den Bestellungen 10251, 10280, 10990 und 11000.
-- Welche Angestellten haben diese Bestellungen bearbeitet? (Name)
-- Vor- und Nachname in einem Feld als FullName

-- wie komme ich an die Bestellungen mit diesen Nummern?
SELECT OrderID
FROM Orders
WHERE OrderID IN(10251, 10280, 10990, 11000)


-- wie finden wir heraus, welche Employees?
SELECT EmployeeID
FROM Orders
WHERE OrderID IN(10251, 10280, 10990, 11000) -- 3, 2


-- wer sind diese Angestellten?
SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID IN (2, 3)


-- wie füge ich Informationen aus mehreren Spalten zusammen?
SELECT CONCAT (FirstName, ' ', LastName)
FROM Employees



SELECT	  o.OrderID
		, o.EmployeeID
		, CONCAT (e.FirstName, ' ', e.LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.OrderID IN(10251, 10280, 10990, 11000)


-- JOINS von mehreren Tabellen
/*
	SELECT	  Spalte
			, Spalte
			, Spalte
	--		, ...
	FROM Tabelle1 t1 INNER JOIN Tabelle2 t2 ON t1.Spalte = t2.Spalte
					 INNER JOIN Tabelle3 t3 ON t2.Spalte = t3.Spalte
					 INNER JOIN Tabelle4 t4 ON t4.Spalte = t1.Spalte

	-- Tabelle muss nicht unbedingt an die vorhergehende "anschließen"
	-- Wir müssen über Tabellen joinen, die auch tatsächlich verknüpft sind

*/



-- Wer ist der Chef von wem?
-- Ausgabe:
-- Name Angesteller, ID Angestellter, Name Chef, ID Chef

SELECT	  emp.LastName AS Angestellter
		, emp.EmployeeID AS EmpID
		, chef.LastName AS Chef
		, chef.EmployeeID AS ChefID
FROM Employees emp INNER JOIN Employees chef ON emp.ReportsTo = chef.EmployeeID
ORDER BY ChefID



SELECT	  emp.LastName AS Angestellter
		, emp.EmployeeID AS EmpID
		, chef.LastName AS Chef
		, chef.EmployeeID AS ChefID
FROM Employees emp LEFT JOIN Employees chef ON emp.ReportsTo = chef.EmployeeID
ORDER BY ChefID
-- mit LEFT JOIN stehen auch die dabei, die (noch) keinen Vorgesetzten haben
-- im Fall von der Northwind DB ist das der (Firmen-)Chef



-- Fahrgemeinschaften-Übung:
-- Customer1, City1, Customer2, City2
SELECT	  a.CustomerID
		, a.City
		, b.CustomerID
		, b.City
FROM Customers a INNER JOIN Customers b ON a.City = b.City
WHERE a.CustomerID != b.CustomerID
ORDER BY a.City


