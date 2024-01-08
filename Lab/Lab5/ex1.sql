CREATE TABLE Ta (
	idA INT PRIMARY KEY,
	a2 INT UNIQUE,
	a3 INT
);


CREATE TABLE Tb (
	idB INT PRIMARY KEY,
	b2 INT,
	b3 INT
);

CREATE TABLE Tc (
	idC INT PRIMARY KEY,
	idA INT FOREIGN KEY REFERENCES Ta(idA),
	idB INT FOREIGN KEY REFERENCES Tb(idB)
);

GO;

CREATE OR ALTER PROCEDURE PopulateTables
AS
BEGIN
    DECLARE @counterA INT = 1;

    WHILE @counterA <= 10000
    BEGIN
        INSERT INTO Ta (idA, a2, a3)
        VALUES (@counterA, @counterA * 2, @counterA + 123);

        SET @counterA = @counterA + 1;
    END

    DECLARE @counterB INT = 1;

    WHILE @counterB <= 3000
    BEGIN
        INSERT INTO Tb (idB, b2, b3)
        VALUES (@counterB, @counterB * 3, @counterB + 10000);

        SET @counterB = @counterB + 1;
    END

    DECLARE @counterC INT = 1;

    WHILE @counterC <= 30000
    BEGIN
        DECLARE @idA INT = @counterC % 10000 + 1;
        DECLARE @idB INT = @counterC % 3000 + 1;

        INSERT INTO Tc (idC, idA, idB)
        VALUES (@counterC, @idA, @idB);

        SET @counterC = @counterC + 1;
    END
END;

EXEC PopulateTables;

SELECT * FROM Ta;
SELECT * FROM Tb;
SELECT * FROM Tc;

SELECT COUNT(*) FROM Ta;
SELECT COUNT(*) FROM Tb;
SELECT COUNT(*) FROM Tc;

DROP TABLE Tc;
DROP TABLE Ta;
DROP TABLE Tb;