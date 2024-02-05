/* Δημιουργία πίνακα διαμέρισης */
CREATE TABLE Positions_Hash_Partition (
	id INTEGER PRIMARY KEY,
	vessel_id VARCHAR(64),
	t TIMESTAMP,
	lon DOUBLE PRECISION,
	lat DOUBLE PRECISION,
	heading INTEGER,
	course DOUBLE PRECISION,
	speed DOUBLE PRECISION
) PARTITION BY HASH (id);

/* Δημιουργία υποπινάκων */
CREATE TABLE Positions_Part1 
PARTITION OF Positions_Hash_Partition
FOR VALUES WITH (MODULUS 4, REMAINDER 0);

CREATE TABLE Positions_Part2
PARTITION OF Positions_Hash_Partition
FOR VALUES WITH (MODULUS 4, REMAINDER 1);

CREATE TABLE Positions_Part3
PARTITION OF Positions_Hash_Partition
FOR VALUES WITH (MODULUS 4, REMAINDER 2);

CREATE TABLE Positions_Part4
PARTITION OF Positions_Hash_Partition
FOR VALUES WITH (MODULUS 4, REMAINDER 3);

/* Δημιουργία index */
CREATE INDEX pos_part1_t_index ON Positions_Part1 (t);
CREATE INDEX pos_part1_speed_index ON Positions_Part1 (speed);

CREATE INDEX pos_part2_t_index ON Positions_Part2 (t);
CREATE INDEX pos_part2_speed_index ON Positions_Part2 (speed);

CREATE INDEX pos_part3_t_index ON Positions_Part3 (t);
CREATE INDEX pos_part3_speed_index ON Positions_Part3 (speed);

CREATE INDEX pos_part4_t_index ON Positions_Part4 (t);
CREATE INDEX pos_part4_speed_index ON Positions_Part4 (speed);

/* Γέμισμα πινάκων */
INSERT INTO Positions_Hash_Partition
SELECT * FROM Positions;

