2.
SELECT *
FROM Studenten
WHERE Gruppe=331 OR Gruppe=332 / WHERE Gruppe IN (331, 332)

3.
SELECT *
FROM Studenten
WHERE Name LIKE 'An%'

SELECT *
FROM Studenten
WHERE Name LIKE 'An__'

4.
SELECT E.MatrNr
FROM Enrolled E
WHERE E.KursId="Alg1"

INTERSECT

SELECT E.MatrNr
FROM Enrolled E
WHERE E.KursId="DB1"



sau


SELECT DISTINCT E.MatrNr
FROM Enrolled E
WHERE E.KursId="Alg1" AND E.MatrNr IN (
					SELECT E1.MatrNr
					FROM Enrolled E1
					WHERE E1.KursId = "DB1"
					)


sau


SELECT DISTINCT E.MatrNr
FROM Enrolled E
WHERE E.KursId="Alg1" AND EXISTS (
					SELECT E1.MatrNr
					FROM Enrolled E1
					WHERE E1.KursId = "DB1" AND E.MatrNr=E1.KursId
					)