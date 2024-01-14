SELECT K.vorname
FROM Kunden AS K
JOIN KundenKredite AS KK ON K.kundeId = KK.kundeId
JOIN Kredite AS KR ON KK.kreditId = KR.kreditId
WHERE KR.wahrung = 'RON'
INTERSECT
SELECT K.vorname
FROM Kunden AS K
JOIN KundenKredite AS KK ON K.kundeId = KK.kundeId
JOIN Kredite AS KR ON KK.kreditId = KR.kreditId
WHERE KR.wahrung = 'EUR'