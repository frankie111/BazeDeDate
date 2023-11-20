EXEC Initialize;

EXEC CreateTable 'T1', 'Id INT PRIMARY KEY, Name VARCHAR(128)';
EXEC AddColumn 'T1', 'Age', 'INT';
EXEC ChangeColumnType 'T1', 'Name', 'CHAR(64)';
EXEC CreateDefaultConstraint 'T1', 'Age', 0;
EXEC CreateDefaultConstraint 'T1', 'Name', 'test';
EXEC CreateTable 'T2', 'Id INT PRIMARY KEY, Address VARCHAR(128)';
EXEC AddColumn 'T2', 'T1Id', 'INT';
EXEC AddForeignkeyConstraint 'T2', 'T1Id', 'T1', 'Id';

SELECT * FROM CurrentVersion;
SELECT * FROM VersionHistory;
SELECT * FROM VersionParams;


EXEC GoToVersion 7;
EXEC GoToVersion 5;
EXEC GoToVersion 0;

EXEC GoToVersion 2;
EXEC GoToVersion 8;

EXEC RevertInit;

EXEC RevertCreateTable 'T2';
EXEC RevertCreateTable 'T1';