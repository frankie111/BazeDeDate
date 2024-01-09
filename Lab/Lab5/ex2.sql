--2/a)
EXEC sys.sp_helpindex @objname = N'dbo.Ta';

SELECT * FROM Ta WHERE idA = 500;

SELECT idA, a2 FROM Ta WHERE a2 BETWEEN 1000 AND 2000;

SELECT a2 FROM Ta WHERE a2 < 5000 ORDER BY idA;

SELECT idA, a2 FROM Ta ORDER BY a2;


--2/b)
SELECT idA, a2, a3 FROM Ta WHERE a2 = 1000;


--2/c)
EXEC sys.sp_helpindex @objname = N'dbo.Tb';

SELECT idB, b2, b3 FROM Tb WHERE b2 = 201;
CREATE NONCLUSTERED INDEX I_b2 ON Tb(b2) INCLUDE (b3);
DROP INDEX Tb.I_b2;


--2/d)
SELECT Tc.idC, Ta.a2, Ta.a3
FROM Tc
JOIN Ta ON Tc.idA = Ta.idA
WHERE Tc.idA = 100;

SELECT Tc.idC, Tb.b2
FROM Tc
JOIN Tb ON Tc.idB = Tb.idB
WHERE Tc.idB = 100;

CREATE NONCLUSTERED INDEX I_idA ON Tc(idA);
CREATE NONCLUSTERED INDEX I_idB ON Tc(idB);

DROP INDEX Tc.I_idA;
DROP INDEX Tc.I_idB;