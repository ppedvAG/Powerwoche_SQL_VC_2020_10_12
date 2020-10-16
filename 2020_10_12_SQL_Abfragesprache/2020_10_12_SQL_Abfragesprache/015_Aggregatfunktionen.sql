-- Aggregatfunktionen
-- aggregate functions

-- COUNT


-- in wie vielen Ländern haben wir Kunden?
SELECT Country
FROM Customers
-- bringt nix, so viele Einträge, wie Kunden

SELECT DISTINCT Country
FROM Customers
-- damit bekomme ich so viele Ergebnisse, wie es unterschiedliche Länder gibt, aber ich muss nachschauen, wie viele Zeilen habe ich zurückbekommen, um zu wissen, wie viele Länder


-- COUNT!
SELECT COUNT(Country)
FROM Customers
-- 91
-- damit sind es wieder so viele, wie Kunden (jeder einzelne Eintrag von Country wird gezählt!)


-- mit DISTINCT
SELECT COUNT(DISTINCT Country)
FROM Customers
-- 21 :)


-- wenn wir etwas zählen, wo es keine doppelten Einträge gibt, dann brauchen wir kein DISTINCT
-- z.B. wie viele Produkte gibt es denn?
SELECT COUNT(ProductID)
FROM Products
-- 77

SELECT COUNT(ProductID) AS AnzahlProdukte
FROM Products


-- funktioniert nicht ohne GROUP BY:
SELECT COUNT(ProductID), SupplierID
FROM Products



-- Durchschnittswert berechnen:
SELECT AVG(UnitPrice) AS [durchschnittlicher Stückpreis]
FROM Products
-- AVG ... average (Mittelwert)


-- Summen bilden:
SELECT SUM(Freight) AS [Summe aller Frachtkosten]
FROM Orders
-- 64942,69


-- kleinster/größter Wert

SELECT MIN(UnitPrice) AS [niedrigster Stückpreis]
FROM Products


SELECT MAX(UnitPrice) AS [niedrigster Stückpreis]
FROM Products


-- mehr als eine Spalte?
SELECT COUNT(ProductID), SupplierID
FROM Products
GROUP BY SupplierID
-- was noch im SELECT steht, muss in ein GROUP BY
-- GROUP BY ... pro...


-- ************************ GROUP BY **************************************
-- Summe PRO ? Summe Frachtkosten pro Kunde
SELECT	  SUM(Freight) AS [Frachtkosten/Kunde]
		, CustomerID
FROM Orders
GROUP BY CustomerID


-- mit WHERE einschränken trotzdem möglich:
SELECT	  SUM(Freight) AS [Frachtkosten/Kunde]
		, CustomerID
FROM Orders
WHERE YEAR(ShippedDate) = 1996
GROUP BY CustomerID


-- ORDER BY ist auch erlaubt!
SELECT	  SUM(Freight) AS [Frachtkosten/Kunde]
		, CustomerID
FROM Orders
WHERE YEAR(ShippedDate) = 1996
GROUP BY CustomerID
ORDER BY [Frachtkosten/Kunde] DESC



/*
	Reihenfolge, in der wir unsere Abfrage schreiben:

	SELECT
	FROM
	WHERE
	GROUP BY
	HAVING
	ORDER BY


	DB arbeitet die Abfrage aber in einer anderen Reihenfolge ab:

	FROM
	WHERE
	GROUP BY
	HAVING
	SELECT
	ORDER BY


*/


-- bringt nix!!!
SELECT SUM(Freight)
		, Freight
		, CustomerID
		, OrderID
FROM Orders
GROUP BY CustomerID, OrderID, Freight
-- Summe Frachtkosten pro OrderID sind wieder genau die Frachtkosten dieser einen Bestellung!


-- das funktioniert:
SELECT	  SUM(Freight)
		, ShipCountry
		, ShipCity
FROM Orders
GROUP BY ShipCountry, ShipCity
ORDER BY ShipCountry, ShipCity
-- Summe Frachtkosten pro Stadt im jeweiligen Land


-- durchschnittliche Frachtkosten pro Frachtunternehmen
SELECT	  AVG(Freight) AS [Frachtkosten/Frächter]
		, ShipVia
FROM Orders
GROUP BY ShipVia -- pro was?
ORDER BY [Frachtkosten/Frächter] DESC -- Reihenfolge, in der ausgegeben wird



-- Durchschnittspreis der Waren?
SELECT	  AVG(UnitPrice)
FROM Products
-- 28,8663

-- ich möchte nur 2 Nachkommastellen
SELECT	  CAST(AVG(UnitPrice) AS decimal(10, 2))
FROM Products
-- 28.87

-- CONVERT kann das auch:
SELECT	  CONVERT(decimal(10, 2), AVG(UnitPrice))
FROM Products
-- 28.87





