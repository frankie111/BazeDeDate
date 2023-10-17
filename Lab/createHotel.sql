CREATE TABLE Gäste(
	GastId int NOT NULL,
	CNP int UNIQUE,
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
	CONSTRAINT FK_Buchungen_Gäste FOREIGN KEY (GastId) REFERENCES Gäste(GastId)
);

CREATE TABLE BuchungZimmer (
	BuchungId int,
	ZimmerNr int,
	PRIMARY KEY (BuchungId, ZimmerNr),
	CONSTRAINT FK_BuchungZimmer_Buchungen FOREIGN KEY (BuchungId) REFERENCES Buchungen(BuchungId),
	CONSTRAINT FK_BuchungZimmer_Zimmer FOREIGN KEY (ZimmerNr) REFERENCES Zimmer(ZimmerNr)
);

CREATE TABLE Rechnungen (
	RechnungId int NOT NULL,
	BuchungId int,
	Datum date,
	GesamtBetrag int,
	PRIMARY KEY (RechnungId),
	CONSTRAINT FK_Rechnungen_Buchungen FOREIGN KEY (BuchungId) REFERENCES Buchungen(BuchungId)
);

CREATE TABLE Arbeiter(
	ArbeiterId int NOT NULL,
	FamilienName varchar(40),
	Vorname varchar(40),
	Position varchar(40),
	Geburtsdatum date,
	PRIMARY KEY (ArbeiterId)
);

CREATE TABLE Zahlungen(
	ZahlungId int NOT NULL,
	RechnungId int,
	ArbeiterId int,
	Betrag int,
	ZahlungsDatum date,
	PRIMARY KEY (ZahlungId),
	CONSTRAINT FK_Zahlungen_Rechnungen FOREIGN KEY (RechnungId) REFERENCES Rechnungen(RechnungId),
	CONSTRAINT FK_Zahlungen_Arbeiter FOREIGN KEY (ArbeiterId) REFERENCES Arbeiter(ArbeiterId)
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
	BuchungId int,
	PRIMARY KEY (GastId, DienstleistungId),
	CONSTRAINT FK_DienstleistungsBuchungen_Gäste FOREIGN KEY (GastId) REFERENCES Gäste(GastId),
	CONSTRAINT FK_DienstleistungsBuchungen_Dienstleistungen FOREIGN KEY (DienstleistungId) REFERENCES Dienstleistungen(DienstleistungId),
	CONSTRAINT FK_DienstleistungsBuchungen_Buchungen FOREIGN KEY (BuchungId) REFERENCES Buchungen(BuchungId)
);

CREATE TABLE Bewertungen(
	BewertungId int NOT NULL,
	GastId int,
	DienstleistungId int,
	Bewertung int,
	Kommentar varchar(256),
	PRIMARY KEY (BewertungId),
	CONSTRAINT FK_Bewertungen_Gäste FOREIGN KEY (GastId) REFERENCES Gäste(GastId),
	CONSTRAINT FK_Bewertungen_Dienstleistungen FOREIGN KEY (DienstleistungId) REFERENCES Dienstleistungen(DienstleistungId)
);

CREATE TABLE Angebote(
	AngebotId int NOT NULL,
	ZimmerNr int,
	Beschreibung varchar(256),
	RabattProzentsatz int,
	BeginnDatum date,
	EndeDatum date
	PRIMARY KEY (AngebotId),
	CONSTRAINT FK_Angebote_Zimmer FOREIGN KEY (ZimmerNr) REFERENCES Zimmer(ZimmerNr)
);

