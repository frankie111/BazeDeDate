SELECT C.titlu, COUNT(C.cantecId) AS Frecventa
FROM Dueluri AS D
JOIN Cantece AS C ON D.cantecId = C.cantecId
GROUP BY C.cantecId, C.titlu
HAVING COUNT(C.cantecId) > (
	SELECT COUNT(D.duelId)
	FROM Dueluri AS D
	JOIN Cantece AS C ON D.cantecId = C.cantecId
	WHERE C.titlu = 'Its my life'
);