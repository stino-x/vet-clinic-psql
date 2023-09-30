/*Queries that provide answers to the questions from all projects.*/

-- 1. Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- 2. List the names of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- 3. List the names of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- 4. List the date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- 5. List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- 6. Find all animals that are neutered
SELECT * FROM animals WHERE neutered = true;

-- 7. Find all animals not named Gabumon
SELECT * FROM animals WHERE name <> 'Gabumon';

-- 8. Find all animals with a weight between 10.4kg and 17.3kg (inclusive)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--- Task 2 ----

-- Start a transaction
BEGIN TRANSACTION;

-- Update animals with names ending in "mon" to have species as "digimon"
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update animals without a species to have species as "pokemon"
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Commit the transaction to save the changes
COMMIT;

-- Delete rows where the name is an empty string or NULL
DELETE FROM animals
WHERE name = '' OR name IS NULL;

-- Start a transaction
BEGIN TRANSACTION;

-- Delete all records in the animals table
DELETE FROM animals;

-- Roll back the transaction (undo the delete operation)
ROLLBACK;

-- Verify if all records in the animals table still exist
SELECT * FROM animals;

-- Start a transaction
BEGIN TRANSACTION;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) AS total_animals
FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS no_escape_animals
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight
FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


