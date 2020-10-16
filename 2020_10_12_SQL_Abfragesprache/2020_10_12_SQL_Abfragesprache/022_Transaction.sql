--Transaktion
-- transaction


BEGIN TRAN

UPDATE Produkte
SET Preis = 5.20
WHERE ProduktID = 4

ROLLBACK TRAN

COMMIT TRAN 

-- erst, wenn wir ein COMMIT gemacht haben ist es fix und kann nicht mehr mit Rollback rückgängig gemacht werden

SELECT *
FROM Produkte
