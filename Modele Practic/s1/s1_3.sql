SELECT TV.nume, COUNT(STV.spectatorId) AS numarVizionari
FROM Spectatori AS S
JOIN SpectatoriTVShows AS STV ON S.spectatorId = STV.spectatorId
JOIN TVShows AS TV ON STV.tvShowId = TV.tvShowId
GROUP BY TV.nume, STV.spectatorId
HAVING COUNT(STV.spectatorId) > 
(
SELECT COUNT(STV.spectatorId)
FROM SpectatoriTVShows AS STV
JOIN TVShows AS TV ON STV.tvShowId = TV.tvShowId
WHERE TV.nume = 'Megastar'
);


SELECT COUNT(STV.spectatorId)
FROM SpectatoriTVShows AS STV
JOIN TVShows AS TV ON STV.tvShowId = TV.tvShowId
WHERE TV.nume = 'Megastar';

SELECT COUNT(STV.spectatorId) AS numarVizionari
FROM SpectatoriTVShows AS STV
WHERE 