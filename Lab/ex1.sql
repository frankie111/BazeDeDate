--1/a
--Two tables, composite PK
CREATE TABLE Dienstleistungen(
	DienstleistungId int NOT NULL,
	Typ varchar(40),
	Preis int,
	PRIMARY KEY (DienstleistungId)
);

CREATE TABLE DienstleistungsBuchungen(
	GastId int,
	DienstleistungId int,
	BuchungsDatum date,
	Betrag int,
	BuchungId int,
	PRIMARY KEY (GastId, DienstleistungId),
	CONSTRAINT FK_DienstleistungsBuchungen_Gäste FOREIGN KEY (GastId) REFERENCES Gäste(GastId),
	CONSTRAINT FK_DienstleistungsBuchungen_Dienstleistungen FOREIGN KEY (DienstleistungId) REFERENCES Dienstleistungen(DienstleistungId),
	CONSTRAINT FK_DienstleistungsBuchungen_Buchungen FOREIGN KEY (BuchungId) REFERENCES Buchungen(BuchungId)
);


--1/b--------------------------------------------------------------
--inserting data
INSERT INTO Zimmer (ZimmerNr, Typ, PreisProNacht) VALUES
(101, 'Einzelzimmer', 50),
(102, 'Doppelzimmer', 90),
(103, 'Suite', 150),
(104, 'Familienzimmer', 130),
(105, 'Deluxe', 200);

INSERT INTO BuchungZimmer (BuchungId, ZimmerNr) VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);


--1/c--------------------------------------------------------------
--Invalid Foreign Key
INSERT INTO BuchungZimmer (BuchungId, ZimmerNr) VALUES
(-1, 301);


--1/d--------------------------------------------------------------
--Edit + Delete
--Edit the email of clients with the name "Müller", if they have an empty email or their email ends with "@gmail.com"
UPDATE Gäste
SET Email = 'neue.email@gmail.com'
WHERE FamilienName = 'Müller' AND (Email IS NULL OR Email LIKE '%@gmail.com');

-- Delete all rooms with numbers between 102 and 104, which aren't of type "Suite" or "Deluxe" and the price of which is NULL or > 100
DELETE FROM Zimmer
WHERE ZimmerNr BETWEEN 105 AND 107
AND Typ NOT IN ('Suite', 'Deluxe') 
AND (PreisProNacht IS NOT NULL AND PreisProNacht > 100);
