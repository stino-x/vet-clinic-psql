/* Populate database with sample data. */

-- Inserting the first animal (Agumon)
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', '2020-02-03', 10.23, true, 0);

-- Inserting the second animal (Gabumon)
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Gabumon', '2018-11-15', 8.0, true, 2);

-- Inserting the third animal (Pikachu)
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Pikachu', '2021-01-07', 15.04, false, 1);

-- Inserting the fourth animal (Devimon)
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Devimon', '2017-05-12', 11.0, true, 5);

---- TASK 2-------

-- Inserting the first animal (Charmander) with a negative weight
INSERT INTO animals (name, id, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Charmander',1, '2020-02-08', -11.0, false, 0, 'Fire-type');

-- Inserting the second animal (Plantmon) with a negative weight
INSERT INTO animals (name, id, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Plantmon', 2, '2021-11-15', -5.7, true, 2, 'Grass-type');

-- Inserting the third animal (Squirtle) with a negative weight
INSERT INTO animals (name, id, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Squirtle', 3, '1993-04-02', -12.13, false, 3, 'Water-type');

-- Inserting the fourth animal (Angemon) with a negative weight
INSERT INTO animals (name, id, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Angemon',  4,'2005-06-12', -45.0, true, 1, 'Holy-type');

-- Inserting the fifth animal (Boarmon)
INSERT INTO animals (name, id, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Boarmon',  5,'2005-06-07', 20.4, true, 7, 'Ground-type');

-- Inserting the sixth animal (Blossom)
INSERT INTO animals (name, id, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Blossom',  6,'1998-10-13', 17.0, true, 3, 'Grass-type');

-- Inserting the seventh animal (Ditto)
INSERT INTO animals (name, id, date_of_birth, weight_kg, neutered, escape_attempts, species)
VALUES ('Ditto', 7, '2022-05-14', 22.0, true, 4, 'Normal-type');

--- Task-4 ----

-- Insert data into the "owners" table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

-- Insert data into the "species" table
INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');


-- Update animals to include species_id based on name
UPDATE animals
SET species_id = (CASE
WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon')
                 END);

-- Update animals to include owner_id based on name
UPDATE animals
SET owner_id = (CASE
WHEN name IN ('Agumon') THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
                END);

