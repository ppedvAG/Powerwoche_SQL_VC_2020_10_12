-- TOP
-- ORDER BY zwingend notwendig!
-- ORDER BY stellt sicher, dass die Daten in einer für uns nachvollziehbaren Reihenfolge ausgegeben werden
-- was ist die erste Zeile? --> abhängig von ORDER BY!!



SELECT *
FROM Customers


-- nur die ersten 10 Zeilen ausgeben:
SELECT TOP 10 *
FROM Customers


-- nur die erste Zeile:
SELECT TOP 1 *
FROM Customers

-- aber WAS ist die erste Zeile??
--> ORDER BY verwenden!!


-- bestimmte Spalten auswählen:
SELECT TOP 1	  CustomerID
				, CompanyName
				, ContactName
FROM Customers
ORDER BY CustomerID



-- theoretisch können wir auch nach Spalten ordnen, die im SELECT gar nicht vorkommen
-- Sinn?? Von Fall zu Fall entscheiden

SELECT TOP 1	  CustomerID
				, CompanyName
				, ContactName
--				, Country
FROM Customers
ORDER BY Country
-- CACTU (Argentina)



SELECT TOP 1  CustomerID
				, CompanyName
				, ContactName
				, Region
				, Country
--		, ...
FROM Customers
WHERE Region IS NOT NULL
ORDER BY Country, CustomerID
-- COMMI


-- wir können eine beliebige Anzahl an Zeilen ausgeben lassen:
SELECT TOP 18  CustomerID
				, CompanyName
				, ContactName
				, Region
				, Country
--		, ...
FROM Customers
WHERE Region IS NOT NULL
ORDER BY Country, CustomerID




SELECT TOP 10 PERCENT  CustomerID
					, CompanyName
					, ContactName
					, Region
					, Country
	--		, ...
FROM Customers
WHERE Region IS NOT NULL
ORDER BY Country, CustomerID



-- wie bekomme ich die letzten 5 Einträge?
SELECT TOP 5  CustomerID
					, CompanyName
					, ContactName
					, Region
					, Country
	--		, ...
FROM Customers
WHERE Region IS NOT NULL
ORDER BY Country, CustomerID DESC


-- alle, die den gleichen Wert haben, wie der letzte in der Ausgabemenge: WITH TIES
SELECT TOP 17 WITH TIES Freight
			, OrderID
FROM Orders
ORDER BY Freight



-- was ist das teuerste Produkt?
-- Produktname, Preis?
SELECT TOP 1 ProductName
		   , UnitPrice
FROM Products
ORDER BY UnitPrice DESC
-- Côte de Blaye	263,50



-- Suche die Top 10% der Produkte mit den größten Verkaufsmengen (ProductName, Quantity)
-- Einschließlich Produkte mit der gleichen Einkaufsmenge wie das letzte in der ursprünglichen Ausgabe

SELECT TOP 10 PERCENT WITH TIES
		  p.ProductName
        , od.Quantity
FROM Products AS p INNER JOIN [Order Details] AS od ON p.ProductID = od.ProductID
ORDER BY od.Quantity DESC



-- Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind).
-- Wähle nicht alle, sondern nur einige in diesem Zusammenhang sinnvolle Spalten aus.
SELECT	TOP 3 -- WITH TIES 
		  FORMAT(HireDate, 'd', 'de-de') AS HireDate
		--, FORMAT(HireDate, 'D', 'de-de')
		--, FORMAT(HireDate, 'dd.MM.yyyy')
		--, CONVERT(varchar, HireDate, 104)
		, EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees
ORDER BY HireDate
























