-- ER-Diagramm
-- Entity-Relationship- Diagramm
-- unterschiedliche Notationen (Chen, Min-Max, Crowsfoot/Kr�henfu�notation,... )


-- Normalformen
-- Normalisierung
-- 1. Normalform: "atomar" (1 Eintrag pro Feld)
-- 2. NF: 1. NF muss erf�llt sein; und alle m�ssen von 1 Schl�ssel abh�ngig sein
-- 3. NF: 1. und 2. NF m�ssen erf�llt sein; und es d�rfen keine transitiven Abh�ngigkeiten bestehen
-- Nicht-Schl�sselfelder d�rfen nicht voneinander abh�ngig sein
-- Sinn der NF: Redundanz vermeiden
-- Performance? Wir k�nnen NF auch brechen! Manchmal wird (besonders die 3. NF bewusst gebrochen, um Performance zu verbessern)



-- CREATE, INSERT, UPDATE, DELETE, (DROP)
-- Erstellen von Tabellen und ver�ndern von Werten




CREATE DATABASE Test

-- DROP DATABASE Test
-- VORSICHT: DROP l�scht alles inklusive Inhalt!!!


USE Test


CREATE TABLE Produkte 
					(
						ProduktID int identity(1, 1), -- identity macht auch NOT NULL und UNIQUE
						ProduktName nvarchar(50) NOT NULL,
						Preis money
						-- ...
						
					)


-- DROP TABLE Produkte
-- ACHTUNG: komplette Tabelle inklusive Inhalt wird gel�scht!!


-- nicht so sch�n...:
INSERT INTO Produkte
VALUES ('Spaghetti', 1.99)


-- besser:
INSERT INTO Produkte (Preis, ProduktName) --<
VALUES (1.99, 'Spaghetti')
-- angeben, in welcher Reihenfolge die Informationen eingelesen werden
-- was kommt in welche Spalte?


-- mehrere Informationen einf�gen:
INSERT INTO Produkte (ProduktName, Preis)
VALUES    ('Tiramisu', 4.99)
		, ('Profiterols', 4.89)
		, ('Limoncello', 3.99)



-- Werte ver�ndern mit UPDATE
-- UPDATE IMMER mit WHERE einschr�nken
-- sonst wird der Preis bei ALLEN auf 5.30 gesetzt!!!
-- idealerweise immer etwas nehmen, womit das gew�nschte Produkt eindeutig identifizierbar ist!
UPDATE Produkte
SET Preis = 5.30
WHERE ProduktID = 4



-- DROP l�scht komplett inkl. Inhalt
-- DELETE FROM Tabelle = kompletter Inhalt der Tabelle l�schen, Tabelle selbst ist noch da
-- mit WHERE einschr�nken!!!
-- damit nur das rausgel�scht wird, was man wirklich l�schen m�chte
-- idealerweise wieder etwas nehmen, womit wir das gew�nschte Produkt EINDEUTIG identifizieren k�nnen


DELETE FROM Produkte
WHERE ProduktID = 3

-- w�rden wir hier sagen
-- DELETE FROM Produkte WHERE ProduktName = 'Spaghetti', w�rden BEIDE rausgel�scht:
DELETE FROM Produkte
WHERE ProduktName = 'Spaghetti'


-- Tabelle ver�ndern mit ALTER
ALTER TABLE Produkte
ALTER COLUMN ProduktName nvarchar(70)


-- neue Spalte hinzuf�gen:
ALTER TABLE Produkte
ADD Email nvarchar(30)


-- ups, Fehler, Email-Spalte soll nicht in die Produkte-Tabelle...
ALTER TABLE Produkte
DROP COLUMN Email


SELECT *
FROM Produkte


-- Schl�sselfelder (Keys)
-- Primary Key (Hauptschl�ssel)
-- Foreign Key (Fremdschl�ssel)


-- alle anderen Spalten sind vom Primary Key abh�ngig
-- �ber Foreign Key stellen wir Verbindungen zu anderen Tabellen her


-- PRIMARY KEY
-- UNIQUE (Wert darf nur ein einziges Mal vorkommen)
-- NOT NULL


-- PRIMARY KEY vergeben
-- Variante 1:
-- direkt daneben hinschreiben:
CREATE TABLE Orders(
						OrderID int identity(10000, 1) PRIMARY KEY,
						CustomerID int,
						OrderDate date,
						ShipVia int
				--		...

				    )

-- drop table orders


-- andere M�glichkeit, PRIMARY KEY zu erstellen:
-- mit CONSTRAINT bei Tabellenerstellung
CREATE TABLE Orders2(
						OrderID int identity(10000, 1),
						CustomerID int,
						OrderDate date,
						ShipVia int
				--		...
						CONSTRAINT PK_Orders2 PRIMARY KEY (OrderID)
				    )


-- manchmal M�SSEN wir Variante 2 verwenden:
CREATE TABLE OrderDetails	(
								OrderID int,
								ProductID int,
								Quantity int
						--		...
								CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
							)




-- 3. M�glichkeit: �ber ALTER TABLE:
-- ALTER TABLE Orders2
-- ADD CONSTRAINT PK_Orders2 PRIMARY KEY (OrderID)


CREATE TABLE Products	(
							ProductID int identity PRIMARY KEY,
							ProductName nvarchar(30),
							UnitsInStock int
		--					...

						)


-- FOREIGN KEYS vergeben:
-- Variante 1 (nicht empfohlen):
CREATE TABLE Orders(
						OrderID int identity(10000, 1) PRIMARY KEY,
						CustomerID int FOREIGN KEY REFERENCES Customers (CustomerID),
						OrderDate date,
						ShipVia int
				--		...

				    )

-- Variante 2 w�re wieder mit einem CONSTRAINT innerhalb vom CREATE TABLE

-- Variante 3 (empfohlen):
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)


CREATE TABLE Shippers(
						ShipperID int identity PRIMARY KEY,
						TestSpalte nvarchar(30)
					 )


-- Shippers und Orders verkn�pfen
-- �ber Foreign Key  - hier hei�t die Spalte aber in einer Tabelle anders!
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID)


-- Products mit OrderDetails verkn�pfen:
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
