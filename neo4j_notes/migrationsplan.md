# Migrationsplan: MySQL → Neo4j
## Bilbase — parallel multi-database arkitektur

Denne plan dækker Neo4j-søjlen i den fælles Spring Boot backend samt den tilhørende
migrerings-applikation. MongoDB-søjlen og dens migrator er et separat ansvar.

---

## 0. Mål og scope

**In scope**
- Neo4j node-modeller og repositories under `dk.bilbase.backend.neo4j`
- REST-endpoints på `/neo4j/...` præfikset
- Migrerings-applikation i `migrator_neo4j/` (MySQL → Neo4j, én-gangs kørsel)
- Constraints og indexes i Neo4j
- Forretningsvalidering der erstatter MySQL-triggers for Neo4j-søjlen

**Out of scope**
- MySQL-søjlen (`dk.bilbase.backend.mysql`) — rører ikke eksisterende kode
- MongoDB-søjlen — håndteres af anden gruppemedlem
- Fælles DTOs, Swagger-opsætning, docker-compose grundstruktur — aftales på tværs af gruppen
- To-vejs synkronisering mellem databaser
- Produktionsmiljø (Neo4j AuraDB cloud deployment aftales separat)

---

## 1. Arkitektur og mappestruktur

Neo4j-søjlen lever som et selvstændigt lag i den eksisterende backend. Ingen eksisterende
kode røres — alt nyt kode placeres i nye pakker.

```
backend/src/main/java/dk/bilbase/backend/
├── mysql/                         ← urørt (eksisterende kode)
│   ├── domain/
│   ├── repository/
│   └── web/
├── mongodb/                       ← anden gruppemedlems ansvar
│   └── ...
├── neo4j/                         ← dette scope
│   ├── node/                      (Neo4j @Node klasser)
│   ├── repository/                (Neo4jRepository interfaces)
│   ├── service/                   (Neo4j-specifik forretningslogik)
│   └── web/                       (controllers med /neo4j prefix)
├── dto/                           ← delte DTOs (aftales på tværs)
└── config/
    └── Neo4jConfig.java           (datasource-konfiguration)

migrator_neo4j/                    ← selvstændigt Maven-projekt
├── pom.xml
├── README.md
└── src/main/java/dk/bilbase/migrator/neo4j/
    ├── MigrationMain.java
    ├── MigrationRunner.java
    └── migrators/
        ├── Migrator.java          (interface)
        ├── RegionMigrator.java
        ├── BrandMigrator.java
        ├── ModelMigrator.java
        ├── FuelTypeMigrator.java
        ├── AddressMigrator.java
        ├── UserMigrator.java
        ├── CarMigrator.java
        ├── CarListingMigrator.java
        ├── SaleMigrator.java
        ├── FavoriteMigrator.java
        ├── MessageMigrator.java
        └── AuditEventMigrator.java
```

---

## 2. Graf-model

### Nodes

| Label        | Properties                                                                 | Kilde-tabel       |
|--------------|----------------------------------------------------------------------------|-------------------|
| `User`       | `id`, `username`, `email`, `passwordHash`, `firstName`, `lastName`, `phone`, `createdAt` | `app_user`        |
| `Brand`      | `id`, `name`                                                               | `brand`           |
| `Model`      | `id`, `name`                                                               | `model`           |
| `FuelType`   | `id`, `name`                                                               | `fuel_type`       |
| `Region`     | `id`, `name`                                                               | `region`          |
| `Address`    | `id`, `street`, `postalCode`, `city`                                       | `address`         |
| `Car`        | `id`, `year`, `mileageKm`, `color`, `price`                                | `car`             |
| `CarListing` | `id`, `description`, `createdAt`                                           | `car_listing`     |
| `Sale`       | `id`, `soldAt`                                                             | `car_sale`        |
| `Message`    | `id`, `content`, `sentAt`, `isRead`                                        | `message`         |
| `AuditEvent` | `id`, `action`, `changedAt`, `oldPrice`, `newPrice`                        | `car_listing_audit` |

**Role** repræsenteres som ekstra label på User (`:User:Admin` / `:User:Regular`) — ikke som
selvstændig node. Gør admin-queries trivielle: `MATCH (u:Admin)`.

**ID-strategi:** MySQL's `Long id` bevares som property på alle noder. Neo4j's interne
`elementId` bruges ikke i backend-koden — minimerer ændringer i API og tests.

### Relationships

