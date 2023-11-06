--1/a)
CREATE PROCEDURE ChangeColumntype(
	@TableName VARCHAR(128),
	@ColumnName VARCHAR(128),
	@NewDataType VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @TableName + ' ALTER COLUMN ' + @ColumnName + ' ' + @NewDataType;
	EXEC(@SQL);
END;

GO

CREATE PROCEDURE RevertChangeColumnType(
	@TableName VARCHAR(128),
	@ColumnName VARCHAR(128),
	@OldDataType VARCHAR(128)
) AS
BEGIN
	EXEC ChangeColumntype @TableName, @ColumnName, @OldDataType;
END;

EXEC ChangeColumntype 'Gäste', 'CNP', 'VARCHAR';
EXEC RevertChangeColumnType 'Gäste', 'CNP', 'INT';

GO

--1/b)
CREATE PROCEDURE CreateDefaultConstraint(
	@TableName VARCHAR(128),
	@ColumnName VARCHAR(128),
	@DefaultValue VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @TableName + ' ADD CONSTRAINT DF_' + @TableName + '_' + @ColumnName + ' DEFAULT ''' + @DefaultValue + ''' FOR ' + @ColumnName;
	PRINT @SQL;
	EXEC (@SQL);
END;

GO

CREATE PROCEDURE RevertCreateDefaultConstraint(
	@TableName VARCHAR(128),
	@columnName VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @TableName + ' DROP CONSTRAINT DF_' + @TableName + '_' + @columnName;
	PRINT @SQL;
	EXEC(@SQL);
END;

EXEC CreateDefaultConstraint 'Arbeiter', 'GeburtsDatum', '2000-01-01';
EXEC RevertCreateDefaultConstraint 'Arbeiter', 'GeburtsDatum';

GO

--1/c)
CREATE PROCEDURE CreateTable(
	@TableName VARCHAR(128),
	@Columns VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = ' CREATE TABLE ' + @TableName + ' (' + @Columns + ')';
	PRINT @SQL;
	EXEC(@SQL);
END;

GO

CREATE PROCEDURE DeleteTable(
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

EXEC CreateTable 'TestTable', 'ID INT PRIMARY KEY, Name VARCHAR(128), Age INT';
EXEC DeleteTable 'TestTable';

GO

--1/d)
CREATE PROCEDURE AddColumn(
	@TableName VARCHAR(128),
	@ColumnName VARCHAR(128),
	@ColumnType VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @TableName + ' ADD ' + @ColumnName + ' ' + @ColumnType;
	PRINT @SQL;
	EXEC(@SQL);
END;

GO

CREATE PROCEDURE RevertAddColumn(
	@TableName VARCHAR(128),
	@ColumnName VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @TableName + ' DROP COLUMN ' + @ColumnName;
	PRINT @SQL;
	EXEC(@SQL);
END;

EXEC CreateTable 'TestTable', 'ID INT PRIMARY KEY, Name VARCHAR(128), Age INT';
EXEC AddColumn 'TestTable', 'Address', 'INT';

EXEC RevertAddColumn 'TestTable', 'Address';
EXEC DeleteTable 'TestTable';

GO

--1/e)
CREATE PROCEDURE AddForeignkeyConstraint(
	@TableName VARCHAR(128),
	@ColumnName VARCHAR(128),
	@referencedTable VARCHAR(128),
	@referencedColumn VARCHAR(128)
) AS
BEGIN
	DECLARE @SQL VARCHAR(MAX);
	SET @SQL = 'ALTER TABLE ' + @TableName + ' ADD CONSTRAINT FK_' + @TableName + '_' + @ColumnName +
			   ' FOREIGN KEY (' + @ColumnName + ') REFERENCES ' + @referencedTable + '(' + @referencedColumn + ')';
	PRINT @SQL;
	EXEC(@SQL);
END;