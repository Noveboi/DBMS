/* 	
	1. Copy CSV contents to tables
   	2. Add constraints (PK, FK, ...)
*/
CREATE TABLE VesselTypes (
	code INTEGER,
	description TEXT
);
COPY VesselTypes FROM 'C:/Users/Public/dataset/VesselTypes.csv' WITH DELIMITER AS ',' CSV HEADER;

CREATE TABLE Vessels (
	id VARCHAR(64),
	type INTEGER,
	flag VARCHAR(32)
);
COPY Vessels FROM 'C:/Users/Public/dataset/Vessels.csv' WITH DELIMITER AS ',' CSV HEADER;

CREATE TABLE Positions (
	id INTEGER,
	vessel_id VARCHAR(64),
	t TIMESTAMP,
	lon DOUBLE PRECISION,
	lat DOUBLE PRECISION,
	heading INTEGER,
	course DOUBLE PRECISION,
	speed DOUBLE PRECISION
);
COPY Positions FROM 'C:/Users/Public/dataset/Positions.csv' WITH DELIMITER AS ',' CSV HEADER;

/* CONSTRAINTS */
ALTER TABLE VesselTypes ADD PRIMARY KEY (code);
ALTER TABLE Vessels ADD PRIMARY KEY (id);
ALTER TABLE Vessels ADD CONSTRAINT vesfk FOREIGN KEY (type) REFERENCES VesselTypes(code);
ALTER TABLE Positions ADD PRIMARY KEY (id);
ALTER TABLE Positions ADD CONSTRAINT posfk FOREIGN KEY (vessel_id) REFERENCES Vessels(id);