-- MAXDOP
-- MAXimum Degree Of Parallelism

-- wie viele CPUs dürfen wir maximal für eine Abfrage verwenden?
-- Empfehlung: nicht mehr als die Hälfte der verfügbaren CPUs
-- (oder nicht mehr, als in einem Numa-node sind, wenn es mehrere Numa-nodes gibt)

SET STATISTICS IO, TIME ON

SET STATISTICS IO, TIME OFF

SELECT    City
		, SUM(Freight)
FROM KU2
GROUP BY City
ORDER BY City
