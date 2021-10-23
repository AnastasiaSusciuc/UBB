CREATE DATABASE Bakery;
-- Clients - Order : one to many (a client can have many orders, an order has only one client)
-- Chief - Order: one to many (a chief is responsible for many orders, an order has only one responsible chief)
-- Chiefs - Baker: many to many (a chief supervises many bakers, a baker has many supervisors)
-- CookiePortion - Box: one to many (a box can have multiple cookie portions, a cookie portion can have only a box)
--  RedVelvetCake - CakeFrosting : many to many

CREATE TABLE Clients(
	client_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	phone_number VARCHAR,
)

CREATE TABLE BakeryOrder(
	order_id INT NOT NULL IDENTITY(1, 1),
	client_id INT PRIMARY KEY REFERENCES Clients(client_id),
	order_date DATETIME
)

CREATE TABLE Bakers (
	baker_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	phone_number VARCHAR
)

CREATE TABLE Chiefs (
	chief_id INT NOT NULL PRIMARY KEY,
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
	FOREIGN KEY (cake_id) REFERENCES RedVelvetCake(cake_id),
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



