CREATE DATABASE restaurant_db;

\c restaurant_db

CREATE TABLE foods (id SERIAL PRIMARY KEY,
name VARCHAR(255),
cuisine VARCHAR(255),
price FLOAT,
allergens VARCHAR(255),
spicy_level INTEGER);

CREATE TABLE parties (id SERIAL PRIMARY KEY,
table_number INTEGER,
guests INTEGER,
pay_status BOOLEAN);

CREATE TABLE orders (id SERIAL PRIMARY KEY,
food_id INTEGER,
party_id INTEGER);

-- psql < restaurant_db.sql