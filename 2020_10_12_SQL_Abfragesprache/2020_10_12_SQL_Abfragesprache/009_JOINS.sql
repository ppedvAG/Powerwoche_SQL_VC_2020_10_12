-- Informationen aus mehreren Tabellen abfragen

-- INNER JOIN

-- OUTER JOIN
		-- LEFT JOIN
		-- RIGHT JOIN


SELECT *
FROM Orders


-- Informationen aus zwei Tabellen??
SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- welche Spalten möchte ich haben?
SELECT	  OrderID
		, Customers.CustomerID -- wenn Name nicht eindeutig: aus welcher Tabelle??
		, CompanyName
--		, ...
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- bei den anderen können wir es dazuschreiben:
-- empfohlen!
SELECT	  Orders.OrderID
		, Customers.CustomerID
		, Customers.CompanyName
--		, ...
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- ein bisschen kürzer schreiben:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
--		, ...
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID


-- noch ein bisschen kürzer schreiben:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
-- wir dürfen das AS weglassen


-- weiter einschränken:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Germany'

-- nach Kunden geordnet:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Germany'
ORDER BY c.CompanyName -- ASC -- (Default)


-- Gib alle Kunden (Firmenname) aus Brasilien und deren Frachtkosten aus.
-- Ordne die Ausgabe aufsteigend nach Frachtkosten.
-- BRAZIL

--SELECT Country
--FROM Customers

SELECT	  c.CustomerID
		, c.CompanyName
		, o.Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Brazil'
ORDER BY o.Freight 

-- Gib die Namen der Anbieter (Supplier), die Sauce verkaufen, aus. (CompanyName, ProductName, Ansprechperson, Telefonnummer).
SELECT	  p.ProductName
		, s.SupplierID
		, s.CompanyName
		, s.ContactName
		, s.Phone
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE p.ProductName LIKE '%sauce%' -- OR p.ProductName LIKE '%soße%'



-- Joinen von mehr als zwei Tabellen:
SELECT	  o.OrderID
		, s.ShipperID
		, s.CompanyName
		, c.CompanyName
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
				 INNER JOIN Shippers s ON s.ShipperID = o.ShipVia


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




-- Welche Kunden haben Chai Tee gekauft und wieviel?
-- (OrderID, CustomerID, CompanyName, ProductName, Quantity)

SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName LIKE '%chai%'


-- oder, wenn wir den Produktnamen wissen:
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Chai'


SELECT DATEADD(mi, 15, GETDATE()) -- 2020-10-14 10:59:31.870 (11:00)



-- Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier?
-- Tipp: Der Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.
-- Nach Menge und Kundenname geordnet:
--Menge absteigend (größte zuerst), 	Kundenname aufsteigend (A-Z)

SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName LIKE '%bier%' OR p.ProductName LIKE '%lager%' OR p.ProductName LIKE '%ale'
ORDER BY od.Quantity DESC, c.CompanyName -- ASC (Default)




-- Haben wir Kunden, die noch nichts bestellt haben?

-- Idee:
SELECT *
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL
-- FAAAAALSCH!!!!
-- geht leider nicht mit INNER JOIN!!!


-- > Outer JOINs
-- LEFT JOIN, RIGHT JOIN


-- funktioniert das mit RIGHT JOIN?
SELECT *
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL
-- in DIESEM konkreten Beispiel hätten wir mit RIGHT JOIN das gleiche Ergebnis wie mit INNER JOIN



-- funktioniert das mit LEFT JOIN?
SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL
-- FISSA, PARIS haben noch nichts bestellt

-- gleiches Ergebnis mit RIGHT JOIN, wenn wir die Tabellen in der Abfrage in umgekehrter Reihenfolge hinschreiben:
SELECT *
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


-- bestimmte Spalten auswählen
SELECT	  c.CustomerID
		, c.CompanyName
		, c.ContactName
		, c.Phone
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


