CREATE OR ALTER VIEW ConcurentiPeste10Castigatori AS
SELECT C.nume, C.varsta
FROM Concurenti AS C
JOIN Bands AS B ON C.bandId = B.bandId
WHERE B.scor > 10
	AND C.concurentId IN (
		SELECT DISTINCT D.castigatorBandId
		FROM Dueluri AS D
		WHERE D.castigatorBandId = C.bandId
	)

GO;

SELECT * FROM ConcurentiPeste10Castigatori;