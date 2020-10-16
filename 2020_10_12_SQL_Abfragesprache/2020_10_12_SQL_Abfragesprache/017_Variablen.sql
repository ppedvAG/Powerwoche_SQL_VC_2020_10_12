-- Variablen

/*

	-- lokale Variablen
	-- @Variablenname
	-- Zugriff in der Session, wo sie erstellt wurde

	-- globale Variablen
	-- @@Variablenname
	-- Zugriff auch von außerhalb

	-- Lebenszeit: nur so lange, wie Batch läuft


	-- Variable deklarieren
	-- welchen Datentyp soll die Variable bekommen
	-- Wert zuweisen

	-- Syntax:

	DECLARE @varname AS Datentyp


*/



-- Bsp.:

-- deklarieren:
DECLARE @var1 AS int



-- Wert zuweisen:
SET @var1 = 100



SELECT @var1


DECLARE @myDate datetime = GETDATE()
SELECT FORMAT(@myDate, 'd', 'de-de')



DECLARE @freight AS money = 50

SELECT *
FROM Orders
WHERE Freight > @freight


