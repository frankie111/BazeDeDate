--2.
SELECT M.thema, M.datum
FROM MenuKuchen AS MK
JOIN Menus AS M ON MK.menuId = M.menuId
JOIN Kuchen AS K ON MK.kuchenId = K.kuchenId
WHERE K.[name] = 'Himbeertraum'
INTERSECT
SELECT M.thema, M.datum
FROM MenuKuchen AS MK
JOIN Menus AS M ON MK.menuId = M.menuId
JOIN Kuchen AS K ON MK.kuchenId = K.kuchenId
WHERE K.[name] = 'Schokoladenmousse'

--3.
SELECT K.[name], K.beschreibung, COUNT(KZ.zutatId) AS ZutatenNummer
FROM Kuchen AS K
JOIN KuchenZutaten AS KZ ON K.kuchenId = KZ.kuchenId
GROUP BY K.[name], K.beschreibung
HAVING COUNT(KZ.zutatId) = (SELECT MIN(subq.ZutatenNummer)
FROM
	(
	SELECT COUNT(KZ.zutatId) AS ZutatenNummer
	FROM Kuchen AS K
	JOIN KuchenZutaten AS KZ ON K.kuchenId = KZ.kuchenId
	GROUP BY K.kuchenId
	) as subq
)
