-- Serverfunktionen


-- **************************** TRIM, LEN, DATALENGTH *********************************

SELECT 'Test'

SELECT 'Test     '


SELECT LEN('Test') -- 4
SELECT LEN('Test     ') -- 4 LEN zählt Leerzeichen am Ende nicht mit!!
SELECT LEN('   Te st     ') -- 8 LEN zählt Leerzeichen davor und in der Mitte mit (aber nicht Leerzeichen am Ende)


SELECT DATALENGTH('Test') -- 4

-- ACHTUNG mit DATALENGTH: bei Unicode doppelt so viel wie Zeichen


SELECT DATALENGTH('Test     ') -- 9 -- Leerzeichen am Ende werden mitgezählt


SELECT RTRIM('Test     ') -- schneidet Leerzeichen auf der rechten Seite weg
SELECT LTRIM('     Test') -- schneidet Leerzeichen auf der linken Seite weg
SELECT TRIM('     Test     ') -- schneidet Leerzeichen auf beiden Seiten weg



-- hat das Wegschneiden funktioniert?
-- wieviele Zeichen sind noch übrig, nachdem wir die Leerzeichen weggeschnitten haben?
SELECT DATALENGTH(RTRIM('Test     ')) -- 4


-- ****************************** REVERSE *****************************************

SELECT REVERSE('REITTIER')

SELECT REVERSE('Trug Tim eine so helle Hose nie mit Gurt?')



-- ************************* LEFT, RIGHT, SUBSTRING ************************************
-- Zeichen ausschneiden

SELECT LEFT('Testtext', 4) -- Test

SELECT RIGHT('Testtext', 4) -- text


SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- von der 4. Stelle ausgehend schneiden wir 2 Zeichen aus



-- ******************************** STUFF *********************************************
-- etwas einfügen oder ersetzen

-- einfügen:
SELECT STUFF('Testtext', 5, 0, '_Hallo_') -- Test_Hallo_text
-- von Stelle 5 ausgehend: 0 löschen, _Hallo_ einfügen


-- ersetzen:
SELECT STUFF('Testtext', 4, 2, '_Hallo_') -- Tes_Hallo_ext
-- von Stelle 4 ausgehend: 2 löschen, _Hallo_ einfügen



-- ********************************** CONCAT **************************************
-- zusammenfügen

SELECT CONCAT('Test', 'text') -- Testtext

SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts', ' ', 'weiß.') AS Zitat


SELECT CONCAT('James', 'Bond')

-- mit Leerzeichen zwischen Vor- und Nachname:
SELECT CONCAT('James',' ', 'Bond')

-- mit Information aus der Datenbank:
SELECT CONCAT(FirstName, LastName)
FROM Employees

-- mit Leerzeichen:
SELECT CONCAT(FirstName, ' ', LastName)
FROM Employees


-- mit Spaltenüberschrift:
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees


SELECT CONCAT(FirstName, ' ', LastName) AS [Name Angestellte]
FROM Employees


/*
	Die letzten drei Stellen einer Telefonnummer sollen durch xxx ersetzt werden:
	z.B.:  +49 86779889xxx

	Bonus: die Lösung soll unabhängig von der Länge der Telefonnummer funktionieren

*/

-- Möglichkeit 1:
SELECT STUFF('1234567890', 8, 3, 'xxx')
-- von Stelle 8 ausgehen: lösche 3 weg und füge xxx hinzu
-- Vorsicht: funktioniert nur bei gleicher Zeichenanzahl

-- Möglichkeit 2:
SELECT LEFT('1234567890', 7) + 'xxx' -- 1234567xxx
SELECT CONCAT(LEFT('1234567890', 7), 'xxx')
-- Vorsicht: funktioniert nur bei gleicher Zeichenanzahl


-- Möglichkeit 3:
-- funktioniert unabhängig von der Zeichenanzahl

-- wieviele Zeichen sind es denn?
SELECT LEN('1234567890') -- 10

-- einsetzen in Beispiel von oben:
SELECT CONCAT(LEFT('1234567890', 7), 'xxx')

--> wie kommen wir auf die 7?
SELECT LEN('1234567890')-3

--> einsetzen:
SELECT CONCAT(LEFT('1234567890', LEN('1234567890')-3), 'xxx')


-- Möglichkeit 4:
-- funktioniert auch unabhängig von der Zeichenanzahl

--> wie komme ich auf die 8?

SELECT LEN('1234567890')-2

--> einsetzen:
SELECT STUFF('1234567890', LEN('1234567890')-2, 3, 'xxx')



-- Möglichkeit 5:




-- langsam:

-- Nummer umdrehen, dann stehen die letzten Zeichen, unabhängig von der Länge des Eintrages, am Anfang:
SELECT REVERSE('1234567890') -- 0987654321


-- erste 3 Zeichen mit x ersetzen:
SELECT STUFF('0987654321', 1, 3, 'xxx') -- xxx7654321

-- wieder umdrehen, damit sie wieder in der richtigen Reihenfolge stehen:
SELECT REVERSE('xxx7654321')


-- zusammenbauen:
SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))



-- mit DB:
-- mit Variante 3:
SELECT    Phone
		, CONCAT(LEFT(Phone, LEN(Phone)-3), 'xxx')
FROM Customers


