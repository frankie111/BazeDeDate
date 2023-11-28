CREATE TABLE ChangeLog (
	LogId INT IDENTITY(1, 1) PRIMARY KEY,
	ExecTimeStamp DATETIME,
	OperationType CHAR(1),
	TableName VARCHAR(50),
	AffectedRows INT
);


CREATE OR ALTER TRIGGER ArbeiterTrigger
ON Arbeiter
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @OperationType CHAR(1);
	DECLARE @AffectedRows INT = 0;

	IF EXISTS (SELECT * FROM inserted)
	BEGIN
		IF EXISTS (SELECT * FROM deleted)
			SET @OperationType = 'U';
		ELSE
			SET @OperationType = 'I';

	END
	ELSE
		SET @OperationType = 'D';


	IF @OperationType IN ('U', 'D')
		SELECT @AffectedRows = COUNT(*) FROM deleted;
	ELSE
        SELECT @AffectedRows = COUNT(*) FROM inserted;

	INSERT INTO ChangeLog (ExecTimeStamp, OperationType, TableName, AffectedRows)
	VALUES (GETDATE(), @OperationType, 'Arbeiter', @AffectedRows);

END;


INSERT INTO Arbeiter (ArbeiterId, FamilienName, Vorname, Position, Geburtsdatum)
VALUES (6, 'Mustermann', 'Max', 'Manager', '1990-01-01'),
	   (7, 'John', 'Doe', 'Koch', '1995-01-01');


UPDATE Arbeiter
SET Position = 'Supervisor'
WHERE Position = 'Manager';


DELETE FROM Arbeiter
WHERE FamilienName = 'Mustermann';

SELECT * FROM ChangeLog;

DELETE ChangeLog;