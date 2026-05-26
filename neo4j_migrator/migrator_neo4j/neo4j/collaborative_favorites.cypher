// Ekstra favoritter der skaber overlap mellem brugere.
// Gør collaborative filtering muligt: "brugere der favoriserede denne, favoriserede også..."
//
// Strategi: grupper af brugere deler favoritter på tværs af brands/regioner.
// Bruger MATCH+MERGE så vi kun opretter relationer — aldrig fantom-noder.
// Hvis en CarListing ikke findes, springes den stille over.
//
// Listings 1-100 er alle solgt — bruges som bro.
// Listings 101+ er usolvte — disse bliver til anbefalinger.

// === Gruppe 1: Toyota-entusiaster ===
// Brugere 22, 23, 24 deler favoritter på Toyota-listings (solgte: bruges som bro)
MATCH (u:User {id: 23}), (l:CarListing {id: 1}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-01-15';
MATCH (u:User {id: 24}), (l:CarListing {id: 1}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-01-16';
MATCH (u:User {id: 22}), (l:CarListing {id: 2}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-01-17';
MATCH (u:User {id: 24}), (l:CarListing {id: 2}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-01-18';
MATCH (u:User {id: 22}), (l:CarListing {id: 3}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-01-19';
MATCH (u:User {id: 23}), (l:CarListing {id: 3}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-01-20';
MATCH (u:User {id: 22}), (l:CarListing {id: 5}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-01';
MATCH (u:User {id: 23}), (l:CarListing {id: 5}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-02';
MATCH (u:User {id: 24}), (l:CarListing {id: 5}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-03';
// Brugere 23, 24 favoriserer også usolvte listings (101+) — disse bliver anbefalinger til bruger 22
MATCH (u:User {id: 23}), (l:CarListing {id: 101}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-01';
MATCH (u:User {id: 23}), (l:CarListing {id: 110}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-02';
MATCH (u:User {id: 23}), (l:CarListing {id: 131}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-03';
MATCH (u:User {id: 24}), (l:CarListing {id: 101}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-04';
MATCH (u:User {id: 24}), (l:CarListing {id: 117}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-05';
MATCH (u:User {id: 24}), (l:CarListing {id: 135}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-06';

// === Gruppe 2: VW-fans ===
// Brugere 25, 26, 27, 28 deler favoritter på VW-listings
MATCH (u:User {id: 26}), (l:CarListing {id: 7}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-10';
MATCH (u:User {id: 27}), (l:CarListing {id: 7}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-11';
MATCH (u:User {id: 25}), (l:CarListing {id: 8}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-12';
MATCH (u:User {id: 27}), (l:CarListing {id: 8}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-13';
MATCH (u:User {id: 25}), (l:CarListing {id: 9}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-14';
MATCH (u:User {id: 26}), (l:CarListing {id: 9}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-15';
MATCH (u:User {id: 28}), (l:CarListing {id: 9}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-16';
MATCH (u:User {id: 25}), (l:CarListing {id: 10}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-17';
MATCH (u:User {id: 28}), (l:CarListing {id: 10}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-02-18';
// VW-fans favoriserer usolvte VW-listings
MATCH (u:User {id: 25}), (l:CarListing {id: 102}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-07';
MATCH (u:User {id: 26}), (l:CarListing {id: 102}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-08';
MATCH (u:User {id: 27}), (l:CarListing {id: 111}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-09';
MATCH (u:User {id: 28}), (l:CarListing {id: 118}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-10';
MATCH (u:User {id: 27}), (l:CarListing {id: 119}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-11';

// === Gruppe 3: Premium-segmentet (BMW + Mercedes) ===
// Brugere 29, 30, 31, 32 deler favoritter på tværs af BMW og Mercedes listings
MATCH (u:User {id: 30}), (l:CarListing {id: 21}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-01';
MATCH (u:User {id: 31}), (l:CarListing {id: 21}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-02';
MATCH (u:User {id: 29}), (l:CarListing {id: 22}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-03';
MATCH (u:User {id: 31}), (l:CarListing {id: 22}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-04';
MATCH (u:User {id: 32}), (l:CarListing {id: 22}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-05';
MATCH (u:User {id: 29}), (l:CarListing {id: 27}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-06';
MATCH (u:User {id: 30}), (l:CarListing {id: 27}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-07';
MATCH (u:User {id: 32}), (l:CarListing {id: 27}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-08';
MATCH (u:User {id: 29}), (l:CarListing {id: 28}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-09';
MATCH (u:User {id: 30}), (l:CarListing {id: 28}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-10';
MATCH (u:User {id: 31}), (l:CarListing {id: 28}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-03-11';
// Premium-brugere favoriserer usolvte BMW/Mercedes-listings
MATCH (u:User {id: 29}), (l:CarListing {id: 104}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-12';
MATCH (u:User {id: 30}), (l:CarListing {id: 104}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-13';
MATCH (u:User {id: 31}), (l:CarListing {id: 113}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-14';
MATCH (u:User {id: 32}), (l:CarListing {id: 113}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-15';
MATCH (u:User {id: 29}), (l:CarListing {id: 105}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-16';
MATCH (u:User {id: 30}), (l:CarListing {id: 122}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-17';
MATCH (u:User {id: 31}), (l:CarListing {id: 136}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-18';
MATCH (u:User {id: 32}), (l:CarListing {id: 125}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-19';

// === Gruppe 4: Kryds-brand interesse ===
// Brugere 22, 29, 35, 40 favoriserer listings på tværs af brands
// Forbinder Toyota-gruppen med Premium-gruppen
MATCH (u:User {id: 22}), (l:CarListing {id: 21}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-01';
MATCH (u:User {id: 22}), (l:CarListing {id: 27}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-02';
MATCH (u:User {id: 29}), (l:CarListing {id: 1}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-03';
MATCH (u:User {id: 29}), (l:CarListing {id: 5}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-04';
MATCH (u:User {id: 35}), (l:CarListing {id: 1}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-05';
MATCH (u:User {id: 35}), (l:CarListing {id: 21}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-06';
MATCH (u:User {id: 40}), (l:CarListing {id: 5}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-08';
MATCH (u:User {id: 40}), (l:CarListing {id: 27}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-09';
// Kryds-brand brugere favoriserer usolvte listings
MATCH (u:User {id: 35}), (l:CarListing {id: 106}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-20';
MATCH (u:User {id: 35}), (l:CarListing {id: 120}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-21';
MATCH (u:User {id: 35}), (l:CarListing {id: 140}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-22';
MATCH (u:User {id: 40}), (l:CarListing {id: 107}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-23';
MATCH (u:User {id: 40}), (l:CarListing {id: 130}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-24';
MATCH (u:User {id: 40}), (l:CarListing {id: 145}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-25';

// === Gruppe 5: El-bil entusiaster ===
// Brugere 33, 34, 36 deler favoritter på el/hybrid-listings
MATCH (u:User {id: 34}), (l:CarListing {id: 33}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-15';
MATCH (u:User {id: 36}), (l:CarListing {id: 33}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-16';
MATCH (u:User {id: 33}), (l:CarListing {id: 34}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-17';
MATCH (u:User {id: 36}), (l:CarListing {id: 34}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-18';
MATCH (u:User {id: 33}), (l:CarListing {id: 36}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-19';
MATCH (u:User {id: 34}), (l:CarListing {id: 36}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-04-20';
// El-bil brugere favoriserer usolvte el/hybrid-listings
MATCH (u:User {id: 33}), (l:CarListing {id: 119}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-26';
MATCH (u:User {id: 33}), (l:CarListing {id: 120}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-27';
MATCH (u:User {id: 34}), (l:CarListing {id: 143}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-28';
MATCH (u:User {id: 34}), (l:CarListing {id: 148}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-29';
MATCH (u:User {id: 36}), (l:CarListing {id: 119}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-30';
MATCH (u:User {id: 36}), (l:CarListing {id: 148}) MERGE (u)-[f:FAVORITED]->(l) SET f.createdAt = '2025-05-31';
