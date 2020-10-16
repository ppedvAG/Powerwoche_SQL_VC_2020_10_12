-- CAST, CONVERT, FORMAT
-- in welchem Datentyp wollen wir etwas ausgeben
-- in welchem Format



-- ************************** DATENTYPEN ****************************************
-- String Datentypen

/*
	char - fixe Anzahl an Zeichen
	varchar - variable Anzahl an Zeichen
	nchar - speichert in Unicode (fixe Anzahl an Zeichen)
	nvarchar - speichert in Unicode (variable Anzahl an Zeichen)

*/


-- Numerische Datentypen
/*

	bit - 1, 0, NULL

	int - ganze Zahlen
		tinyint, smallint, bigint

	float - Zahlen mit Kommastellen
	decimal(p, s) - p = wieviele Stellen darf ich insgesamt haben
				  - s = wieviele davon sind Nachkommastellen

		Bsp.: decimal(10, 2) - insgesamt 10 Stellen, davon 8 vor dem Komma und 2 nach dem Komma

	money - auf 4 Nachkommastellen genau

*/

-- Datumsdatentypen

/*
	datetime - auf 3-4 ms genau
	datetime2 - auf ~100 ns genau
	date - nur Datum
	time - nur Zeit

*/

-- boolean, bool - true oder false




-- ********************************** CAST ******************************************
-- Umwandeln von Datentypen

-- funktioniert:
SELECT '123' + 2 -- 125
-- die DB wandelt für uns in einen int um

-- funktioniert nicht:
SELECT '123.5' + 2
-- Conversion failed when converting the varchar value '123.5' to data type int.


-- wir können aber explizit konvertieren (einen Datentyp in einen anderen umwandeln):
SELECT CAST('123.5' AS float) + 2 -- 125.5


/*
	Microsoft-Dokumentation: implizite und explizite Konvertierung:
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15

*/


-- funktioniert auch mit Datum:
SELECT CAST(GETDATE() AS varchar) -- Oct 13 2020  2:30PM
-- wir haben nur mit CAST allein keinen Einfluss auf das Format!
-- Format wieder systemabhängig!


-- VORSICHT bei Anzahl Zeichen
-- Geht sich das, was ich darstellen möchte, noch aus??
SELECT CAST(SYSDATETIME() AS varchar(3)) -- 202 
-- macht keinen Sinn!!


-- Vorsicht auch damit:
SELECT CAST('2020-10-13' AS date)
-- was ist Tag, was ist Monat? Systemabhängig!


-- mit DB:
SELECT BirthDate
FROM Employees

-- funktioniert, aber nur mit CAST haben wir keinen Einfluss auf das Format:
SELECT CAST(BirthDate AS varchar)
FROM Employees


-- ***************************** CONVERT *************************************************
-- auch mit CONVERT können wir (wie der Name schon sagt) einen Datentyp in einen anderen konvertieren, aber CONVERT hat noch mehr Möglichkeiten
-- Style-Parameter


SELECT CONVERT(float, '123.5') + 2 -- 125.5

-- funktioniert auch mit Datum:
SELECT CONVERT(varchar, SYSDATETIME()) -- 2020-10-13 14:40:29.5119533


-- wieder Vorsicht mit Länge!
SELECT CONVERT(varchar(3), SYSDATETIME()) -- 202 - Blödsinn!


-- Style-Parameter
SELECT CONVERT(varchar, SYSDATETIME(), 104) -- 13.10.2020


/*
	Style-Parameter in der Microsoft-Dokumentation:
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

*/


-- Style-Parameter ohne century:
SELECT CONVERT(varchar, SYSDATETIME(), 4)
-- nur die letzten beiden Stellen der Jahreszahl
-- nicht empfohlen!



SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB


-- mit DB:
SELECT	  CONVERT(varchar, BirthDate, 104) AS DE
		, CONVERT(varchar, BirthDate, 101) AS US
		, CONVERT(varchar, BirthDate, 103) AS GB
FROM Employees


-- ********************************** FORMAT ********************************************
-- Ausgabedatentyp nvarchar

SELECT FORMAT(1234567890, '###-###/##-##')

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###')

-- Achtung: von rückwärts ausgeführt... wenn mehr oder weniger Zeichen vorhanden sind, als im Format angegeben, bekommen wir unschöne Ergebnisse


-- funktioniert auch mit Datum:
SELECT FORMAT(SYSDATETIME(), 'dd.MM.yyyy')
-- Vorsicht bei Format!
-- MM groß schreiben! Sonst wird es fälschlicherweise als Minute interpretiert
-- 13.53.2020


-- funktioniert NICHT bei Format:
SELECT FORMAT('2020-10-13', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.


-- mit DB:
SELECT FORMAT(BirthDate, 'dd.MM.yyyy') AS BirthDate
FROM Employees


-- Culture-Parameter:

SELECT	  FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'd', 'sv') AS Schweden


SELECT	  FORMAT(SYSDATETIME(), 'D', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'D', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'D', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'D', 'sv') AS Schweden

-- 'd' ..... Datum in Zahlen: 13.10.2020
-- 'D' ..... Datum als Text ausgeschrieben: Dienstag, 13. Oktober 2020



/*
	Microsoft Dokumentation Culture-Parameter:
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes

*/


-- mit DB:

SELECT	  FORMAT(BirthDate, 'd', 'de-de') AS DE
		--, FORMAT(BirthDate, 'd', 'en-us') AS US
		--, FORMAT(BirthDate, 'd', 'en-gb') AS GB
		--, FORMAT(BirthDate, 'd', 'sv') AS Schweden
FROM Employees



-- Gib die Mitarbeiternummer, den vollständigen Namen (in einer Spalte), die Anrede, das Geburtsdatum (ohne Zeitangabe) und die Telefonnummer aller Angestellten aus.

SELECT	  EmployeeID
		, TitleOfCourtesy
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(BirthDate, 'dd.MM.yyyy')
		, HomePhone
FROM Employees


-- oder:
SELECT	  EmployeeID
		, TitleOfCourtesy
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(BirthDate, 'd', 'de-de')
		, HomePhone
FROM Employees


-- oder:
SELECT	  EmployeeID
		, TitleOfCourtesy
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, CONVERT(varchar, BirthDate, 104)
		, HomePhone
FROM Employees

