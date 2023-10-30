--1. Find guests who have booked 'Massage' but have not booked 'Poolzugang'
SELECT G.FamilienName, G.Vorname
FROM Gäste AS G
WHERE G.GastId IN (
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
    JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
    WHERE D.Typ = 'Massage'
)

EXCEPT

SELECT G.FamilienName, G.Vorname
FROM Gäste AS G
WHERE G.GastId IN (
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
    JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
    WHERE D.Typ = 'Poolzugang'
);

--2. Select guests that have more than one room booked on the same reservation
SELECT G.FamilienName, G.Vorname, COUNT(BZ.ZimmerNr) AS ZimmerAnzahl
FROM Gäste AS G
JOIN Buchungen AS B on G.GastId = B.GastId
JOIN BuchungZimmer AS BZ ON B.BuchungId = Bz.BuchungId
GROUP BY G.GastId, G.FamilienName, G.Vorname
HAVING COUNT(BZ.ZimmerNr) > 1;

--3. Select the guests that have booked one of the two most popular services
SELECT G.FamilienName, G.Vorname, D.Typ
FROM Gäste AS G
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


--4. Find guests who have booked both rooms and services
SELECT DISTINCT G.FamilienName, G.Vorname
FROM Gäste AS G
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


--5. List the guests that have debt
SELECT G.FamilienName, G.Vorname, R.GesamtBetrag-SUM(ISNULL(Z.Betrag, 0)) AS Schulden
FROM Gäste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN Rechnungen AS R ON B.BuchungId = R.BuchungId
LEFT JOIN Zahlungen AS Z ON R.RechnungId = Z.RechnungId --LEFT JOIN ca sa apara si clientii fara niciun zahlung
GROUP BY G.GastId, G.FamilienName, G.Vorname, R.RechnungId, R.GesamtBetrag
HAVING SUM(ISNULL(Z.Betrag, 0)) < R.GesamtBetrag;

--6. Find guests who have booked services with a cost higher than the average cost of services
SELECT DISTINCT G.GastId , G.FamilienName, G.Vorname, D.Preis
FROM Gäste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
WHERE D.Preis > ANY (
    SELECT AVG(D1.Preis)
    FROM Dienstleistungen AS D1
);


--7. Show the average rating and the number of reviews for each service
SELECT D.Typ, AVG(BR.Bewertung) AS DurchschnittsNote, COUNT(BR.Bewertung) AS BewertungsAnzahl
FROM Dienstleistungen AS D
LEFT JOIN Bewertungen AS BR ON D.DienstleistungId = BR.DienstleistungId
GROUP BY D.DienstleistungId, D.Typ;

--8. Find guests who have not booked any rooms
SELECT G.FamilienName, G.Vorname
FROM Gäste AS G
WHERE G.GastId NOT IN (
    SELECT B.GastId
    FROM Buchungen AS B
    JOIN BuchungZimmer AS BZ ON B.BuchungId = BZ.BuchungId
);

--9. Select all guests who have reviewed all services
SELECT G.FamilienName, G.Vorname
FROM Gäste AS G
JOIN Bewertungen AS BR ON G.GastId = BR.GastId
GROUP BY G.CNP, G.FamilienName, G.Vorname
HAVING COUNT(BR.DienstleistungId) = ALL (
	SELECT COUNT(D.DienstleistungId) 
	FROM Dienstleistungen AS D
	)

--10. Find guests who have booked a specific service and a specific room type
SELECT G.FamilienName, G.Vorname
FROM Gäste AS G
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
