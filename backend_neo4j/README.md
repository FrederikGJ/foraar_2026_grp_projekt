# Bilbase Neo4j Backend

Standalone Spring Boot backend der eksponerer data fra Neo4j graf-databasen via REST endpoints.
Designet til demo i Postman — ingen authentication, ingen frontend-integration.

## Forudsætninger

- Java 21
- Maven 3.8+
- Neo4j container kørende (`bilbase-neo4j` på `bolt://localhost:7687`)
- Data migreret via `neo4j_migrator/`

## Start

```bash
cd backend_neo4j
mvn clean install -DskipTests
mvn spring-boot:run
```

Serveren starter på **port 8081** (konflikter ikke med MySQL-backend på 8080).

## Endpoints

### Listings

| Metode | URL | Beskrivelse |
|--------|-----|-------------|
| GET | `/api/neo4j/listings` | Alle aktive listings (ikke solgte) |
| GET | `/api/neo4j/listings/{id}` | Detaljer for én listing |
| GET | `/api/neo4j/listings/{id}/similar` | Lignende listings via graf-traversal |

### Brands & Regions

| Metode | URL | Beskrivelse |
|--------|-----|-------------|
| GET | `/api/neo4j/brands/{name}/listings` | Listings for et brand (f.eks. `/brands/BMW/listings`) |
| GET | `/api/neo4j/regions/{name}/listings` | Listings i en region (f.eks. `/regions/Hovedstaden/listings`) |

### Users

| Metode | URL | Beskrivelse |
|--------|-----|-------------|
| GET | `/api/neo4j/users/{id}/favorites` | Brugerens favoritter |
| GET | `/api/neo4j/users/{id}/messages` | Brugerens beskeder (sendt og modtaget) |
| GET | `/api/neo4j/users/{id}/recommendations` | Anbefalinger baseret på collaborative filtering |

### Statistik

| Metode | URL | Beskrivelse |
|--------|-----|-------------|
| GET | `/api/neo4j/stats/popular-brands` | Populære brands sorteret efter favorites |

## Postman Collection

Importér `postman/Bilbase-Neo4j.postman_collection.json` i Postman:

1. File → Import → vælg filen
2. Variablen `{{baseUrl}}` er sat til `http://localhost:8081`
3. Kør requests direkte — ingen auth nødvendig

## Cypher-highlights

Disse endpoints demonstrerer graf-databasens styrker:

- **`/listings/{id}/similar`** — finder lignende biler ved at traversere grafen via Brand, Model og Region-noder. Scorer resultater efter antal fælles attributter. I en relationel database ville dette kræve multiple JOINs og UNION-queries.

- **`/users/{id}/recommendations`** — collaborative filtering: "brugere der favoriserede samme listings som dig, favoriserede også disse." Multi-hop traversal (`User→FAVORITED→CarListing←FAVORITED←User→FAVORITED→CarListing`) der er naturlig i en graf men kompleks i SQL.

- **`/stats/popular-brands`** — aggregering på tværs af flere node-typer via graf-traversal fra Brand til favoritter.
