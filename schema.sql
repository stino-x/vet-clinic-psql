/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

----- TASK3 ------
-- Create the "owners" table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INTEGER
);

-- Create the "species" table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Remove existing "species" column
ALTER TABLE animals
DROP COLUMN species;

-- Add "species_id" column as a foreign key referencing the "species" table
ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add "owner_id" column as a foreign key referencing the "owners" table
ALTER TABLE animals
ADD COLUMN owner_id INTEGER REFERENCES owners(id);

-- Set "id" as an auto-incremented PRIMARY KEY
CREATE SEQUENCE animals_id_seq;
ALTER TABLE animals
ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');


