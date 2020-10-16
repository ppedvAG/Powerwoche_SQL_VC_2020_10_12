-- WHERE clause, WHERE-Klausel, WHERE Bedingung
-- einschränken, welche Ergebnisse zurückgegeben werden sollen


/*
	WHERE Operatoren

		=, <, >, <=, >=

		!=, <> ....... darf NICHT einem bestimmten Wert entsprechen


		AND - es müssen zwingend alle Bedingungen erfüllt sein
		OR - mindestens eine von den beiden Bedingungen muss erfüllt sein

		IN, BETWEEN

		LIKE

		IS, IS NOT



*/






-- alle Spalten und Zeilen aus der Customers Tabelle
SELECT *
FROM Customers


-- einschränken: nur die deutschen Kunden
SELECT *
FROM Customers
WHERE Country = 'Germany'


-- bestimmte Spalten von den deutschen Kunden
SELECT	  CustomerID
		, CompanyName
		, ContactName
FROM Customers
WHERE Country = 'Germany'




SELECT	  CustomerID
		, CompanyName
		, ContactName
FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'


-- alle deutschsprachigen Kunden
SELECT	  CustomerID
		, CompanyName
		, ContactName
FROM Customers
WHERE Country = 'Germany' 
	OR Country = 'Austria' 
	OR Country = 'Switzerland'


SELECT *
FROM Orders
WHERE Freight != 148.33


-- alle Kunden aus Frankreich
SELECT *
FROM Customers
WHERE Country = 'France'


-- alle Kunden aus Buenos Aires in Argentinien
SELECT *
FROM Customers
WHERE Country = 'Argentina' AND City = 'Buenos Aires'


-- Gib alle portugiesischen und spanischen Kunden aus.
SELECT *
FROM Customers
WHERE Country = 'Portugal' OR Country = 'Spain'


-- Gib alle Produkte aus, von denen mehr als 100 vorhanden sind.
SELECT *
FROM Products
WHERE UnitsInStock > 100




-- *************************************** IN ****************************************

-- alle deutschsprachigen Kunden
SELECT	  CustomerID
		, CompanyName
		, ContactName
FROM Customers
WHERE Country = 'Germany' 
	OR Country = 'Austria' 
	OR Country = 'Switzerland'


SELECT	  CustomerID
		, CompanyName
		, ContactName
FROM Customers
WHERE Country IN('Germany', 'Austria', 'Switzerland')


-- Angestellte mit der Nummer 3, 5, 7

SELECT *
FROM Employees
WHERE EmployeeID = 3 OR EmployeeID = 5 OR EmployeeID = 7



-- oder kürzer:
SELECT *
FROM Employees
WHERE EmployeeID IN(3, 5, 7)


-- ******************************* Bereiche abfragen ******************************
SELECT	  OrderID
		, Freight
--		, ...
FROM Orders
WHERE Freight >= 100 AND Freight <= 200


-- oder kürzer:
SELECT	  OrderID
		, Freight
--		, ...
FROM Orders
WHERE Freight BETWEEN 100 AND 200


-- Gib alle Produkte aus, deren ProduktID zwischen 10 und 15 (inklusive) liegt.
SELECT	  ProductID
		, ProductName
FROM Products
WHERE ProductID BETWEEN 10 AND 15


-- Gib alle Produkte aus, die vom Anbieter (SupplierID) 2, 7 oder 15 geliefert werden.
SELECT	  ProductID
		, ProductName
		, SupplierID
FROM Products
WHERE SupplierID IN(2, 7, 15)