```
(User)-[:LISTED]->(CarListing)
(User)-[:FAVORITED {createdAt}]->(CarListing)
(User)-[:BOUGHT]->(Sale)
(Sale)-[:FOR_LISTING]->(CarListing)

(User)-[:SENT]->(Message)
(Message)-[:TO]->(User)
(Message)-[:ABOUT]->(CarListing)

(CarListing)-[:FEATURES]->(Car)
(CarListing)-[:LOCATED_AT]->(Address)
(Address)-[:IN_REGION]->(Region)

(Car)-[:IS_MODEL]->(Model)
(Model)-[:MADE_BY]->(Brand)
(Car)-[:FUELED_BY]->(FuelType)

(AuditEvent)-[:FOR_LISTING]->(CarListing)
(AuditEvent)-[:BY_USER]->(User)
```

---

## 3. Constraints og indexes

Placeres i `neo4j/constraints.cypher` i rodmappen — køres én gang mod en tom instans.

### Unique constraints

```cypher
CREATE CONSTRAINT user_id_unique        FOR (u:User)       REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT user_username_unique  FOR (u:User)       REQUIRE u.username IS UNIQUE;
CREATE CONSTRAINT user_email_unique     FOR (u:User)       REQUIRE u.email IS UNIQUE;
CREATE CONSTRAINT brand_id_unique       FOR (b:Brand)      REQUIRE b.id IS UNIQUE;
CREATE CONSTRAINT brand_name_unique     FOR (b:Brand)      REQUIRE b.name IS UNIQUE;
CREATE CONSTRAINT model_id_unique       FOR (m:Model)      REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT fuel_id_unique        FOR (f:FuelType)   REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT fuel_name_unique      FOR (f:FuelType)   REQUIRE f.name IS UNIQUE;
CREATE CONSTRAINT region_id_unique      FOR (r:Region)     REQUIRE r.id IS UNIQUE;
CREATE CONSTRAINT region_name_unique    FOR (r:Region)     REQUIRE r.name IS UNIQUE;
CREATE CONSTRAINT address_id_unique     FOR (a:Address)    REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT car_id_unique         FOR (c:Car)        REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT listing_id_unique     FOR (l:CarListing) REQUIRE l.id IS UNIQUE;
CREATE CONSTRAINT sale_id_unique        FOR (s:Sale)       REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT message_id_unique     FOR (m:Message)    REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT audit_id_unique       FOR (a:AuditEvent) REQUIRE a.id IS UNIQUE;
```

### Constraints uden direkte Neo4j-support — håndteres i service-laget

- **Unique favorite (user + listing):** `MERGE (u)-[f:FAVORITED]->(l) ON CREATE SET f.createdAt = datetime()`
- **Én sale per listing:** tjek i service før oprettelse — returnér `409 Conflict` hvis relationen allerede eksisterer

### Performance indexes

```cypher
CREATE INDEX address_postal  FOR (a:Address)    ON (a.postalCode);
CREATE INDEX car_price       FOR (c:Car)        ON (c.price);
CREATE INDEX car_year        FOR (c:Car)        ON (c.year);
CREATE INDEX listing_created FOR (l:CarListing) ON (l.createdAt);
CREATE INDEX message_sent    FOR (m:Message)    ON (m.sentAt);
```

---

## 4. Faser

### Fase 1 — Neo4j i docker-compose

Neo4j tilføjes som en ny service i den fælles `docker_compose/docker-compose.yml` ved siden
af MySQL (og MongoDB når den tilføjes). Alle tre databaser kører parallelt — ingen services
fjernes.

```yaml
neo4j:
  image: neo4j:5.26-community
  ports:
    - "7474:7474"
    - "7687:7687"
  environment:
    NEO4J_AUTH: neo4j/<password>
    NEO4J_PLUGINS: '["apoc"]'
    NEO4J_apoc_import_file_enabled: "true"
    NEO4J_apoc_export_file_enabled: "true"
  volumes:
    - ./neo4j_data:/data
```

**Acceptance criteria**
- `docker compose up -d` starter MySQL, Neo4j (og MongoDB når den tilføjes) uden fejl.
- Neo4j Browser tilgængelig på `http://localhost:7474`.
- `constraints.cypher` kan køres mod tom instans uden fejl.

### Fase 2 — Spring Data Neo4j konfiguration

Tilføj Neo4j-dependency i backend `pom.xml` — uden at fjerne JPA/MySQL:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-neo4j</artifactId>
</dependency>
```

Tilføj Neo4j-forbindelse i `application-dev.yml`:

```yaml
spring:
  neo4j:
    uri: bolt://localhost:7687
    authentication:
      username: neo4j
      password: <password>
  data:
    neo4j:
      database: neo4j
