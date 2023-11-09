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

CREATE PROCEDURE RevertSetUp
AS
BEGIN
	DROP TABLE CurrentVersion;
	DROP TABLE VersionHistory;
	DROP TABLE VersionParams;
END;


