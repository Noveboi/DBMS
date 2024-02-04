import psycopg2 as pg

def create_partition_per_day(partitions):
    conn = pg.connect('dbname=db2_testing user=postgres password=1314 port=5433')
    cur = conn.cursor()

    cur.execute("""
                DROP TABLE IF EXISTS Positions_t_partition;
                CREATE TABLE Positions_t_partition (
                    id INTEGER,
                    vessel_id VARCHAR(64),
                    t TIMESTAMP,
                    lon DOUBLE PRECISION,
                    lat DOUBLE PRECISION,
                    heading INTEGER,
                    course DOUBLE PRECISION,
                    speed DOUBLE PRECISION,
                    primary key (id, t)
                ) PARTITION BY RANGE (t);
    """)

    partition_step = 30//partitions
    for i in range(1, partitions + 1):
        start_day = (i - 1)*partition_step + 1 if i > 1 else 1
        end_day = (i)*partition_step if i > 1 else 1 + partition_step
        if end_day > 31: 
            end_day = 31
        print(f"Creating partition #{i} (day {start_day} - day {end_day})")
        sql = f"""
            DROP TABLE IF EXISTS Positions_Dates{i};
            CREATE TABLE Positions_Day{i}
            PARTITION OF Positions_t_partition
            FOR VALUES FROM ('2019-08-{start_day:02d} 00:00:00') TO ('2019-08-{end_day:02d} 00:00:00');
        """
        index = f"""
            DROP INDEX IF EXISTS posdates{i};
            CREATE INDEX posday{i} ON Positions_Day{i} (t);
        """
        cur.execute(sql)
        cur.execute(index)
    print("Copying from positions...")
    cur.execute("INSERT INTO Positions_t_partition SELECT * FROM Positions")
    print("Done")
    conn.commit()
    conn.close()

create_partition_per_day(3)