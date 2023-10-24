--Select top 3 clients with the highest total amount, sorted in descending order by the total amount.
SELECT TOP 3 G.FamilienName, G.Vorname, R.GesamtBetrag
FROM Gäste AS G
JOIN Buchungen AS B ON G.GastId = B.GastId
JOIN Rechnungen AS R ON B.BuchungId = R.BuchungId
ORDER BY R.GesamtBetrag DESC;
