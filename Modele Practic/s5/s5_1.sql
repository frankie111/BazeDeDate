CREATE TABLE Sanger(
	sangerId int NOT NULL PRIMARY KEY,
	[name] varchar(40),
	herkunftsLand varchar(40),
	einstiegsJahr date
);

CREATE TABLE Genres(
	genreId int NOT NULL PRIMARY KEY,
	[name] varchar(40),
	popularitat int CHECK (popularitat >= 1 AND popularitat <= 5)
);

CREATE TABLE Lieder(
	liedId int NOT NULL PRIMARY KEY,
	titel varchar(40),
	dauer int,
	sangerId int FOREIGN KEY REFERENCES Sanger(sangerId)
);

CREATE TABLE LiedGenre(
	liedId int FOREIGN KEY REFERENCES Lieder(liedId),
	genreId int FOREIGN KEY REFERENCES Genres(genreId),
	PRIMARY KEY (liedId, genreId)
);

CREATE TABLE Playlists(
	playlistId int NOT NULL PRIMARY KEY,
	[name] varchar(40)
);

CREATE TABLE LiederPlaylists(
	playlistId int FOREIGN KEY REFERENCES Playlists(playlistId),
	liedId int FOREIGN KEY REFERENCES Lieder(liedId),
	PRIMARY KEY (playlistId, liedId)
);
