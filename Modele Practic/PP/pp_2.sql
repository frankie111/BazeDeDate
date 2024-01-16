CREATE OR ALTER PROCEDURE bahnhofProc
	@RouteId int,
	@BahnhofId int,
	@Ankunft time,
	@Abfahrt time
AS
BEGIN
	--Check ob Bahnhof auf der Rute existiert
	IF EXISTS(
		SELECT 1
		FROM RoutenBahnhofe AS RB
		JOIN Zuge AS Z ON RB.zugId = Z.zugId
		JOIN Routen AS R ON Z.zugId = R.zugId
		WHERE RB.bahnhofId = @BahnhofId AND Rb.zugId = R.zugId
	)
	BEGIN
		UPDATE RoutenBahnhofe
		SET ankunft = @Ankunft, abfahrt = @Abfahrt
		WHERE zugId IN (SELECT zugId FROM Routen WHERE routeId = @RouteId)
		AND bahnhofId = @BahnhofId
	END
	ELSE
	BEGIN
		INSERT INTO RoutenBahnhofe(zugId, bahnhofId, ankunft, abfahrt)
		VALUES (
			(SELECT TOP 1 zugId FROM Routen WHERE routeId = @RouteId),
			@BahnhofId,
			@Ankunft,
			@Abfahrt
		);
	END
END;

EXEC bahnhofProc 1, 2, '12:30', '14:00';

SELECT TOP (1000) [zugId]
      ,[bahnhofId]
      ,[ankunft]
      ,[abfahrt]
  FROM [PP].[dbo].[RoutenBahnhofe]