-- mit Variante 4:
SELECT    Phone
		, STUFF(Phone, LEN(Phone)-2, 3, 'xxx')
FROM Customers


-- mit Variante 5:
SELECT    Phone
		, REVERSE(STUFF(REVERSE(Phone), 1, 3, 'xxx'))
FROM Customers




-- *********************************** REPLICATE **************************************
-- Zeichen oder Zeichenfolgen mehrfach ausgeben

SELECT REPLICATE('?', 5) -- ?????
SELECT REPLICATE('x', 3) -- xxx

SELECT REPLICATE('abc', 3) -- abcabcabc


-- Groß-/Kleinschreibung
SELECT UPPER('test') -- TEST
SELECT LOWER('TEST') -- test


SELECT LOWER(FirstName)
FROM Employees


SELECT UPPER(FirstName)
FROM Employees


-- ********************************* REPLACE ************************************
-- bestimmte Zeichen ersetzen

SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!


SELECT REPLACE('Hallo!axxxxxa', 'a', 'e') -- Hello!exxxxxe


-- mehrere Zeichen ersetzen (verschachteln)

SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?') -- Hello?


SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'h', 'B') -- Bello?



-- ********************************* CHARINDEX ***************************************
-- an welcher Stelle befindet sich ein bestimmtes Zeichen (oder Zeichenfolge)?
-- CHARINDEX zeigt das erste Vorkommen des gesuchten Zeichens
-- also keine Mehrfachergebnisse, wenn es öfter vorkommt

SELECT CHARINDEX('a', 'Leo') -- 0 (wenn es nicht vorkommt)

SELECT CHARINDEX('e', 'Leo') -- 2


SELECT CHARINDEX(' ', 'James Bond') -- 6

SELECT CHARINDEX('$', '450$') -- 4

SELECT CHARINDEX('%', '50%') -- 3


SELECT CHARINDEX('schnecke', 'Zuckerschnecke') -- 7


-- DB:
SELECT    CHARINDEX(' ', ContactName) AS Leerzeichenstelle
		, ContactName
FROM Customers


SELECT CHARINDEX(' ', 'Wolfgang Amadeus Mozart') -- 9


-- wie finde ich das letzte Leerzeichen?

-- langsam:
SELECT REVERSE('Wolfgang Amadeus Mozart') -- trazoM suedamA gnagfloW

-- letztes Leerzeichen -> 1. Leerzeichen im umgedrehten Text:
SELECT CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 7

-- wie viele Zeichen sind es insgesamt?
SELECT LEN('Wolfgang Amadeus Mozart') -- 23

-- 23 - 7 = 16
-- Stelle, an der sich das gesuchte Leerzeichen befindet: 16 + 1 = 17

-- einsetzen in 23 - 7 + 1 = Stelle, wo sich das gesuchte Leerzeichen befindet

SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'trazoM suedamA gnagfloW') + 1 -- 17


SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart')) + 1 -- 17


-- funktioniert auch mit anderen Namen:

SELECT LEN('Johann Sebastian Bach') - CHARINDEX(' ', REVERSE('Johann Sebastian Bach')) + 1 -- 17


SELECT LEN('Georg Friedrich Händel') - CHARINDEX(' ', REVERSE('Georg Friedrich Händel')) + 1 -- 16

-- funktioniert auch mit DB:
-- (bei ContactName ist allerdings nur 1 Leerzeichen drin)


SELECT LEN(ContactName) - CHARINDEX(' ', REVERSE(ContactName)) + 1
		, ContactName
FROM Customers


-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)


SELECT STUFF('1234567890', 1, 7, 'xxxxxxx')

SELECT STUFF('1234567890', 1, 7, REPLICATE('x', 7))


-- wie viele Zeichen sind es insgesamt:
SELECT LEN('1234567890') -- 10

-- wie viele Zeichen möchte ich weglöschen?
SELECT LEN('1234567890') - 3 -- 7

SELECT LEN(Phone)-3
FROM Customers


--> einsetzen:

SELECT STUFF('1234567890', 1, 7, REPLICATE('x', 7))
-- 7 wird durch die Berechnung ersetzt:

SELECT STUFF('1234567890', 1, (LEN('1234567890') - 3), REPLICATE('x', (LEN('1234567890') - 3)))

-- mit DB:
SELECT	  Phone
		, STUFF(Phone, 1, (LEN(Phone) - 3), REPLICATE('x', LEN(Phone) - 3))
FROM Customers

-- wie funktioniert STUFF:
-- 1. Parameter: wo möchte ich etwas löschen oder ersetzen: (Phone)
-- 2.: von welcher Stelle ausgehend (1)
-- 3.: wie viel soll weggelöscht werden (7; bzw. abhängig von der Länge des Eintrages Berechnung)
-- 4.: was soll eingefügt werden



-- andere Möglichkeit:
-- letzte 3 ausschneiden
SELECT RIGHT('1234567890', 3)

SELECT RIGHT(Phone, 3)
FROM Customers

SELECT CONCAT('x', RIGHT(Phone, 3))
FROM Customers

-- wie viele x brauche ich?
SELECT LEN(Phone)-3
FROM Customers

SELECT REPLICATE('x', LEN(Phone)-3)
FROM Customers


--> einsetzen:

SELECT	  Phone
		, CONCAT(REPLICATE('x', LEN(Phone)-3), RIGHT(Phone, 3))
FROM Customers



