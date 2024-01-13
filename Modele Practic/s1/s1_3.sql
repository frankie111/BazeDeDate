SELECT TV.nume, COUNT(STV.spectatorId) AS numarVizionari
FROM SpectatoriTVShows AS STV
JOIN TVShows AS TV ON STV.tvShowId = TV.tvShowId
GROUP BY TV.nume
HAVING COUNT(STV.spectatorId) > 
(
	SELECT COUNT(STV.spectatorId)
	FROM SpectatoriTVShows AS STV
	JOIN TVShows AS TV ON STV.tvShowId = TV.tvShowId
	WHERE TV.nume = 'Megastar'
);
