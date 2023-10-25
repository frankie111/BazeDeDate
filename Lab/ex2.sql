--1. Select top 3 guests with the highest total amount, sorted in descending order by the total amount.
SELECT TOP 3 G.FamilienName, G.Vorname, R.GesamtBetrag
FROM Gäste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN Rechnungen AS R ON B.BuchungId = R.BuchungId
ORDER BY R.GesamtBetrag DESC;

--2. Select guests that have more than one room booked on the same reservation
SELECT G.FamilienName, G.Vorname, COUNT(BZ.ZimmerNr) AS ZimmerAnzahl
FROM Gäste AS G
JOIN Buchungen AS B on G.GastId = B.GastId
JOIN BuchungZimmer AS BZ ON B.BuchungId = Bz.BuchungId
GROUP BY G.GastId, G.FamilienName, G.Vorname
HAVING COUNT(BZ.ZimmerNr) > 1;

--3. Select guests that have booked either Massage or Poolzugang
SELECT G.FamilienName, G.Vorname, D.Typ
FROM Gäste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN DienstleistungsBuchungen AS DB ON B.BuchungId = DB.BuchungId
JOIN Dienstleistungen AS D ON DB.DienstleistungId = D.DienstleistungId
WHERE D.Typ IN ('Massage', 'Poolzugang');

--4. Show the number of bookings for each guest
SELECT G.FamilienName, G.Vorname, COUNT(B.BuchungId) AS BuchungAnzahl
FROM Gäste AS G
LEFT JOIN Buchungen AS B ON G.GastId = B.GastId
GROUP BY G.GastId, G.FamilienName, G.Vorname;

--5. List the guests that have debt
SELECT G.GastId, G.FamilienName, G.Vorname, R.GesamtBetrag-SUM(ISNULL(Z.Betrag, 0)) AS Schulden
FROM Gäste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN Rechnungen AS R ON B.BuchungId = R.BuchungId
LEFT JOIN Zahlungen AS Z ON R.RechnungId = Z.RechnungId --LEFT JOIN ca sa apara si clientii fara niciun zahlung
GROUP BY G.GastId, G.FamilienName, G.Vorname, R.RechnungId, R.GesamtBetrag
HAVING SUM(ISNULL(Z.Betrag, 0)) < R.GesamtBetrag;



