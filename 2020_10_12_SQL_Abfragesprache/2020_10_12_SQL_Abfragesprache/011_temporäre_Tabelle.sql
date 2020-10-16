-- temporäre Tabellen
-- temporary tables


/*
	-- lokale temporäre Tabellen
	-- existiert nur in der aktuellen Session
	-- #Tabellenname



	-- globale temporäre Tabellen
	-- Zugriff auch aus anderen Sessions
	-- ##Tabellenname


	-- hält nur so lange, wie Verbindung (bzw. Session) besteht


	-- theoretisch dürfen wir temporäre Tabellen auch löschen
	

*/


SELECT CustomerID, Freight
INTO #t1
FROM Orders
WHERE ShipCountry = 'Germany'


SELECT *
FROM #t1


SELECT OrderID, OrderDate
INTO ##t2
FROM Orders
WHERE ShipCountry = 'Germany'


SELECT *
FROM ##t2


