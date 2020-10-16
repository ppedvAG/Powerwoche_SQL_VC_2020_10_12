-- Tabellenabfragen
-- Select auf Tabellen
-- immer überprüfen, welche Datenbank verwendet wird!


USE Northwind


-- * steht für alle Spalten
-- * nur für Übungen, nicht in der Realität verwenden!
-- DB kann sich verändern; Spalten können hinzukommen
SELECT *
FROM Customers

SELECT CompanyName
FROM Customers

SELECT	  CustomerID
		, CompanyName
--		, ...
FROM Customers


SELECT    CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers

-- mit neuen Spaltenüberschriften:

SELECT    CustomerID AS Kundennummer
		, CompanyName AS Firmenname
		, ContactName AS Kontaktperson
		, Phone AS Telefon
FROM Customers





SELECT    CustomerID
		, CompanyName
		, ContactName
		, Phone
		, 100
		, 'Testtext'
FROM Customers



SELECT Freight * 100 AS [hundertfache Frachtkosten]
FROM Orders


SELECT	  ProductID AS ProduktID
		, ProductName AS Produktname
		, UnitPrice AS Stückpreis
FROM Products


-- theoretisch dürfen wir das AS weglassen
-- nicht empfohlen!
SELECT	  ProductID ProduktID
		, ProductName Produktname
		, UnitPrice Stückpreis
FROM Products



SELECT Freight AS [Frachtkosten netto]
		, Freight*0.19 AS MwSt
		, Freight*1.19 AS Bruttofrachtkosten
FROM Orders




