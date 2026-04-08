-- USERS TABLE
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ITEMS TABLE
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

-- BOOKING COMMERCIALS TABLE
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- SAMPLE DATA

INSERT INTO users VALUES
('u1','John Doe','9876543210','john@gmail.com','Chennai'),
('u2','Rahul','9876500000','rahul@gmail.com','Bangalore');

INSERT INTO bookings VALUES
('b1','2021-10-05 10:00:00','101','u1'),
('b2','2021-11-15 12:00:00','102','u2'),
('b3','2021-11-20 14:00:00','103','u1');

INSERT INTO items VALUES
('i1','Tawa Paratha',18),
('i2','Mix Veg',89),
('i3','Paneer Curry',150);

INSERT INTO booking_commercials VALUES
('c1','b1','bill1','2021-10-05 12:00:00','i1',10),
('c2','b2','bill2','2021-11-15 13:00:00','i2',5),
('c3','b3','bill3','2021-11-20 15:00:00','i3',8);