```

Opret `Neo4jConfig.java` i `config/` som eksplicit markerer Neo4j-repositories til at scanne
kun `dk.bilbase.backend.neo4j.repository` — så Spring ikke blander JPA og Neo4j repositories
sammen.

**Acceptance criteria**
- Backend starter op med både JPA og Neo4j konfigureret uden fejl.
- En simpel `@Node`-klasse og tilhørende repository kan injectes og bruges i en test.

### Fase 3 — Node-modeller og repositories

Opret `@Node`-klasser i `neo4j/node/` svarende til graf-modellen i afsnit 2. Eksempel:

```java
@Node("CarListing")
public class CarListingNode {
    @Id
    private Long id;
    private String description;
    private LocalDateTime createdAt;

    @Relationship(type = "FEATURES", direction = OUTGOING)
    private CarNode car;

    @Relationship(type = "LOCATED_AT", direction = OUTGOING)
    private AddressNode address;

    @Relationship(type = "LISTED", direction = INCOMING)
    private UserNode seller;
}
```

Opret repositories i `neo4j/repository/` der extends `Neo4jRepository<T, Long>`. Custom
queries skrives i Cypher via `@Query`. Eksempler på queries der erstatter de tidligere views:

```cypher
-- Aktive listings med filtrering
MATCH (u:User)-[:LISTED]->(l:CarListing)-[:FEATURES]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand)
WHERE NOT EXISTS { (l)<-[:FOR_LISTING]-(:Sale) }
AND ($brand IS NULL OR b.name = $brand)
AND ($minPrice IS NULL OR c.price >= $minPrice)
AND ($maxPrice IS NULL OR c.price <= $maxPrice)
RETURN l, u, c, m, b
ORDER BY l.createdAt DESC
SKIP $skip LIMIT $limit

-- Brugers favoritter
MATCH (u:User {id: $userId})-[f:FAVORITED]->(l:CarListing)-[:FEATURES]->(c:Car)
RETURN l, c, f.createdAt AS favoritedAt
```

**Acceptance criteria**
- Alle node-klasser er oprettet og matcher graf-modellen.
- Repositories kan kompilere og repositories-metoder kan kaldes mod Neo4j.

### Fase 4 — Services og controllers

Opret services i `neo4j/service/` og controllers i `neo4j/web/` med `/neo4j`-præfiks.
Controllers genbruger de eksisterende DTOs fra `dto/` — ingen nye request/response-klasser
med mindre Neo4j-søjlen kræver det.

Controller-præfiks eksempel:

```java
@RestController
@RequestMapping("/neo4j")
public class Neo4jListingController {
    // GET /neo4j/listings
    // POST /neo4j/listings
    // PUT /neo4j/listings/{id}
    // DELETE /neo4j/listings/{id}
}
```

Fuld endpoint-paritet med MySQL-søjlen — samme funktionalitet, samme pagination/filtrering,
samme sikkerhed.

Forretningsvalidering der erstatter MySQL-triggers:

| MySQL-trigger                              | Ny placering i Neo4j-service                                           |
|--------------------------------------------|------------------------------------------------------------------------|
| `trg_message_before_insert`                | `Neo4jMessageService.send()` — guard: sender != receiver, listing ikke solgt |
| `trg_favorite_before_insert`               | `Neo4jFavoriteService.add()` — guard: listing ikke solgt               |
| `trg_car_before_insert` (årstal)           | Bean Validation på DTO: `@Min(1885)` + `@Max` dynamisk                |
| `trg_car_listing_after_insert`             | `Neo4jListingService.create()` — opret AuditEvent i samme transaktion |
| `trg_car_listing_after_delete`             | `Neo4jListingService.delete()` — opret AuditEvent før sletning        |
| `trg_car_sale_after_insert`                | `Neo4jSaleService.record()` — opret AuditEvent med action=SOLD        |
| `trg_car_after_update` (prisændring)       | `Neo4jCarService.update()` — opret AuditEvent hvis pris ændret        |

**Acceptance criteria**
- Alle endpoints under `/neo4j/...` returnerer korrekte data.
- Pagination, filtrering og sortering virker på listings-endpointet.
- Forretningsregler håndhæves korrekt (se triggers-tabel).
- JWT-sikkerhed virker på tværs af begge søjler — samme token bruges mod `/mysql/` og `/neo4j/`.

### Fase 5 — Migrator (migrator_neo4j/)

Selvstændigt Maven-projekt der læser fra MySQL og skriver til Neo4j. Køres én gang når
MySQL er seeded med testdata.

**pom.xml dependencies:**
- `mysql-connector-j`
- `neo4j-java-driver`
- `slf4j-simple`

**Kørsel:**
```bash
cd migrator_neo4j
mvn compile exec:java
```

Config via miljøvariabler:
- `MYSQL_URL`, `MYSQL_USER`, `MYSQL_PASSWORD`
- `NEO4J_URI`, `NEO4J_USER`, `NEO4J_PASSWORD`

Forbind til MySQL med en read-only bruger — scriptet må kun udføre `SELECT`.

**Migrationsrækkefølge** (respekterer afhængigheder):

1. `Region`, `Brand`, `FuelType` (ingen afhængigheder)
2. `Model` (afhænger af Brand)
3. `Address` (afhænger af Region)
4. `User` (inkl. Admin-label baseret på rolle)
5. `Car` (afhænger af Model + FuelType)
6. `CarListing` (afhænger af Car + User + Address)
7. `Sale` (afhænger af CarListing + User)
8. `Favorite` → `:FAVORITED`-relation (afhænger af User + CarListing)
9. `Message` (afhænger af User + CarListing)
10. `AuditEvent` (afhænger af CarListing + User)

**Metode — én klasse pr. tabel:**

```java
public interface Migrator {
    void migrate(Connection mysql, Driver neo4j);
}
```

Hver migrator: `SELECT *` fra MySQL streamet med `setFetchSize(1000)`, samles i batches,
skrives til Neo4j med `UNWIND $rows AS row MERGE (n:Label {id: row.id}) SET n += row`.

Brug `MERGE` på `id` så scriptet er idempotent — kan køres flere gange uden duplikater.

Log antal noder/relationer skabt pr. trin til stdout.

**Acceptance criteria**
- Scriptet kører mod tom Neo4j og fylder den med alle data fra MySQL.
- MySQL er uændret efter kørsel — row counts identiske før og efter.
- Node counts matcher:
  - `SELECT COUNT(*) FROM app_user` == `MATCH (u:User) RETURN count(u)`
  - Tilsvarende for alle tabeller.
- Scriptet er idempotent — to kørsler giver samme resultat som én.

### Fase 6 — Verifikation og integrationstests

Udvid `api-tests/` med Neo4j-specifikke tests der følger samme mønster som de eksisterende.

Opret `neo4j/verification.cypher` med spotchecks:

```cypher
// Alle biler i samme postnummer som en given listing
MATCH (l:CarListing)-[:LOCATED_AT]->(a:Address {postalCode: "2300"})<-[:LOCATED_AT]-(other:CarListing)
RETURN other;

