SELECT ABO.abonamentId, COUNT(S.spectatorId) * ABO.pret AS sumaTotala
FROM AbonamenteTV AS ABO
JOIN Spectatori AS S ON ABO.abonamentId = S.abonamentId
GROUP BY ABO.abonamentId, ABO.pret
HAVING COUNT(S.spectatorId) > 3