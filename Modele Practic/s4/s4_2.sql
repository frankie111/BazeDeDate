SELECT B.nume, B.scor
FROM Bands AS B
GROUP BY B.nume, B.scor
HAVING B.scor =	(SELECT MAX(B2.scor) FROM Bands AS B2)