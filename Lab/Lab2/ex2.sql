--1.
SELECT G.FamilienName, G.Vorname
FROM G�ste AS G
WHERE G.GastId IN (
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
    JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
    WHERE D.Typ = 'Massage'
)

EXCEPT

SELECT G.FamilienName, G.Vorname
FROM G�ste AS G
WHERE G.GastId IN (
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
    JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
    WHERE D.Typ = 'Poolzugang'
);


--2.
SELECT G.FamilienName, G.Vorname, COUNT(BZ.ZimmerNr) AS ZimmerAnzahl
FROM G�ste AS G
JOIN Buchungen AS B on G.GastId = B.GastId
JOIN BuchungZimmer AS BZ ON B.BuchungId = Bz.BuchungId
GROUP BY G.GastId, G.FamilienName, G.Vorname
HAVING COUNT(BZ.ZimmerNr) > 1;


--3.
SELECT G.FamilienName, G.Vorname, D.Typ
FROM G�ste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
WHERE D.Typ IN (
    SELECT TOP 2 D1.Typ
    FROM Dienstleistungen AS D1
    JOIN DienstleistungsBuchungen AS DB1 ON D1.DienstleistungId = DB1.DienstleistungId
    GROUP BY D1.DienstleistungId, D1.Typ
    ORDER BY COUNT(DB1.DienstleistungId) DESC
);


--4. ce face?
SELECT DISTINCT G.FamilienName, G.Vorname
FROM G�ste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN BuchungZimmer AS BZ ON B.BuchungId = BZ.BuchungId
JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
WHERE B.BuchungId IN (
    SELECT BZ.BuchungId
    FROM BuchungZimmer

	UNION

    SELECT DB.BuchungId
    FROM DienstleistungsBuchungen
);


SELECT DISTINCT G.FamilienName, G.Vorname
FROM G�ste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN BuchungZimmer AS BZ ON B.BuchungId = BZ.BuchungId
JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
WHERE B.BuchungId IN (
    SELECT BZ.BuchungId
    FROM BuchungZimmer

	INTERSECT

    SELECT DB.BuchungId
    FROM DienstleistungsBuchungen
);


--5.
SELECT G.FamilienName, G.Vorname, R.GesamtBetrag-SUM(ISNULL(Z.Betrag, 0)) AS Schulden, R.GesamtBetrag AS Gesamtbetrag, SUM(ISNULL(Z.Betrag, 0)) AS bezahlt
FROM G�ste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN Rechnungen AS R ON B.BuchungId = R.BuchungId
LEFT JOIN Zahlungen AS Z ON R.RechnungId = Z.RechnungId
GROUP BY G.GastId, G.FamilienName, G.Vorname, R.RechnungId, R.GesamtBetrag
HAVING SUM(ISNULL(Z.Betrag, 0)) < R.GesamtBetrag;


--6.
SELECT G.GastId , G.FamilienName, G.Vorname, D.Typ, D.Preis
FROM G�ste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
WHERE D.Preis > ANY (
    SELECT AVG(D1.Preis)
    FROM Dienstleistungen AS D1
);


--7.
SELECT D.Typ, AVG(BR.Bewertung) AS DurchschnittsNote, COUNT(BR.Bewertung) AS BewertungsAnzahl
FROM Dienstleistungen AS D
LEFT JOIN Bewertungen AS BR ON D.DienstleistungId = BR.DienstleistungId
GROUP BY D.DienstleistungId, D.Typ;


--8.
SELECT G.FamilienName, G.Vorname
FROM G�ste AS G
WHERE G.GastId NOT IN (
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN BuchungZimmer AS BZ ON B.BuchungId = BZ.BuchungId
);


--9.
SELECT G.FamilienName, G.Vorname
FROM G�ste AS G
JOIN Bewertungen AS BR ON G.GastId = BR.GastId
GROUP BY G.CNP, G.FamilienName, G.Vorname
HAVING COUNT(BR.DienstleistungId) = ALL (
	SELECT COUNT(D.DienstleistungId) 
	FROM Dienstleistungen AS D
)


--10.
SELECT G.FamilienName, G.Vorname
FROM G�ste AS G
WHERE G.GastId IN (
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
    WHERE DB.DienstleistungId = (SELECT DienstleistungId FROM Dienstleistungen WHERE Typ = 'Massage')
    
    INTERSECT
    
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN BuchungZimmer AS BZ ON B.BuchungId = BZ.BuchungId
    WHERE BZ.ZimmerNr IN (SELECT ZimmerNr FROM Zimmer WHERE Typ = 'Deluxe' OR Typ = 'Suite')
);
