# Neo4j Exam Queries - Bilbase

## 1. Visualiser graf-skemaet

```cypher
// Viser alle node-labels, relationship-typer og hvordan de haenger sammen i grafen
CALL db.schema.visualization()
```

## 2. Collaborative Filtering - Anbefalinger til en bruger

```cypher
// Finder listings som lignende brugere har favoriseret, men som brugeren ikke selv har set endnu (collaborative filtering)
MATCH (u:User {id: 22})-[:FAVORITED]->(l:CarListing)<-[:FAVORITED]-(other:User)-[:FAVORITED]->(rec:CarListing)
WHERE NOT (u)-[:FAVORITED]->(rec)
      AND rec <> l
      AND NOT EXISTS { MATCH (s:Sale)-[:SALE_OF]->(rec) }
WITH rec, count(DISTINCT other) AS score
MATCH (rec)-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand)
RETURN rec.id AS listingId, b.name AS brand, m.name AS model,
       c.price AS pris, c.year AS aargang, score
ORDER BY score DESC, c.price ASC
LIMIT 10
```

## 3. Find lignende listings baseret paa brand, model eller region

```cypher
// Scorer andre aktive listings efter hvor mange attributter de deler med en given listing
MATCH (l:CarListing {id: 101})-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand),
      (l)-[:LOCATED_AT]->(a:Address)-[:IN_REGION]->(r:Region)
WITH l, b, m, r
MATCH (other:CarListing)-[:LISTS_CAR]->(oc:Car)-[:IS_MODEL]->(om:Model)-[:MADE_BY]->(ob:Brand),
      (other)-[:LOCATED_AT]->(oa:Address)-[:IN_REGION]->(oRegion:Region)
WHERE other.id <> l.id
      AND NOT EXISTS { MATCH (s:Sale)-[:SALE_OF]->(other) }
      AND (ob = b OR om = m OR oRegion = r)
WITH other, oc, om, ob, oRegion,
     CASE WHEN ob = b THEN 1 ELSE 0 END +
     CASE WHEN om = m THEN 1 ELSE 0 END +
     CASE WHEN oRegion = r THEN 1 ELSE 0 END AS commonAttributes
RETURN other.id AS listingId, ob.name AS brand, om.name AS model,
       oc.price AS pris, oc.year AS aargang, oRegion.name AS region,
       commonAttributes
ORDER BY commonAttributes DESC, oc.price ASC
LIMIT 10
```

## 4. Populaereste brands sorteret efter antal favoritter

```cypher
// Viser hvilke bilmaerker der er mest populaere baseret paa bruger-favoritter
MATCH (b:Brand)<-[:MADE_BY]-(m:Model)<-[:IS_MODEL]-(c:Car)<-[:LISTS_CAR]-(l:CarListing)
OPTIONAL MATCH (l)<-[f:FAVORITED]-()
WITH b, count(DISTINCT l) AS antalListings, count(DISTINCT f) AS antalFavoritter
RETURN b.name AS brand, antalListings, antalFavoritter
ORDER BY antalFavoritter DESC, antalListings DESC
```

## 5. Korteste sti mellem to brugere via favoritter

```cypher
// Finder den korteste forbindelse mellem to brugere gennem delte favoritter - viser hvordan brugere er forbundet i grafen
MATCH path = shortestPath(
  (u1:User {id: 22})-[:FAVORITED*..6]-(u2:User {id: 29})
)
RETURN path
```
