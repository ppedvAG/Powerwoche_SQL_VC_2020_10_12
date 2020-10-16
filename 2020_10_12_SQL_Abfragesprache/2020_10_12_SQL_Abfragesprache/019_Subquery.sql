-- subquery, Subselect, Unterabfrage

-- Unterabfrage wie Spalte, wie Tabelle oder im WHERE verwenden


SELECT	  'Text'
		, Freight
		, (SELECT TOP 1 Freight FROM Orders ORDER BY Freight)
FROM Orders

-- wenn Unterabfrage wie eine Spalte verwendet wird, darf da nur 1 Wert drinstehen


SELECT *
FROM -- Tabelle?
		(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) AS t1

-- wenn wir Subquery als Datenquelle verwenden, dann m�ssen wir ein ALIAS vergeben (AS t1)
-- das AS darf weggelassen werden
-- Name d�rfen wir uns aussuchen, muss nicht "t1" hei�en


-- Subquery im WHERE verwenden
-- Bsp.:
-- alle Bestellungen, wo die Frachtkosten h�her sind, als die durchschnittlichen Frachtkosten
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) -- 78,2442
-- in diesem Fall muss ein ganz konkreter Wert rauskommen, denn wir wollen ja �berpr�fen, ob die Frachtkosten gr��er sind als dieser Wert



-- wir k�nnen trotz Subselect auch mehrere Bedingungen abfragen
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) AND Freight < 200



-- theoretisch auch mehrere Subqueries m�glich, aber Sinn? .... Performance??
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) AND Freight < (SELECT SUM(Freight) FROM Orders)



-- alle Kunden, die in einem Land wohnen, in das auch Bestellungen verschifft werden
SELECT *
FROM Customers
WHERE Country IN(SELECT DISTINCT ShipCountry FROM Orders)
-- bei IN d�rfen beim Subselect auch mehrere Werte herauskommen




-- Gib die SupplierID, den CompanyName, die Kontaktinformation und das Land aller Supplier aus, die aus dem gleichen Land sind wie der Supplier Nr. 2.

-- wo kommt der mit NR 2 her?
SELECT Country
FROM Suppliers
WHERE SupplierID = 2
-- USA


SELECT	  SupplierID
		, CompanyName
		, CONCAT(ContactTitle, ', ', ContactName) AS Contact
		, Phone
--		, ...
		, Country
FROM Suppliers
WHERE Country = (SELECT Country FROM Suppliers WHERE SupplierID = 2)




-- -- Gib die Namen und das Einstellungsdatum der Mitarbeiter aus, die im selben Jahr eingestellt wurden wie Mr. Robert King.
--Titel, Vorname und Nachname sollen �berpr�ft werden.
--Uhrzeit soll nicht mit ausgegeben werden

-- langsam:
-- wie bekomme ich das Jahr, in dem Mr. Robert King eingestellt wurde?
SELECT YEAR(HireDate)
FROM Employees
WHERE LastName = 'King' AND FirstName = 'Robert' AND TitleOfCourtesy = 'Mr.'

-- oder mit DATEPART:
SELECT DATEPART(yyyy, HireDate)
FROM Employees
WHERE LastName = 'King' AND FirstName = 'Robert' AND TitleOfCourtesy = 'Mr.'
-- 1994


-- Name und Einstellungsdatum von Mitarbeitern
SELECT	  CONCAT(FirstName, ' ', LastName, ', ', TitleOfCourtesy) AS FullName
		, HireDate
FROM Employees


-- wie bekomme ich Mitarbeiter, die in einem bestimmten Jahr eingestellt worden sind?
-- 1994
SELECT	  CONCAT(FirstName, ' ', LastName, ', ', TitleOfCourtesy) AS FullName
		, HireDate
FROM Employees
WHERE YEAR(HireDate) = 1994


-- zusammenf�gen:
SELECT	  CONCAT(FirstName, ' ', LastName, ', ', TitleOfCourtesy) AS FullName
		, HireDate
FROM Employees
WHERE YEAR(HireDate) = (
							SELECT YEAR(HireDate)
							FROM Employees
							WHERE LastName = 'King' 
								AND FirstName = 'Robert'
								AND TitleOfCourtesy = 'Mr.'
						)

-- in der Realit�t w�rden wir hier nach der EmployeeID (eindeutig!) fragen, und nicht nach Name und Titel des entsprechenden Angestellten


-- Uhrzeit wegmachen:
SELECT	  CONCAT(FirstName, ' ', LastName, ', ', TitleOfCourtesy) AS FullName
--		, YEAR(HireDate) AS Jahr
		, FORMAT(HireDate, 'd', 'de-de') AS Einstellungsdatum
		--, FORMAT(HireDate, 'D', 'de-de')
		--, FORMAT(HireDate, 'dd.MM.yyyy')
		--, CONVERT(varchar, HireDate, 104)
FROM Employees
WHERE YEAR(HireDate) = (
							SELECT YEAR(HireDate)
							FROM Employees
							WHERE LastName = 'King' 
								AND FirstName = 'Robert'
								AND TitleOfCourtesy = 'Mr.'
						)

-- wenn Robert King selbst nicht dabei sein soll:
SELECT	  CONCAT(FirstName, ' ', LastName, ', ', TitleOfCourtesy) AS FullName
		, FORMAT(HireDate, 'd', 'de-de') AS Einstellungsdatum
FROM Employees
WHERE YEAR(HireDate) = (
							SELECT YEAR(HireDate)
							FROM Employees
							WHERE LastName = 'King' 
								AND FirstName = 'Robert'
								AND TitleOfCourtesy = 'Mr.'
						)
	AND EmployeeID != 7
