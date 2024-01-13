SELECT CO.locatie, CO.dataOra
FROM Concerte AS CO
JOIN ConcerteCantareti AS CC ON CO.concertId = CC.concertId
JOIN Cantareti AS CA ON CC.cantaretId = CA.cantaretId
WHERE CA.nume = 'Rammstein'
  AND NOT EXISTS (
    SELECT 1
    FROM ConcerteCantareti AS CC2
    JOIN Cantareti AS CA2 ON CC2.cantaretId = CA2.cantaretId
    WHERE CO.concertId = CC2.concertId
      AND CA2.nume = 'Jazzrausch'
  );