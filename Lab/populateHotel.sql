-- Gäste
INSERT INTO Gäste (GastId, CNP, FamilienName, Vorname, Email, GeburtsDatum) VALUES
(1, 1001, 'Müller', 'Johannes', 'johannes.muller@example.com', '1985-08-12'),
(2, 1002, 'Schmidt', 'Anna', 'anna.schmidt@example.com', '1990-03-25'),
(3, 1003, 'Schneider', 'Lukas', 'lukas.schneider@example.com', '1979-11-08'),
(4, 1004, 'Fischer', 'Sophie', 'sophie.fischer@example.com', '1988-06-17'),
(5, 1005, 'Weber', 'Daniel', 'daniel.weber@example.com', '1995-02-04');

INSERT INTO Gäste (GastId, CNP, FamilienName, Vorname, Email, GeburtsDatum) VALUES
(6, 1006, 'Hans', 'Zimmer', 'zimmer.hans@gmail.com', '1982-09-29');

ALTER TABLE Gäste
ADD Geburtsdatum date;

UPDATE Gäste
SET Geburtsdatum = 
    CASE
        WHEN GastId = 1 THEN '1985-08-12'
        WHEN GastId = 2 THEN '1990-03-25'
        WHEN GastId = 3 THEN '1979-11-08'
		WHEN GastId = 4 THEN '1988-06-17'
		WHEN GastId = 5 THEN '1995-02-04'
		WHEN GastId = 6 THEN '1982-09-29'
    END;


-- Zimmer
INSERT INTO Zimmer (ZimmerNr, Typ, PreisProNacht) VALUES
(101, 'Einzelzimmer', 50),
(102, 'Doppelzimmer', 90),
(103, 'Suite', 150),
(104, 'Familienzimmer', 130),
(105, 'Deluxe', 200);

-- Buchungen
INSERT INTO Buchungen (BuchungId, GastId, CheckinDatum, checkoutDatum) VALUES
(1, 1, '2023-01-01', '2023-01-05'),
(2, 2, '2023-01-05', '2023-01-10'),
(3, 3, '2023-01-10', '2023-01-15'),
(4, 4, '2023-01-15', '2023-01-20'),
(5, 5, '2023-01-20', '2023-01-25');

INSERT INTO Buchungen (BuchungId, GastId, CheckinDatum, checkoutDatum) VALUES
(6, 2, '2023-10-23', '2023-10-30');

-- BuchungZimmer
INSERT INTO BuchungZimmer (BuchungId, ZimmerNr) VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);

INSERT INTO BuchungZimmer (BuchungId, ZimmerNr) VALUES
(1, 102),
(2, 103),
(1, 104);

-- Rechnungen
INSERT INTO Rechnungen (RechnungId, BuchungId, Datum, GesamtBetrag) VALUES
(1, 1, '2023-01-05', 250),
(2, 2, '2023-01-10', 450),
(3, 3, '2023-01-15', 750),
(4, 4, '2023-01-20', 650),
(5, 5, '2023-01-25', 1000);

INSERT INTO Rechnungen (RechnungId, BuchungId, Datum, GesamtBetrag) VALUES
(6, 6, '2023-10-23', 450);

-- Arbeiter
INSERT INTO Arbeiter (ArbeiterId, FamilienName, Vorname, Position, Geburtsdatum) VALUES
(1, 'König', 'Markus', 'Manager', '1980-05-05'),
(2, 'Wolff', 'Elena', 'Rezeptionist', '1990-03-03'),
(3, 'Berg', 'Michael', 'Koch', '1985-10-10'),
(4, 'Neumann', 'Lisa', 'Reinigung', '1995-02-02'),
(5, 'Hofmann', 'David', 'Security', '1987-09-09');

-- Zahlungen
INSERT INTO Zahlungen (ZahlungId, RechnungId, ArbeiterId, Betrag, ZahlungsDatum) VALUES
(1, 1, 2, 250, '2023-01-05'),
(2, 2, 2, 450, '2023-01-10'),
(3, 3, 2, 750, '2023-01-15'),
(4, 4, 2, 650, '2023-01-20'),
(5, 5, 2, 1000, '2023-01-25');

-- Dienstleistungen
INSERT INTO Dienstleistungen (DienstleistungId, Typ, Preis) VALUES
(1, 'Frühstück', 10),
(2, 'Abendessen', 20),
(3, 'Massage', 50),
(4, 'Fitnessraum', 15),
(5, 'Poolzugang', 5);

-- DienstleistungsBuchungen
INSERT INTO DienstleistungsBuchungen (DienstleistungsBuchungId, DienstleistungId, Betrag, BuchungId) VALUES
(1, 1, 10, 1),
(2, 2, 20, 2),
(3, 3, 50, 3),
(4, 4, 15, 4),
(5, 5, 5, 5);

INSERT INTO DienstleistungsBuchungen (DienstleistungsBuchungId, DienstleistungId, Betrag, BuchungId) VALUES
(6, 5, 5, 1);

-- Bewertungen
INSERT INTO Bewertungen (BewertungId, GastId, DienstleistungId, Bewertung, Kommentar) VALUES
(1, 1, 1, 4, 'Gutes Frühstück'),
(2, 2, 2, 5, 'Ausgezeichnetes Abendessen'),
(3, 3, 3, 3, 'Massage war okay'),
(4, 4, 4, 5, 'Toller Fitnessraum'),
(5, 5, 5, 4, 'Schöner Pool');

-- Angebote
INSERT INTO Angebote (AngebotId, ZimmerNr, Beschreibung, RabattProzentsatz, BeginnDatum, EndeDatum) VALUES
(1, 101, 'Sonderangebot für Einzelzimmer', 10, '2023-02-01', '2023-02-15'),
(2, 102, 'Rabatt auf Doppelzimmer', 15, '2023-02-10', '2023-02-20'),
(3, 103, 'Suite zum halben Preis', 50, '2023-03-01', '2023-03-10'),
(4, 104, 'Familienzimmer Angebot', 20, '2023-03-05', '2023-03-15'),
(5, 105, 'Deluxe Zimmer Sonderpreis', 30, '2023-04-01', '2023-04-10');
