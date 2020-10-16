-- Wildcards

/*
	% ..................... steht für beliebig viele unbekannte Zeichen (0-?)
	_ ..................... (Unterstrich) steht für genau 1 unbekanntes Zeichen
	[] .................... steht für genau 1 Zeichen aus bestimmtem Wertebereich
	^ ..................... steht innerhalb der eckigen Klammern für NICHT
	| ..................... (pipe) steht innerhalb der eckigen Klammern für ODER

*/


-- CustomerID BEGINNT mit ALF
SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'

/*
	mögliche Treffer:

	ALF
	ALFlskdfjlskjflksjlkfjlsjlsjldkjslkdjflskjflk
	ALFX

	ALFKI


*/


-- alle Länder, die mit A beginnen
SELECT *
FROM Customers
WHERE Country LIKE 'A%'


-- alle Kunden, die mit MI enden
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'

-- irgendwo im Namen kommt "kist" vor:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kist%'


-- ******************** genau 1 unbekanntes Zeichen gesucht **************************
SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALFK_'

/*
	mögliche Treffer hier immer 5 Zeichen:

	ALFKx
	ALFKI
	ALFK5

	NICHT: ALFKIXXX

*/

-- wir suchen nach Durchwahl...
SELECT Phone
FROM Customers
WHERE Phone LIKE '(5) 555-472_'



-- *************************** Wertebereiche abfragen ***********************************

-- bisher eckige Klammern: [Vollständiger Name]
-- neu: beim LIKE als Wildcard
-- [] als Wertebereich

-- alle Kunden, die mit a, b oder c beginnen

SELECT *
FROM Customers
WHERE CustomerID LIKE 'a%' OR CustomerID LIKE 'b%' OR CustomerID LIKE 'c%'

-- oder kürzer:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-c]%'

-- würde auch funktionieren:
--SELECT *
--FROM Customers
--WHERE CustomerID LIKE '[abc]%'
-- beginnt mit a ODER b ODER c


-- alle, die mit a oder c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE 'a%' OR CustomerID LIKE 'c%'

-- oder:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[ac]%'



-- wie würden wir die bekommen, die mit abc beginnen?
SELECT *
FROM Customers
WHERE CustomerID LIKE 'abc%'


-- alle, die ein %-Zeichen im Namen haben
SELECT *
FROM Customers
WHERE CustomerID LIKE '%[%]%'



-- ESCAPE Character
SELECT *
FROM Customers
WHERE CustomerID LIKE '%!%%' ESCAPE '!'


-- alle mit Hochkomma im Namen:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%' -- ACHTUNG: Trick... '' , nicht ' (Ausnahme)


-- alle, die mit a beginnen und mit e enden:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%' AND CompanyName LIKE '%e'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%e'



-- **************************** NOT ************************************

-- alle, die NICHT mit a-c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE '[^a-c]%'

-- auch hier gilt wieder: wenn möglich positiv formulieren und kein "NICHT" verwenden
SELECT *
FROM Customers
WHERE CustomerID LIKE '[d-z]%'


-- alle, die mit a-c oder e-g enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'


-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c | e-g]'


-- oder:
--SELECT *
--FROM Customers
--WHERE CompanyName LIKE '%[abcefg]'


-- Gib alle Produkte aus, deren Name mit „coffee“ endet.
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'



-- Gib alle Produkte aus, deren Name mit 'L' beginnt.
SELECT *
FROM Products
WHERE ProductName LIKE 'L%'


-- Gib alle Produkte aus, die ein 'ost' im Namen haben.
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'


-- Gib alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[a-d | m-o]'

-- oder:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d | m-o]'



-- oder:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')
-- in diesem Fall müssen wir Klammern setzen!!


-- Gib alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt.
SELECT *
FROM Products
WHERE SupplierID IN(5, 10, 15) AND UnitsInStock > 10 AND UnitPrice < 100



-- Annahme:
-- ALF5I
-- wie finde ich die falschen Einträge


SELECT CustomerID
FROM Customers
WHERE CustomerID NOT LIKE '[a-z][a-z][a-z][a-z][a-z]'


-- alle Kunden, die mit d, e oder f beginnen, der letzte Buchstabe ist ein L und der DRITTLETZTE ist ein d
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%' AND CompanyName LIKE '%d_l'


-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'

/*
	edel
	edxl
	fidel
	ddxl
	dxxxxxxxxxxxxxxxxxxxxxxxxxxxdxl

	Ernst Handel (in Northwind DB)
	e........d.l

*/