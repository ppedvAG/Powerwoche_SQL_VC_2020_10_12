-- SET-Operatoren

-- UNION, UNION ALL, INTERSECT, EXCEPT



-- ************************************* UNION, UNION ALL *****************************

SELECT 'Testtext1'
UNION
SELECT 'Testtext2'


-- Liste von allen Kontaktpersonen?

-- Idee:
SELECT	  c.ContactName
		, c.Phone
		, s.ContactName
		, s.Phone
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
				 INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
-- keine gute Idee!!
-- hier stehen nur die Kunden, die schon etwas bestellt haben
-- und nur die Supplier, die schon etwas geliefert haben!!
-- ... und wir bekommen damit auch keine Liste, sondern entsprechend mehr Spalten



-- Liste von Kontaktpersonen:
-- mit UNION
SELECT	  ContactName
		, Phone
FROM Customers
UNION
SELECT	  ContactName
		, Phone
FROM Suppliers




-- funktioniert nicht:
-- in einer Spalte m�ssen die gleichen Datentypen drinstehen
SELECT	'Testtext', 123
UNION
SELECT 'Test', 'Hallo'
-- Conversion failed when converting the varchar value 'Hallo' to data type int.


-- funktioniert nicht:
-- wir m�ssen bei beiden die gleiche Spaltenanzahl verwenden
SELECT 'Testtext', 123
UNION
SELECT 'Test'


-- wir d�rften die Spalte mit NULL auff�llen
-- SINN? Von Fall zu Fall entscheiden, ob das Sinn macht
SELECT 'Testtext', 123
UNION
SELECT 'Test', NULL


-- wir k�nnen Daten in andere (kompatible) Datentypen umwandeln
-- SINN?? Von Fall zu Fall entscheiden, ob das Sinn macht!
SELECT	'Testtext', 'Hallo'
UNION
SELECT 'Test', CAST(123 AS varchar)


-- funktioniert NICHT:
-- CustomerID = Text (ALFKI), EmployeeID = Zahl (1-9)
SELECT CustomerID, ContactName
FROM Customers
UNION
SELECT EmployeeID, LastName
FROM Employees

-- funktioniert nicht:
-- braucht gleiche Anzahl an Spalten
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT ContactName, Phone
FROM Suppliers


-- theoretisch d�rfen wir die "fehlende" Spalte auch selbst bef�llen:
-- SINN?? Von Fall zu Fall entscheiden, ob das Sinn macht!
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT 'XXX', ContactName, Phone
FROM Suppliers



-- theoretisch d�rfen statt der fehlenden Spalte auch NULL einsetzen:
-- SINN?? Von Fall zu Fall entscheiden, ob das Sinn macht!
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT NULL, ContactName, Phone
FROM Suppliers



-- die Spalten m�ssen nicht gleich hei�en, damit UNION funktioniert
-- es m�ssen nur gleich viele Spalten sein und kompatible Datentypen
SELECT Country, Phone -- AS Tel
FROM Customers
UNION
SELECT Country, HomePhone
FROM Employees




-- "ABC"-Analyse


SELECT	  ContactName
		, Phone
		, 'C' AS Category
FROM Customers
UNION
SELECT	  ContactName
		, Phone
		, 'S' -- AS Category
FROM Suppliers
ORDER BY Category --, ContactName -- sinnvoll! 
-- ORDER BY nach dem, wonach ich es geordnet haben m�chte, nicht abh�ngig vom Index, den die DB grade verwendet
-- ORDER BY gilt f�r die gesamte Abfrage! (nicht nur f�r den unteren oder oberen Teil)




-- Gib alle Regionen der Kunden und der Angestellten aus.
-- F�ge eine Kategorie �C� f�r Customer und �E� f�r Employee hinzu.
SELECT    Region
		, 'E' AS Category
FROM Employees
UNION
SELECT    Region
		, 'C' -- AS Category
FROM Customers
-- ORDER BY Category

-- ohne die, wo "nix" drinsteht
SELECT    Region
		, 'E' AS Category
FROM Employees
WHERE Region IS NOT NULL
UNION
SELECT    Region
		, 'C' -- AS Category
FROM Customers
WHERE Region IS NOT NULL
-- ORDER BY Category



-- ACHTUNG: UNION macht ein DISTINCT!!
SELECT 'Testtext'
UNION
SELECT 'Testtext'



-- wenn ich Mehrfacheintr�ge haben m�chte:
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'

-- wenn ich alle haben m�chte:
-- UNION ALL
SELECT    Region
		, 'E' AS Category
FROM Employees
UNION ALL 
SELECT    Region
		, 'C' -- AS Category
FROM Customers
ORDER BY Category



