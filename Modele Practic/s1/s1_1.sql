CREATE TABLE CategoriiShows(
	categorieId int NOT NULL PRIMARY KEY,
	nume varchar(40)
);


CREATE TABLE AbonamenteTV(
	abonamentId int NOT NULL PRIMARY KEY,
	pret int
);

CREATE TABLE TVShows(
	tvShowId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	rating int,
	categorieId int FOREIGN KEY REFERENCES CategoriiShows(categorieId)
);

CREATE TABLE Actori(
	actorId int NOT NULL PRIMARY KEY
);

CREATE TABLE ActoriTVShows(
	actorId int FOREIGN KEY REFERENCES Actori(actorId),
	tvShowId int FOREIGN KEY REFERENCES TVShows(tvShowId),
	PRIMARY KEY (actorId, tvShowId)
);

CREATE TABLE Spectatori(
	spectatorId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	abonamentId int FOREIGN KEY REFERENCES AbonamenteTV(abonamentId)
);

CREATE TABLE SpectatoriTVShows(
	spectatorId int FOREIGN KEY REFERENCES Spectatori(spectatorId),
	tvShowId int FOREIGN KEY REFERENCES TVShows(tvShowId),
	PRIMARY KEY (spectatorId, tvShowId)
);