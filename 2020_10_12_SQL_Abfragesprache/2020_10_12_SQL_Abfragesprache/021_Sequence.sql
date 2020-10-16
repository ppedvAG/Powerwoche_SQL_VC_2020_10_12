-- Sequence
-- ab SQL Server 2012 (funktioniert nicht in ganz alten DB Servern)

-- auch bei Identity konnten wir angeben, wo wir zu zählen beginnen und wieviel wir jeweils hochzählen
-- das kann Sequence auch:


CREATE SEQUENCE test_sq
START WITH 1
INCREMENT BY 1



CREATE SEQUENCE test_sq2
START WITH 1
INCREMENT BY 1



-- aufrufen mit NEXT VALUE FOR

-- nächste ID automatisch generieren lassen mit DEFAULT:

CREATE TABLE SeqTest(
						ID int PRIMARY KEY DEFAULT (NEXT VALUE FOR test_sq),
						TestName varchar(30),
						TestNumber int
					)



INSERT INTO SeqTest (TestName, TestNumber)
VALUES  ('James', 123456),
		('Mike', 98765)

SELECT *
FROM SeqTest

-- Sequence einzeln einfügen wäre möglich:
CREATE TABLE SeqTest2(
						ID int PRIMARY KEY,
						TestName varchar(30),
						TestNumber int
					)


INSERT INTO SeqTest2 (ID, TestName, TestNumber)
VALUES  (NEXT VALUE FOR test_sq2, 'James', 123456),
		(NEXT VALUE FOR test_sq2, 'Mike', 98765)



SELECT *
FROM SeqTest2