-- wenn ich MIT SICHERHEIT wei�, dass es keine Mehrfacheintr�ge gibt,
-- k�nnen wir auch mit UNION ALL arbeiten
-- wenn kein DISTINCT gemacht wird, weil es keine Mehrfacheintr�ge gibt,
-- ist UNION ALL schneller (weil nicht �berpr�ft werden muss, ob es Mehrfacheintr�ge gibt)
SELECT	  ContactName
		, Phone
FROM Customers
UNION
SELECT	  ContactName
		, Phone
FROM Suppliers



SELECT	  ContactName
		, Phone
FROM Customers
UNION ALL
SELECT	  ContactName
		, Phone
FROM Suppliers

-- Pause:
SELECT DATEADD(mi, 15, GETDATE()) -- 2020-10-14 15:55:52.600



-- niedrigster und h�chster Frachtkostenwert in einer Liste:
-- OrderID, Freight, 'niedrigster Frachtkostenwert'
-- OrderID, Freight, 'h�chster Frachtkostenwert'


-- Idee:
SELECT TOP 1 OrderID, Freight, 'niedriegster Wert' AS Wert
FROM Orders
ORDER BY Freight
UNION -- UNION funktioniert hier NICHT, weil ORDER BY f�r gesamte Abfrage gilt
SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert
FROM Orders
ORDER BY Freight DESC



-- mit tempor�rer Tabelle gehts!
SELECT TOP 1 OrderID, Freight, 'niedriegster Wert' AS Wert
INTO #n -- Name egal; # f�r lokale tempor�re Tabelle
FROM Orders
ORDER BY Freight


SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert
INTO #h
FROM Orders
ORDER BY Freight DESC

SELECT *
FROM #n
UNION
SELECT *
FROM #h
-- ORDER BY Freight



-- min/max?

SELECT MIN(Freight) AS Freight
FROM Orders
UNION
SELECT MAX(Freight)
FROM Orders
-- ja, aber da haben wir nur eine Spalte


-- das funktioniert, denn nach etwas, das wir selbst hingeschrieben haben k�nnen wir nicht gruppieren
SELECT MIN(Freight) AS Freight
		, 'niedrigster Frachtkostenwert' AS Wert
FROM Orders
UNION
SELECT MAX(Freight)
		, 'h�chster Frachtkostenwert' -- AS Wert
FROM Orders


-- das funktioniert nicht mehr, denn jetzt ist es der kleinste/gr��te Frachtkostenwert PRO OrderID, also wieder genau der Frachtkostenwert
-- wir bekommen 1660 Zeilen heraus
-- 830 Zeilen vom ersten, 830 Zeilen vom zweiten SELECT
SELECT    OrderID
		, MIN(Freight) AS Freight
		, 'niedrigster Frachtkostenwert' AS Wert
FROM Orders
GROUP BY OrderID
UNION
SELECT    OrderID
		, MAX(Freight)
		, 'h�chster Frachtkostenwert' -- AS Wert
FROM Orders
GROUP BY OrderID


-- mit Subquery funktioniert es auch:


SELECT *
FROM
	(
		SELECT TOP 1 OrderID
				   , Freight
				   , 'niedrigster Frachtkostenwert' AS Wert
		FROM Orders
		ORDER BY Freight
	) AS n
UNION
SELECT *
FROM
	(
		SELECT TOP 1  OrderID
					, Freight
					, 'h�chster Frachtkostenwert' AS Wert
		FROM Orders
		ORDER BY Freight DESC
	) AS h
ORDER BY Freight DESC







-- ***************************** INTERSECT, EXCEPT **************************************

CREATE TABLE #a (id int)
CREATE TABLE #b (id int)

INSERT INTO #a VALUES (1), (NULL), (2), (1)
INSERT INTO #b VALUES (1), (NULL), (3), (1)

SELECT *
FROM #a

SELECT *
FROM #b



-- UNION
SELECT id
FROM #a
UNION
SELECT id
FROM #b
-- NULL, 1, 2, 3


-- UNION ALL
SELECT id
FROM #a
UNION ALL
SELECT id
FROM #b
-- 1, NULL, 2, 1, 1, NULL, 3, 1


-- INTERSECT
-- was ist gleich?
SELECT id
FROM #a
INTERSECT
SELECT id
FROM #b
-- NULL, 1


-- EXCEPT
-- was ist in Tabelle a, das nicht in Tabelle b vorkommt?
SELECT id
FROM #a
EXCEPT
SELECT id
FROM #b
-- 2


-- was ist in Tabelle b, das nicht in Tabelle a vorkommt?
SELECT id
FROM #b
EXCEPT
SELECT id
FROM #a
-- 3



-- was macht denn ein JOIN??
-- INNER JOIN
SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id
-- 1, 1, 1, 1

-- LEFT JOIN
SELECT a.id
FROM #a a LEFT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, 2, 1, 1




