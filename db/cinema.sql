DROP TABLE screenings;
DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE customers(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
funds INT
);

CREATE TABLE films(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE screenings(
  id SERIAL PRIMARY KEY,
  screening_date VARCHAR(255),
  screening_time VARCHAR(255),
  ticket_id INT REFERENCES tickets(id) ON DELETE CASCADE,
  film_id INT REFERENCES film(id) ON DELETE CASCADE
);
