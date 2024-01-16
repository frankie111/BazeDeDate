CREATE TABLE Zugtypen(
	typId int NOT NULL PRIMARY KEY,
	beschreibung varchar(100)
);

CREATE TABLE Zuge(
	zugId int NOT NULL PRIMARY KEY,
	[name] varchar(40),
	typId int FOREIGN KEY REFERENCES zugtypen(typId)
);

CREATE TABLE Bahnhofe(
	bahnhofId int NOT NULL PRIMARY KEY,

);

CREATE TABLE Routen(
	routeId int NOT NULL PRIMARY KEY,
	[name] varchar(40),
	zugId int FOREIGN KEY REFERENCES Zuge(zugId)
);

CREATE TABLE RoutenBahnhofe(
	zugId int FOREIGN KEY REFERENCES Zuge(zugId),
	bahnhofId int FOREIGN KEY REFERENCES Bahnhofe(bahnhofId),
	ankunft time,
	abfahrt time
	PRIMARY KEY (zugId, bahnhofId)
);
