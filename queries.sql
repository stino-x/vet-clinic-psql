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

UPDATE animals
SET species = 'unspecified';

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





---TASK 3 -----
-- What animals belong to Melody Pond?
SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those who don't own any animal.
SELECT o.full_name, COALESCE(array_agg(a.name), ARRAY[]::VARCHAR[]) AS owned_animals
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name;

-- How many animals are there per species?
SELECT s.name AS species, COUNT(*) AS animal_count
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

--TASK-4 ---

-- 1. Who was the last animal seen by William Tatcher?
SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 1
ORDER BY v.visit_date DESC
LIMIT 1;

-- 2. How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id)
FROM visits v
WHERE v.vet_id = 3;

-- 3. List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.name AS specialty
FROM vets v
LEFT JOIN specializations vs ON v.id = vs.vet_id
LEFT JOIN species s ON vs.species_id = s.id;

-- 4. List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 3
  AND v.visit_date >= '2020-04-01'
  AND v.visit_date <= '2020-08-30';

-- 5. What animal has the most visits to vets?
SELECT a.name, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

-- 6. Who was Maisy Smith's first visit?
SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 2
ORDER BY v.visit_date
LIMIT 1;

-- 7. Details for the most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, vet.name AS vet_name, v.visit_date
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vet ON v.vet_id = vet.id
WHERE v.visit_date = (SELECT MAX(visit_date) FROM visits);


-- 8. How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits v
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations vs ON v.vet_id = vs.vet_id AND a.species_id = vs.species_id
WHERE vs.species_id IS NULL;

-- 9. What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS specialty
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN specializations vs ON v.vet_id = v.vet_id
JOIN species s ON vs.species_id = s.id
WHERE v.vet_id = 2
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;




