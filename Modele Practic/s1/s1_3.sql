CREATE OR ALTER VIEW Resorturi5 AS
SELECT R.nume, COUNT(CL.clientId) AS NrClienti
FROM Resorturi AS R
JOIN Cabane AS CA ON R.resortId = CA.resortId
JOIN Clienti AS CL ON CA.cabanaId = CL.cabanaId
WHERE R.stele = 5
GROUP BY R.resortId, R.nume
ORDER BY COUNT(CL.clientId) DESC


GO;

SELECT * FROM Resorturi5;