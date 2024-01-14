SELECT K.vorname, K.[name]
FROM Kunden AS K
JOIN KundenKredite AS KK ON K.kundeId = KK.kundeId
JOIN Kredite AS KR ON KK.kreditId = KR.kreditId
WHERE KR.wahrung = 'EUR' AND KR.betrag > 1000