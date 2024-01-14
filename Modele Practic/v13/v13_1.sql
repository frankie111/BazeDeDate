CREATE TABLE Kunden(
	kundeId int NOT NULL PRIMARY KEY,
	[name] varchar(40),
	vorname varchar(40),
	cnp varchar(13) UNIQUE
);

CREATE TABLE Konten(
	kontoId int NOT NULL PRIMARY KEY,
	wahrung varchar(3),
	kontoNummer varchar(34),
	balance int
);

CREATE TABLE KundenKonten(
	kundeId int FOREIGN KEY REFERENCES Kunden(kundeId),
	kontoId int FOREIGN KEY REFERENCES Konten(kontoId),
);

CREATE TABLE Kredite(
	kreditId int NOT NULL PRIMARY KEY,
	wahrung varchar(3),
	laufzeit int
);

CREATE TABLE KundenKredite(
	kundeId int FOREIGN KEY REFERENCES Kunden(kundeId),
	kreditId int FOREIGN KEY REFERENCES Kredite(kreditId),
	betrag int,
	rate int
);