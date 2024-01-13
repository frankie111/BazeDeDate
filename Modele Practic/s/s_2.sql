CREATE OR ALTER VIEW DurataAlbume AS
SELECT A.titlu AS titluAlbum, SUM(C.durata) as durataAlbum
FROM Albume AS A
JOIN Cantece AS C ON A.albumId = C.albumId
GROUP BY A.albumId, A.titlu;

GO;

SELECT * FROM DurataAlbume;