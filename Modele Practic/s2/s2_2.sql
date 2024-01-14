CREATE OR ALTER VIEW SpectatoriView AS
SELECT S.nume
FROM Spectatori AS S
JOIN SpectatoriTVShows AS STV ON S.spectatorId = STV.spectatorId
JOIN TVShows AS TV ON STV.tvShowId = TV.tvShowId
WHERE TV.nume = 'Next Star'
INTERSECT
SELECT S.nume
FROM Spectatori AS S
JOIN SpectatoriTVShows AS STV ON S.spectatorId = STV.spectatorId
JOIN TVShows AS TV ON STV.tvShowId = TV.tvShowId
WHERE TV.nume = 'Financial Education'

GO;

SELECT * FROM SpectatoriView;