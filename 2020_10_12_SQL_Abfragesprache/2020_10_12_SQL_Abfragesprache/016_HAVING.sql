-- HAVING


-- Rechnungssumme?
-- OrderID, Rechnungssumme


-- Idee:
SELECT    o.OrderID
		, UnitPrice*Quantity+Freight AS Rechnungsposten
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
-- faaalsch! das wäre der Rechnungsposten mit jeweils den Frachtkosten


SELECT    o.OrderID
		, SUM(UnitPrice*Quantity+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.OrderID
-- immer noch gleiches Problem: Frachtkosten werden pro Rechnungsposten hinzuaddiert!
-- Idee gut, Berechnung falsch

-- Klammern setzen:
SELECT    o.OrderID
		, (SUM(UnitPrice*Quantity)+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.OrderID, Freight
-- wenn wir ganz streng sind, müssten wir noch den Discount abziehen


-- nur die Bestellungen, wo die Rechnungssumme größer ist als 500
SELECT    o.OrderID
		, (SUM(UnitPrice*Quantity)+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
-- WHERE 500 < (SUM(UnitPrice*Quantity)+Freight) -- funktioniert nicht!
GROUP BY o.OrderID, Freight
HAVING (SUM(UnitPrice*Quantity)+Freight) > 500
ORDER BY Rechnungssumme




-- Wieviele Kunden gibts pro Land? Nur die, wo mehr als 5 Kunden pro Land vorhanden sind
-- Anzahl, Country
-- meiste Kunden zuerst

-- langsam:
-- wie viele Kunden gibts?
SELECT CustomerID
FROM Customers
-- 91 Zeilen, also 91 Kunden (weil Kunden ID eindeutig)

SELECT COUNT(CustomerID)
FROM Customers
-- 91 Kunden gibt es insgesamt

-- wie viele Kunden gibts pro Land?
SELECT    COUNT(CustomerID)
		, Country
FROM Customers
GROUP BY Country

-- mehr als 5 Kunden pro Land?
-- Idee:
SELECT    COUNT(CustomerID)
		, Country
FROM Customers
WHERE COUNT(CustomerID) > 5
GROUP BY Country
-- Fehlermeldung; wir können im WHERE nicht mit etwas vergleichen, das erst durch eine Aggregatfunktion berechnet wird


-- so gehts:
SELECT    COUNT(CustomerID)
		, Country
FROM Customers
GROUP BY Country -- PRO Land
HAVING COUNT(CustomerID) > 5


-- anordnen nach meiste Kunden zuerst:
SELECT    COUNT(CustomerID) AS [Kunden/Land]
		, Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5 -- hier müssen wir COUNT(CustomerID) schreiben
ORDER BY [Kunden/Land] DESC -- hier ist "Kunden/Land" schon bekannt




-- Gib die vollen Namen aller Angestellten aus, die mehr als 70 Bestellungen bearbeitet haben.

-- langsam:

-- voller Name Angestellte:
SELECT	  CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees


-- wie viele Bestellungen gibt es insgesamt?
SELECT COUNT(OrderID)
FROM Orders


-- Bestellungen pro.... Angestellter?
SELECT    COUNT(OrderID)
		, EmployeeID
FROM Orders
GROUP BY EmployeeID


-- wer hat mehr als 70 Bestellungen bearbeitet?
SELECT    COUNT(OrderID)
		, EmployeeID
FROM Orders
-- WHERE COUNT(OrderID) > 70 -- funktioniert NICHT!!
GROUP BY EmployeeID
HAVING COUNT(OrderID) > 70


-- zusammenstückeln:

SELECT    COUNT(OrderID) AS [Anzahl Bestellungen]
		, o.EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
-- WHERE COUNT(OrderID) > 70 -- funktioniert NICHT!!
GROUP BY o.EmployeeID, FirstName, LastName
HAVING COUNT(OrderID) > 70
-- ORDER BY [Anzahl Bestellungen]



-- die Angestellten Leverling und Peacock nur ausgeben, wenn sie über 100 Bestellungen geschafft haben:

SELECT    COUNT(OrderID) AS [Anzahl Bestellungen]
		, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE LastName = 'Leverling' OR LastName = 'Peacock'
GROUP BY FirstName, LastName
HAVING COUNT(OrderID) > 100



SELECT    COUNT(OrderID) AS [Anzahl Bestellungen]
		, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE LastName IN('Leverling', 'Peacock')
GROUP BY FirstName, LastName
HAVING COUNT(OrderID) > 100




