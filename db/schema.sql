CREATE DATABASE winelovers;

CREATE TABLE winers (
  id SERIAL PRIMARY KEY,
  name TEXT,
  last TEXT,
  email TEXT,
  password_digest TEXT
);
