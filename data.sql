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

--- Task-3 ----

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


---- Task-4 -----
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('Vet William Tatcher', 45, '2000-04-23'),
    ('Vet Maisy Smith', 26, '2019-01-17'),
    ('Vet Stephanie Mendez', 64, '1981-05-04'),
    ('Vet Jack Harkness', 38, '2008-06-08');

-- Vet William Tatcher is specialized in Pokemon
INSERT INTO specializations (vet_id, species_id)
VALUES
    (1, 1); -- Vet William Tatcher (ID 1) is specialized in Pokemon (ID 1)

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon
INSERT INTO specializations (vet_id, species_id)
VALUES
    (3, 2), -- Vet Stephanie Mendez (ID 3) is specialized in Digimon (ID 2)
    (3, 1); -- Vet Stephanie Mendez (ID 3) is specialized in Pokemon (ID 1)

-- Vet Jack Harkness is specialized in Digimon
INSERT INTO specializations (vet_id, species_id)
VALUES
    (4, 2); -- Vet Jack Harkness (ID 4) is specialized in Digimon (ID 2)

-- Agumon visited William Tatcher on May 24th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (7, 1, '2020-05-24');

-- Agumon visited Stephanie Mendez on Jul 22th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (7, 3, '2020-07-22');

-- Gabumon visited Jack Harkness on Feb 2nd, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (2, 4, '2021-02-02');

-- Pikachu visited Maisy Smith on Jan 5th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 2, '2020-01-05');

-- Pikachu visited Maisy Smith on Mar 8th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 2, '2020-03-08');

-- Pikachu visited Maisy Smith on May 14th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 2, '2020-05-14');

-- Devimon visited Stephanie Mendez on May 4th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (4, 3, '2021-05-04');

-- Charmander visited Jack Harkness on Feb 24th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 4, '2021-02-24');

-- Plantmon visited Maisy Smith on Dec 21st, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (2, 2, '2019-12-21');

-- Plantmon visited William Tatcher on Aug 10th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (2, 1, '2020-08-10');

-- Plantmon visited Maisy Smith on Apr 7th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (2, 2, '2021-04-07');

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 3, '2019-09-29');

-- Angemon visited Jack Harkness on Oct 3rd, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (4, 4, '2020-10-03');

-- Angemon visited Jack Harkness on Nov 4th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (4, 4, '2020-11-04');

-- Boarmon visited Maisy Smith on Jan 24th, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (5, 2, '2019-01-24');

-- Boarmon visited Maisy Smith on May 15th, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (5, 2, '2019-05-15');

-- Boarmon visited Maisy Smith on Feb 27th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (5, 2, '2020-02-27');

-- Boarmon visited Maisy Smith on Aug 3rd, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (5, 2, '2020-08-03');

-- Blossom visited Stephanie Mendez on May 24th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 3, '2020-05-24');

-- Blossom visited William Tatcher on Jan 11th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 1, '2021-01-11');


