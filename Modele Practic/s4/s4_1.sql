CREATE TABLE Bands(
	bandId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	scor int
);

CREATE TABLE GenuriMuzicale(
	genId int NOT NULL PRIMARY KEY,
	nume varchar(40)
);

CREATE TABLE Cantece(
	cantecId int NOT NULL PRIMARY KEY,
	titlu varchar(40),
	numeBand varchar(40),
	genId int FOREIGN KEY REFERENCES GenuriMuzicale(genId)
);

CREATE TABLE Concurenti(
	concurentId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	varsta int,
	bandId int FOREIGN KEY REFERENCES Bands(bandId)

);

CREATE TABLE Instrumente(
	instrumentId int NOT NULL PRIMARY KEY,
	nume varchar(40)
);

CREATE TABLE InstrumenteCantareti(
	instrumentId int FOREIGN KEY REFERENCES Instrumente(instrumentId),
	cantaretId int FOREIGN KEY REFERENCES Concurenti(concurentId),
	PRIMARY KEY (instrumentId, cantaretId)
);

CREATE TABLE Dueluri(
	duelId int NOT NULL PRIMARY KEY,
	cantecId int FOREIGN KEY REFERENCES Cantece(cantecId),
	firstBandId int FOREIGN KEY REFERENCES Bands(bandId),
	secondBandId int FOREIGN KEY REFERENCES Bands(bandId),
	castigatorBandId int FOREIGN KEY REFERENCES Bands(bandId),
	etapa int
);