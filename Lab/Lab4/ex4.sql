CREATE PROCEDURE UpdateArbeiterGehalt
    @ArbeiterId INT,
    @Erhohungsfaktor DECIMAL(4, 2)
AS
BEGIN
    DECLARE @Gehalt DECIMAL(10, 2);
    DECLARE @NeuesGehalt DECIMAL(10, 2);
	DECLARE @Position VARCHAR(40);

    SELECT @Gehalt = Gehalt, @Position = Position
    FROM Arbeiter
    WHERE ArbeiterId = @ArbeiterId;

	--TODO: Customize increase in functie de Position

    SET @NeuesGehalt = @Gehalt * @Erhohungsfaktor;

    UPDATE Arbeiter
    SET Gehalt = @NeuesGehalt
    WHERE ArbeiterId = @ArbeiterId;

    PRINT 'ArbeiterId: ' + CAST(@ArbeiterId AS VARCHAR(10)) + ' , Neues Gehalt: ' + CAST(@NeuesGehalt AS VARCHAR(20));
END;

CREATE OR ALTER PROCEDURE UpdateArbeiterGehalt
    @ArbeiterId INT,
    @Erhohungsfaktor DECIMAL(4, 2)
AS
BEGIN
    DECLARE @Gehalt DECIMAL(10, 2);
    DECLARE @NeuesGehalt DECIMAL(10, 2);
    DECLARE @Position VARCHAR(40);

    SELECT @Gehalt = Gehalt, @Position = Position
    FROM Arbeiter
    WHERE ArbeiterId = @ArbeiterId;

    -- Customize increase based on Position
    DECLARE @IncreaseFactor DECIMAL(4, 2);

    SET @IncreaseFactor = 
        CASE 
            WHEN @Position = 'Manager' THEN 1.15
            WHEN @Position = 'Koch' THEN 1.10
            ELSE 1.05
        END;

    SET @NeuesGehalt = @Gehalt * @Erhohungsfaktor * @IncreaseFactor;

    UPDATE Arbeiter
    SET Gehalt = @NeuesGehalt
    WHERE ArbeiterId = @ArbeiterId;

    PRINT 'ArbeiterId: ' + CAST(@ArbeiterId AS VARCHAR(10)) + ' , Neues Gehalt: ' + CAST(@NeuesGehalt AS VARCHAR(20));
END;


GO;

select * from Arbeiter;

DECLARE ArbeiterCursor CURSOR FOR
SELECT ArbeiterId
FROM Arbeiter;

OPEN ArbeiterCursor;

DECLARE @ArbeiterId INT;
DECLARE @Erhohungsfaktor DECIMAL(4, 2) = 1.10;

FETCH NEXT FROM ArbeiterCursor INTO @ArbeiterId;

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC UpdateArbeiterGehalt @ArbeiterId, @Erhohungsfaktor;

    FETCH NEXT FROM ArbeiterCursor INTO @ArbeiterId;
END

CLOSE ArbeiterCursor;
DEALLOCATE ArbeiterCursor;

select * from Arbeiter;