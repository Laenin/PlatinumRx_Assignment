CREATE TABLE clinics(
cid VARCHAR(50) PRIMARY KEY,
clinic_name VARCHAR(100),
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50)
);

CREATE TABLE customer(
uid VARCHAR(50) PRIMARY KEY,
name VARCHAR(100),
mobile VARCHAR(15)
);

CREATE TABLE clinic_sales(
oid VARCHAR(50) PRIMARY KEY,
uid VARCHAR(50),
cid VARCHAR(50),
amount DECIMAL(10,2),
datetime DATETIME,
sales_channel VARCHAR(50)
);

CREATE TABLE expenses(
eid VARCHAR(50) PRIMARY KEY,
cid VARCHAR(50),
description TEXT,
amount DECIMAL(10,2),
datetime DATETIME
);


-- sample data

INSERT INTO clinics VALUES
('c1','ABC Clinic','Chennai','Tamil Nadu','India'),
('c2','XYZ Clinic','Bangalore','Karnataka','India');

INSERT INTO customer VALUES
('u1','John','9876543210'),
('u2','Priya','9876500000');

INSERT INTO clinic_sales VALUES
('o1','u1','c1',2000,'2021-09-10','online'),
('o2','u2','c2',5000,'2021-09-15','offline'),
('o3','u1','c1',3000,'2021-10-10','online');

INSERT INTO expenses VALUES
('e1','c1','medicine',1000,'2021-09-10'),
('e2','c2','equipment',2000,'2021-09-15'),
('e3','c1','rent',1500,'2021-10-10');
