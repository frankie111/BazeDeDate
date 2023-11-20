CREATE OR ALTER VIEW GuestsWithMassage AS
SELECT G.GastId, G.Vorname, G.FamilienName
FROM Gäste AS G
WHERE G.GastId IN (
	SELECT B.GastId
	FROM Buchungen AS B
	JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
	JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
	WHERE D.Typ = 'Massage'
);

CREATE OR ALTER FUNCTION dbo.GuestsWithoutRooms()
RETURNS TABLE
AS
RETURN (
	SELECT G.GastId, G.Vorname, G.FamilienName
	FROM Gäste AS G
	WHERE G.GastId NOT IN (
		SELECT B.GastId
		FROM Buchungen AS B
		JOIN BuchungZimmer AS BZ ON B.BuchungId = BZ.BuchungId
	)
);


SELECT * FROM GuestsWithMassage;

SELECT * FROM dbo.GuestsWithoutRooms();

SELECT GM.GastId, GM.Vorname, GM.FamilienName
FROM GuestsWithMassage AS GM
WHERE GM.GastId NOT IN (
	SELECT GWR.GastId
	FROM dbo.GuestsWithoutRooms() AS GWR
);