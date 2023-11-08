CREATE PROCEDURE Setup
AS
BEGIN
	CREATE TABLE DatabaseVersion(CurrentVersion INT PRIMARY KEY);
	INSERT INTO DatabaseVersion (CurrentVersion) VALUES (1);

	CREATE TABLE VersionHistory(
		VersionId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		ProcedureName VARCHAR(128),
		Params VARCHAR(MAX)
	);
END;

GO

CREATE PROCEDURE RevertSetup
AS
BEGIN
	DROP TABLE DatabaseVersion;
	DROP TABLE VersionHistory;
END;

GO

CREATE PROCEDURE CreateTable(
	@TableName VARCHAR(128),
	@Columns VARCHAR(128),
	@addToVersionHistory BIT = 1
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = ' CREATE TABLE ' + @TableName + ' (' + @Columns + ')';
	PRINT @SQL;
	EXEC(@SQL);

	IF @addToVersionHistory = 1
		BEGIN
			INSERT INTO VersionHistory (ProcedureName, Params)
				VALUES ('CreateTable', @TableName + ', ' + @Columns);

			IF EXISTS (SELECT * FROM DatabaseVersion)
				UPDATE DatabaseVersion
				SET CurrentVersion = (SELECT MAX(VersionId) FROM VersionHistory)
			ELSE
				INSERT INTO DatabaseVersion
				VALUES ((SELECT MAX(VersionId) FROM VersionHistory))
		END;
END;

GO

CREATE PROCEDURE RevertCreateTable(
	@TableName VARCHAR(128)
) AS
BEGIN
	IF OBJECT_ID(@TableName, 'U') IS NOT NULL
	BEGIN
		DECLARE @SQL VARCHAR(MAX);
		SET @SQL = 'DROP TABLE ' + @TableName;
		PRINT @SQL;
		EXEC(@SQL);
	END
END;

GO

EXEC SetUp;
EXEC RevertSetup;

EXEC CreateTable 'TestTable', 'Id INT PRIMARY KEY, Name VARCHAR(128), Address VARCHAR(128)';

DECLARE @TableName VARCHAR(100);
SELECT @TableName = CAST(LEFT(Params, CHARINDEX(',', Params) - 1) AS VARCHAR) FROM VersionHistory;
EXEC RevertCreateTable @TableName;