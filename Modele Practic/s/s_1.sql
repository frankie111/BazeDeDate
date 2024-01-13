CREATE TABLE Cantareti(
	cantaretId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	popularitate int
);

CREATE TABLE Cantece(
	cantecId int NOT NULL PRIMARY KEY,
	albumId int FOREIGN KEY REFERENCES Albume(albumId),
	titlu varchar(40),
	durata int
);

CREATE TABLE CanteceCantareti(
	cantecId int FOREIGN KEY REFERENCES Cantece(CantecId),
	cantaretId int FOREIGN KEY REFERENCES Cantareti(CantaretId),
	PRIMARY KEY (cantecId, cantaretId) 
);

CREATE TABLE CasaDiscuri(
	casaId int NOT NULL,
	rating int,
	PRIMARY KEY (casaId)
);

CREATE TABLE Albume(
	albumId int NOT NULL PRIMARY KEY,
	titlu varchar(40),
	dataLansare date,
	casaId int FOREIGN KEY REFERENCES CasaDiscuri(CasaId),
);

CREATE TABLE Videoclipuri(
	videoId int NOT NULL PRIMARY KEY,
	dataLansare date,
	cantecId int FOREIGN KEY REFERENCES Cantece(cantecId)
);

CREATE TABLE Concerte(
	concertId int NOT NULL,
	locatie varchar(40),
	dataOra datetime,
	PRIMARY KEY (concertId)
);

CREATE TABLE ConcerteCantareti(
	concertId int FOREIGN KEY REFERENCES Concerte(concertId),
	cantaretId int FOREIGN KEY REFERENCES Cantareti(cantaretId),
	PRIMARY KEY (concertId, cantaretId)
);