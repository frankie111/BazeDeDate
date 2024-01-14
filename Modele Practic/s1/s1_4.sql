SELECT C.nume, C.dataNasterii, C.tara
FROM Clienti AS C
join ClientiActivitati as CLA ON C.clientId = CLA.clientId
JOIN Activitati AS A ON CLA.activitateId = A.activitateId
JOIN CategoriiActivitati AS CA ON A.categorieId = CA.categorieId
WHERE CA.nume = 'sport'
AND
C.clientId NOT IN 
(
	SELECT C.clientId
	FROM Clienti AS C
	join ClientiActivitati as CLA ON C.clientId = CLA.clientId
	JOIN Activitati AS A ON CLA.activitateId = A.activitateId
	JOIN CategoriiActivitati AS CA ON A.categorieId = CA.categorieId
	WHERE CA.nume = 'relaxare'
)