// Antal favorit-relationer
MATCH ()-[f:FAVORITED]->() RETURN count(f);

// Listings uden Sale (aktive)
MATCH (l:CarListing) WHERE NOT EXISTS { (l)<-[:FOR_LISTING]-(:Sale) }
RETURN count(l);

// AuditEvents med manglende relationer (skal være 0)
MATCH (a:AuditEvent) WHERE NOT EXISTS { (a)-[:FOR_LISTING]->() }
RETURN count(a) AS orphanedAuditEvents;
```

**Acceptance criteria**
- Alle `/neo4j/...` integrationstests er grønne.
- Verification-queries matcher tilsvarende counts fra MySQL.
- Swagger viser Neo4j-endpoints korrekt dokumenteret under egen sektion.

---

## 5. Leverancer

| Fil/mappe                          | Beskrivelse                                      |
|------------------------------------|--------------------------------------------------|
| `neo4j/constraints.cypher`         | Alle constraints og indexes                      |
| `neo4j/verification.cypher`        | Queries til datavalidering efter migration       |
| `migrator_neo4j/`                  | Selvstændigt Maven-projekt med migrerings-script |
| `migrator_neo4j/README.md`         | Kørsels-instruktioner                            |
| `backend/.../neo4j/`               | Node-modeller, repositories, services, controllers |
| `docker_compose/docker-compose.yml`| Neo4j-service tilføjet (aftales med gruppen)     |
| `api-tests/`                       | Neo4j-integrationstests tilføjet                 |

---

## 6. Koordinering med gruppen

| Emne                        | Ansvar                                      |
|-----------------------------|---------------------------------------------|
| `dto/` pakken               | Aftales — genbruges på tværs af alle søjler |
| `docker-compose.yml`        | Aftales — én fælles fil med alle tre DBer   |
| Swagger-opsætning           | Aftales — én fælles Swagger med tre sektioner |
| JWT og SecurityConfig       | Deles — Neo4j-controllers bruger samme filter |
| `application-dev.yml`       | Fælles fil — hver tilføjer sin DB-config    |
