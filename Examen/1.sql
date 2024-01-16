CREATE TABLE Kunden(
	kundeId int NOT NULL PRIMARY KEY,
	[name] varchar(40),
	email varchar(40),
	telefonNummer varchar(12)
);

CREATE TABLE Kuchen(
	kuchenId int NOT NULL PRIMARY KEY,
	[name] varchar(40),
	beschreibung varchar(100),

);

CREATE TABLE Zutaten(
	zutatId int NOT NULL PRIMARY KEY,
	[name] varchar(10),
	masseinheit varchar(10)
);

CREATE TABLE KuchenZutaten(
	kuchenId int FOREIGN KEY REFERENCES Kuchen(kuchenId),
	zutatId int FOREIGN KEY REFERENCES Zutaten(zutatId),
	PRIMARY KEY (KuchenId, zutatId),
	quantitat int
);

CREATE TABLE Menus(
	menuId int NOT NULL PRIMARY KEY,
	kundeId int FOREIGN KEY REFERENCES Kunden(kundeId),
	thema varchar(40),
	datum date
);

CREATE TABLE MenuKuchen(
	menuId int FOREIGN KEY REFERENCES Menus(menuId),
	kuchenId int FOREIGN KEY REFERENCES Kuchen(kuchenId),
	PRIMARY KEY(menuId, kuchenId),
	menge int
);