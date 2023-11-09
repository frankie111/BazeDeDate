CREATE PROCEDURE SetUp
AS
BEGIN
	CREATE TABLE CurrentVersion (CurrentVersion INT PRIMARY KEY);
	INSERT INTO CurrentVersion (CurrentVersion) VALUES (0);

	CREATE TABLE VersionHistory(
		VersionId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		ProcedureName VARCHAR(128)
	);

	CREATE TABLE VersionParams(
		VersionId INT,
		ParamName VARCHAR(128),
		ParamValue VARCHAR(128),
		PRIMARY KEY (VersionId, ParamName),
		FOREIGN KEY (VersionId) REFERENCES VersionHistory(VersionId)
	);
END;

GO

CREATE PROCEDURE RevertSetUp
AS
BEGIN
	DROP TABLE CurrentVersion;
	DROP TABLE VersionHistory;
	DROP TABLE VersionParams;
END;

GO

CREATE PROCEDURE CreateTable(
	@tableName VARCHAR(128),
	@columns VARCHAR(MAX),
	@addToVersionHistory BIT = 1
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = ' CREATE TABLE ' + @tableName + ' (' + @columns + ')';
	PRINT @SQL;
	EXEC(@SQL);

	IF @addToVersionHistory = 1
	BEGIN
		INSERT INTO VersionHistory (ProcedureName) VALUES ('CreateTable');
		DECLARE @versionId INT = SCOPE_IDENTITY();

		INSERT INTO VersionParams (VersionId, ParamName, ParamValue) VALUES
			(@versionId, 'tableName', @tableName),
			(@versionId, 'columns', @columns);

		UPDATE CurrentVersion SET CurrentVersion = @versionId;
	END;
END;

GO

CREATE PROCEDURE RevertCreateTable(
	@tableName VARCHAR(128)
) AS
BEGIN
	IF OBJECT_ID(@tableName, 'U') IS NOT NULL
	BEGIN
		DECLARE @SQL VARCHAR(MAX);
		SET @SQL = 'DROP TABLE ' + @tableName;
		PRINT @SQL;
		EXEC (@SQL);
END;

GO

CREATE PROCEDURE AddColumn(
	@tableName VARCHAR(128),
	@columnName VARCHAR(128),
	@columnType VARCHAR(128),
	@addToVersionHistory BIT = 1
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @tableName + ' ADD ' + @columnName + ' ' + @columnType;
	PRINT @SQL;
	EXEC (@SQL);

	IF @addToVersionHistory = 1
	BEGIN
		INSERT INTO VersionHistory (ProcedureName) VALUES ('AddColumn');
		DECLARE @versionId INT = SCOPE_IDENTITY();

		INSERT INTO VersionParams (VersionId, ParamName, ParamValue) VALUES
			(@versionId, 'tableName', @tableName),
			(@versionId, 'columnName', @columnName),
			(@versionId, 'columnType', @columnType);

		UPDATE CurrentVersion SET CurrentVersion = @versionId;
	END
END;

GO

CREATE PROCEDURE RevertAddColumn(
	@tableName VARCHAR(128),
	@columnName VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @tableName + ' DROP COLUMN ' + @columnName;
	PRINT @SQL;
	EXEC (@SQL);
END;

GO

CREATE PROCEDURE ChangeColumnType(
	@tableName VARCHAR(128),
	@columnName VARCHAR(128),
	@newDataType VARCHAR(128),
	@addToVersionHistory BIT = 1
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @tableName + ' ALTER COLUMN ' + @columnName + ' ' + @newDataType;
	EXEC (@SQL);

	IF @addToVersionHistory = 1
	BEGIN
		INSERT INTO VersionHistory (ProcedureName) VALUES ('ChangeColumnType');
		DECLARE @versionId INT = SCOPE_IDENTITY();

		INSERT INTO VersionParams (VersionId, ParamName, ParamValue) VALUES
			(@versionId, 'tableName', @tableName),
			(@versionId, 'columnName', @columnName),
			(@versionId, 'newDataType', @newDataType);

		UPDATE CurrentVersion SET CurrentVersion = @versionId;
	END
END;

GO

CREATE PROCEDURE RevertChangeColumnType(
	@tableName VARCHAR(128),
	@columnName VARCHAR(128),
	@oldDataType VARCHAR(128)
) AS
BEGIN
	EXEC ChangeColumnType @tableName, @columnName, @oldDataType, 0;
END;

EXEC Setup;