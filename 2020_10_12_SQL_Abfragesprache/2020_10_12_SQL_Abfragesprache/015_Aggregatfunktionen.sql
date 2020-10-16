-- Aggregatfunktionen
-- aggregate functions

-- COUNT


-- in wie vielen L�ndern haben wir Kunden?
SELECT Country
FROM Customers
-- bringt nix, so viele Eintr�ge, wie Kunden

SELECT DISTINCT Country
FROM Customers
-- damit bekomme ich so viele Ergebnisse, wie es unterschiedliche L�nder gibt, aber ich muss nachschauen, wie viele Zeilen habe ich zur�ckbekommen, um zu wissen, wie viele L�nder


-- COUNT!
SELECT COUNT(Country)
FROM Customers
-- 91
-- damit sind es wieder so viele, wie Kunden (jeder einzelne Eintrag von Country wird gez�hlt!)


-- mit DISTINCT
SELECT COUNT(DISTINCT Country)
FROM Customers
-- 21 :)


-- wenn wir etwas z�hlen, wo es keine doppelten Eintr�ge gibt, dann brauchen wir kein DISTINCT
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
SELECT AVG(UnitPrice) AS [durchschnittlicher St�ckpreis]
FROM Products
-- AVG ... average (Mittelwert)


-- Summen bilden:
SELECT SUM(Freight) AS [Summe aller Frachtkosten]
FROM Orders
-- 64942,69


-- kleinster/gr��ter Wert

SELECT MIN(UnitPrice) AS [niedrigster St�ckpreis]
FROM Products


SELECT MAX(UnitPrice) AS [niedrigster St�ckpreis]
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


-- mit WHERE einschr�nken trotzdem m�glich:
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
SELECT	  AVG(Freight) AS [Frachtkosten/Fr�chter]
		, ShipVia
FROM Orders
GROUP BY ShipVia -- pro was?
ORDER BY [Frachtkosten/Fr�chter] DESC -- Reihenfolge, in der ausgegeben wird



-- Durchschnittspreis der Waren?
SELECT	  AVG(UnitPrice)
FROM Products
-- 28,8663

-- ich m�chte nur 2 Nachkommastellen
SELECT	  CAST(AVG(UnitPrice) AS decimal(10, 2))
FROM Products
-- 28.87

-- CONVERT kann das auch:
SELECT	  CONVERT(decimal(10, 2), AVG(UnitPrice))
FROM Products
-- 28.87





