-- Datenbankspeichereinheiten:
-- page (Seite)

-- page besteht aus 8192 Byte (8 KB)

-- eine Zeile darf maximal 8060 Byte haben

-- 8 Seiten zusammen ergeben ein Extent (Block)

-- 8192 - 96 (page header) - 4 (2 x 2 row offset) - 14 (2 x 7 overhead) = 8078


CREATE TABLE Test (Testtext char(4039))

INSERT INTO Test (Testtext)
VALUES ('ABC')
	 , ('DEF')


SELECT *
FROM Test


DBCC TRACEON(3604)
DBCC IND('Test', 'Test', -1)
-- 448


DBCC PAGE('Test', 1, 448)


DBCC SHOWCONTIG('Test')


DBCC TRACEOFF(3604)