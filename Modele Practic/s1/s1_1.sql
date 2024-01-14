CREATE TABLE Resorturi(
	resortId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	stele int,
	rating int
);

CREATE TABLE Cabane(
	cabanaId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	locuri int,
	pret int,
	resortId int FOREIGN KEY REFERENCES Resorturi(resortId),

);

CREATE TABLE Clienti(
	clientId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	dataNasterii date,
	tara varchar(40),
	cabanaId int FOREIGN KEY REFERENCES Cabane(cabanaId),
	dataCazarii date,
	numarNopti int

);

CREATE TABLE CategoriiActivitati(
	categorieId int NOT NULL PRIMARY KEY,
	nume varchar(40)
);

CREATE TABLE Activitati(
	activitateId int NOT NULL PRIMARY KEY,
	nume varchar(40),
	descriere varchar(100),
	pret int,
	categorieId int FOREIGN KEY REFERENCES CategoriiActivitati(categorieId)
);

CREATE TABLE ClientiActivitati(
	clientId int FOREIGN KEY REFERENCES Clienti(clientId),
	activitateId int FOREIGN KEY REFERENCES Activitati(activitateId),
	dataOra datetime,
	PRIMARY KEY (clientId, activitateId)
);
