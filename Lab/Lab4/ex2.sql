CREATE OR ALTER VIEW GuestsWithoutRooms AS
SELECT G.GastId, G.Vorname, G.FamilienName
FROM Gäste AS G
WHERE G.GastId NOT IN (
	SELECT B.GastId
	FROM Buchungen AS B
	JOIN BuchungZimmer AS BZ ON B.BuchungId = BZ.BuchungId
);

CREATE OR ALTER FUNCTION dbo.GuestsWithService(@serviceType VARCHAR(50))
RETURNS TABLE
AS 
RETURN (
	SELECT G.GastId, G.Vorname, G.FamilienName
	FROM Gäste AS G
	WHERE G.GastId IN (
	SELECT B.GastId
	FROM Buchungen AS B
	JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
	JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
	WHERE D.Typ = @serviceType
	)
);
 

SELECT * FROM dbo.GuestsWithService('Massage');

SELECT * FROM GuestsWithoutRooms;

SELECT GM.GastId, GM.Vorname, GM.FamilienName
FROM dbo.GuestsWithService('Massage') AS GM
WHERE GM.GastId IN (
	SELECT GWR.GastId
	FROM GuestsWithoutRooms AS GWR
);
