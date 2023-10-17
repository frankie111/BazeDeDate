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
	CONSTRAINT FK_DienstleistungsBuchungen_G�ste FOREIGN KEY (GastId) REFERENCES G�ste(GastId),
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
-- �ndere die Email-Adresse von G�sten mit dem Namen 'M�ller', die entweder kein Email haben oder deren Email mit '@gmail.com' endet.
UPDATE G�ste
SET Email = 'neue.email@gmail.com'
WHERE FamilienName = 'M�ller' AND (Email IS NULL OR Email LIKE '%@gmail.com');

-- L�sche alle Zimmer, die zwischen den Nummern 102 und 104 liegen, nicht im Typ 'Suite' oder 'Deluxe' sind und deren Preis entweder NULL ist oder �ber 100 liegt.
DELETE FROM Zimmer
WHERE ZimmerNr BETWEEN 102 AND 104 
AND Typ NOT IN ('Suite', 'Deluxe') 
AND (PreisProNacht IS NOT NULL AND PreisProNacht > 100);



--2--------------------------------------------------------------
