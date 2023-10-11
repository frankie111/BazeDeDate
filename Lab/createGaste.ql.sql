CREATE TABLE Gäste(
	GastId int NOT NULL,
	CNP int,
	FamilienName varchar(40),
	Vorname varchar(40),
	Email varchar(40),
	PRIMARY KEY (GastId)
);

CREATE TABLE Zimmer(
	ZimmerNr int NOT NULL,
	Typ varchar(40),
	PreisProNacht int,
	PRIMARY KEY (ZimmerNr)
);

CREATE TABLE Buchungen(
	BuchungId int NOT NULL,
	GastId int,
	CheckinDatum date,
	checkoutDatum date,
	PRIMARY KEY (BuchungId),
	FOREIGN KEY (GastId) REFERENCES Gäste(GastId),
);

CREATE TABLE BuchungZimmer (
	BZId int NOT NULL,
	BuchungId int,
	ZimmerNr int,
	PRIMARY KEY (BZId),
	FOREIGN KEY (BuchungId) REFERENCES Buchungen(BuchungId),
	FOREIGN KEY (ZimmerNr) REFERENCES Zimmer(ZimmerNr)
);

CREATE TABLE Rechnungen (
	RechnungId int NOT NULL,
	BuchungId int,
	Datum date,
	GesamtBetrag int,
	istBezahlt bit,
	PRIMARY KEY (RechnungId),
	FOREIGN KEY (BuchungId) REFERENCES Buchungen(BuchungId)
);

CREATE TABLE Arbeiter(
	ArbeiterId int NOT NULL,
	FamilienName varchar(40),
	Vorname varchar(40),
	Position varchar(40),
	PRIMARY KEY (ArbeiterId)
);

CREATE TABLE Zahlungen(
	ZahlungId int NOT NULL,
	RechnungId int,
	ArbeiterId int,
	Betrag int,
	ZahlungsDatum date,
	PRIMARY KEY (ZahlungId),
	FOREIGN KEY (RechnungId) REFERENCES Rechnungen(RechnungId),
	FOREIGN KEY (ArbeiterId) REFERENCES Arbeiter(ArbeiterId)
);

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
	PRIMARY KEY (GastId, DienstleistungId),
	FOREIGN KEY (GastId) REFERENCES Gäste(GastId),
	FOREIGN KEY (DienstleistungId) REFERENCES Dienstleistungen(DienstleistungId)
);

CREATE TABLE Bewertungen(
	BewertungId int NOT NULL,
	GastId int,
	DienstleistungId int,
	Bewertung int,
	Kommentar varchar(256),
	PRIMARY KEY (BewertungId),
	FOREIGN KEY (GastId) REFERENCES Gäste(GastId),
	FOREIGN KEY (DienstleistungId) REFERENCES Dienstleistungen(DienstleistungId)
); 

CREATE TABLE Angebote(
	AngebotId int NOT NULL,
	ZimmerNr int,
	Beschreibung varchar(256),
	RabattProzentsatz int,
	BeginnDatum date,
	EndeDatum date
	PRIMARY KEY (AngebotId),
	FOREIGN KEY (ZimmerNr) REFERENCES Zimmer(ZimmerNr)
);