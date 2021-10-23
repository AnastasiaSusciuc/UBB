CREATE DATABASE Bakery;
-- Clients - BakeryOrder : one to many (a client can have many orders, an order has only one client)
-- CookiePortion - Box: one to many (a box can have multiple cookie portions, a cookie portion can have only a box)
-- Chief - BakeryOrder: one to many (a chief is responsible for many orders, an order has only one responsible chief)
-- Chiefs - Baker: many to many (a chief supervises many bakers, a baker has many supervisors)
-- RedVelvetCake - CakeFrosting : many to many (a cake can have multiple frostings, a frosting can be on multiple cakes)

CREATE TABLE Clients(
	client_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	phone_number VARCHAR(15),
)

CREATE TABLE Chiefs (
	chief_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	phone_number VARCHAR
)

CREATE TABLE BakeryOrder(
	order_id INT NOT NULL IDENTITY(1, 1),
	client_id INT PRIMARY KEY REFERENCES Clients(client_id),
	order_date DATETIME DEFAULT GETDATE()
)

CREATE TABLE Bakers (
	baker_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	phone_number VARCHAR
)

CREATE TABLE BakersChiefsRelationships (
	chief_id INT NOT NULL,
	baker_id INT NOT NULL,
	FOREIGN KEY (chief_id) REFERENCES Chiefs(chief_id),
	FOREIGN KEY (baker_id) REFERENCES Bakers(baker_id),
	UNIQUE (chief_id, baker_id)
)

CREATE TABLE CakeFrosting(
	frosting_name VARCHAR(30) PRIMARY KEY,
	colour VARCHAR(30),
	base_ingredient VARCHAR(30)
)

CREATE TABLE RedVelvetCakes (
	cake_id INT NOT NULL PRIMARY KEY,
	portions INT,
	layers INT CHECK (layers BETWEEN 1 and 5),
	levels INT CHECK (levels BETWEEN 1 and 3), 
)

CREATE TABLE CakeFrostingRelationships (
	cake_id INT NOT NULL,
	frosting_name VARCHAR(30) NOT NULL,
	FOREIGN KEY (cake_id) REFERENCES RedVelvetCakes(cake_id),
	FOREIGN KEY (frosting_name) REFERENCES CakeFrosting(frosting_name),
	UNIQUE (cake_id, frosting_name)
)

CREATE TABLE Boxes (
	box_id INT PRIMARY KEY IDENTITY(1, 1),
	capacity INT,
	box_heigth INT,
	box_length INT,
	box_width INT,
)

CREATE TABLE CookiesPortion (
	filling VARCHAR(20),
	pieces INT CHECK (pieces BETWEEN 1 and 10),
	box_id INT FOREIGN KEY REFERENCES Boxes(box_id)
)

CREATE TABLE Coffee (
	beans_type VARCHAR(50),
	size INT,
	milk_type VARCHAR(20),
	spices VARCHAR(50),
)

-- Clients table population
ALTER TABLE Clients
ALTER COLUMN phone_number VARCHAR(15);

INSERT INTO Clients VALUES (1, 'Taylor', 'Smith', '0711111111')
INSERT INTO Clients VALUES (2, 'Wilson', 'Davis', '0722222222')
INSERT INTO Clients VALUES (3, 'Miller', 'ONeill', '0733333333')
INSERT INTO Clients VALUES (4, 'Rodriguez', 'Garcia', '0744444444')
INSERT INTO Clients VALUES (5, 'Jones', 'Williams', '0755555555')
INSERT INTO Clients VALUES (6, 'William', 'Anderson', '0766666666')
INSERT INTO Clients VALUES (7, 'Callum', 'Walsh', '0777777777')
INSERT INTO Clients VALUES (8, 'Charlie', 'Gelbero', '0788888888')
INSERT INTO Clients VALUES (9, 'Joe', 'Lee', '0799999999')
INSERT INTO Clients VALUES (10, 'Jake', 'Gagnon', '0711111112')

SELECT * FROM Clients

-- Chiefs table population

ALTER TABLE Chiefs
ALTER COLUMN phone_number VARCHAR(15);

INSERT INTO Chiefs VALUES (1, 'Taylor C.', 'Smith', '0711111111')
INSERT INTO Chiefs VALUES (2, 'Wilson C.', 'Davis', '0722222222')
INSERT INTO Chiefs VALUES (3, 'Miller C.', 'ONeill', '0733333333')
INSERT INTO Chiefs VALUES (4, 'Rodriguez C.', 'Garcia', '0744444444')
INSERT INTO Chiefs VALUES (5, 'Jones C.', 'Williams', '0755555555')
INSERT INTO Chiefs VALUES (6, 'William C.', 'Anderson', '0766666666')
INSERT INTO Chiefs VALUES (7, 'Callum C.', 'Walsh', '0777777777')
INSERT INTO Chiefs VALUES (8, 'Charlie C.', 'Gelbero', '0788888888')
INSERT INTO Chiefs VALUES (9, 'Joe C.', 'Lee', '0799999999')
INSERT INTO Chiefs VALUES (10, 'Jake C.', 'Gagnon', '0711111112')

SELECT * FROM Chiefs

-- BakeryOrder table population
ALTER TABLE BakeryOrder
ADD responsible_chief INT REFERENCES Chiefs(chief_id);

INSERT INTO BakeryOrder (client_id) VALUES (1)
SELECT * FROM BakeryOrder

select * from information_schema.columns where table_name = 'BakeryOrder'
