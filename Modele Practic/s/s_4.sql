SELECT CO.concertId, CO.locatie, COUNT(CC.cantaretId) AS NumarCantareti
FROM Concerte AS CO
JOIN ConcerteCantareti AS CC ON CO.concertId = CC.concertId
GROUP BY CO.concertId, CO.locatie
HAVING COUNT(CC.cantaretId) = (SELECT MIN(CantaretiCount) FROM (SELECT COUNT(cantaretId) AS CantaretiCount FROM ConcerteCantareti GROUP BY concertId) AS Subquery);
