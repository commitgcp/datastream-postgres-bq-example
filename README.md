1. Get db password from secret manager
```
gcloud secrets versions access latest --secret=postgres-db-password
```

1. connect to the db
```
gcloud sql connect postgres-instance --user=postgres
```

2. Create sample DB
```
CREATE SCHEMA IF NOT EXISTS testing;
CREATE TABLE IF NOT EXISTS testing.example_table (
id  SERIAL PRIMARY KEY,
text_col VARCHAR(50),
int_col INT,
date_col TIMESTAMP
);
ALTER TABLE testing.example_table REPLICA IDENTITY DEFAULT; 
INSERT INTO testing.example_table (text_col, int_col, date_col) VALUES
('hello', 0, '2020-01-01 00:00:00'),
('goodbye', 1, NULL),
('name', -987, NOW()),
('other', 2786, '2021-01-01 00:00:00');
```

3. Create publication and replication slot
```
CREATE PUBLICATION publication FOR ALL TABLES;
ALTER USER POSTGRES WITH REPLICATION;
SELECT PG_CREATE_LOGICAL_REPLICATION_SLOT('replication_slot', 'pgoutput');
```