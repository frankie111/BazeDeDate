ALTER TABLE Arbeiter
ALTER COLUMN Gehalt DECIMAL(10, 2);

DECLARE ArbeiterCursor CURSOR FOR
SELECT ArbeiterId, Gehalt
FROM Arbeiter;

OPEN ArbeiterCursor;

DECLARE @ArbeiterId INT;
DECLARE @Gehalt INT;

FETCH NEXT FROM ArbeiterCursor INTO @ArbeiterId, @Gehalt;

DECLARE @Erhohungsfaktor DECIMAL(4, 2) = 1.10;

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @NeuesGehalt DECIMAL(10, 2);
	SET @NeuesGehalt = @Gehalt * @Erhohungsfaktor;

	UPDATE Arbeiter
	SET Gehalt = @NeuesGehalt
	WHERE ArbeiterId = @ArbeiterId;

	PRINT 'ArbeiterId: ' + CAST(@ArbeiterId AS VARCHAR(10)) + ' , Neues Gehalt: ' + CAST(@NeuesGehalt AS VARCHAR(20));

	FETCH NEXT FROM ArbeiterCursor INTO @ArbeiterId, @Gehalt;
END

CLOSE ArbeiterCursor;
DEALLOCATE ArbeiterCursor;

select * from Arbeiter;