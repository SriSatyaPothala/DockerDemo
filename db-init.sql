CREATE TABLE profile (
  id SERIAL PRIMARY KEY,
  name TEXT,
  batch TEXT,
  email TEXT
);

INSERT INTO profile (name, batch, email) VALUES
('Sri Satya Pothala', 'DO-C-WD-E-15', 'satya.email@example.com');