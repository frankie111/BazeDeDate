-- Erstelle eine benutzerdefinierte Funktion
CREATE OR ALTER FUNCTION GetBahnhofsWithMultipleTrains (
    @SpecificTime TIME
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        RB.bahnhofId,
        COUNT(RB.zugId) AS AnzahlZuge
    FROM
        RoutenBahnhofe RB
    WHERE
        @SpecificTime >= RB.ankunft
        AND @SpecificTime <= RB.abfahrt
    GROUP BY
        RB.bahnhofId
    HAVING
        COUNT(RB.zugId) > 1
);

GO;

-- Verwende die Funktion in einer SELECT-Anweisung
SELECT
    bahnhofId,
    AnzahlZuge
FROM
    dbo.GetBahnhofsWithMultipleTrains('11:30:00');
