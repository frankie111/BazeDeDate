CREATE OR ALTER FUNCTION dbo.ValidateName(@name VARCHAR(40))
RETURNS BIT
AS
BEGIN
	DECLARE @isValid BIT = 1;

	IF LEN(@name) < 1
		SET @isValid = 0;

	DECLARE @pattern VARCHAR(20) = '%[^a-zA-Z]%';

    IF @name LIKE '%[^a-zA-Z]%'
		SET @isValid = 0;

    RETURN @isValid;
END;

CREATE OR ALTER FUNCTION dbo.ValidateAge(@datum DATE)
RETURNS BIT
AS
BEGIN
	RETURN CASE WHEN DATEADD(YEAR, 18, @datum) <= GETDATE() THEN 1 ELSE 0 END;
END;

CREATE OR ALTER PROCEDURE InsertDataIntoArbeiter(
	@ArbeiterId INT,
	@FamilienName VARCHAR(40),
	@Vorname VARCHAR(40),
	@Position VARCHAR(40),
	@Geburtsdatum DATE
)
AS
BEGIN
	IF dbo.ValidateName(@FamilienName) = 1 AND dbo.ValidateName(@Vorname) = 1 AND dbo.ValidateAge(@Geburtsdatum) = 1
	BEGIN
		INSERT INTO Arbeiter (ArbeiterId, FamilienName, Vorname, Position, Geburtsdatum)
		VALUES (@ArbeiterId, @FamilienName, @Vorname, @Position, @Geburtsdatum);

		PRINT 'Data inserted successfully.';
	END
	ELSE 
	BEGIN
		PRINT 'Invalid Parameters. Insert failed.';
	END
END;

InsertDataIntoArbeiter 6, 'Mustermann', 'Max', 'Koch', '2000-03-12';