USE Northwind

-- einfache Abfragen
-- Text, Zahlen, Berechnungen im SELECT


SELECT 'Testtext'

SELECT 123

SELECT 100*3

SELECT '100*3'



SELECT 'Testtext', 123, '100*3'

--SELECT 'Testtext',
--		123,
----		'100*3'


SELECT   'Testtext'
		, 123
		, '100*3'




-- schönere Schreibweise:
SELECT	  FirstName
		, LastName
FROM Employees
GO -- "Batch Delimiter"


-- Spaltenüberschrift erstellen
SELECT 100 AS Hundert


-- wir können Spaltenüberschriften umbenennen (in Textausgabe)
SELECT	  FirstName AS Vorname
		, LastName AS Nachname
FROM Employees



SELECT    100 AS Zahl
		, 'Donaudamfschifffahrtsgesellschaft' AS [Text]
		, 100*2 AS Berechnung



SELECT    100 AS Zahl
		, 'Donaudamfschifffahrtsgesellschaft' AS [Mein Text]
		, 100*2 AS Berechnung







