-- Erstelle eine Sicht
CREATE VIEW ViewRoutesWithFewestStations AS
SELECT
    R.routeId,
    R.name AS RouteName,
    COUNT(RB.bahnhofId) AS NumberOfStations
FROM
    Routen R
JOIN
    RoutenBahnhofe RB ON R.zugId = RB.zugId
GROUP BY
    R.routeId, R.name
HAVING
    COUNT(RB.bahnhofId) <= 5
ORDER BY
    NumberOfStations ASC;

GO;

-- Verwende die Sicht in einer SELECT-Anweisung
SELECT * FROM ViewRoutesWithFewestStations;
