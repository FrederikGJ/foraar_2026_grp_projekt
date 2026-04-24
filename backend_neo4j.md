# Backend Neo4j-søjle
## Spring Boot — `dk.bilbase.backend.neo4j`

Denne fil dækker Neo4j-laget i den fælles Spring Boot backend: graf-model, Spring Data
Neo4j-konfiguration, node-modeller, repositories, services og controllers.

Ingen eksisterende kode røres — alt nyt kode placeres i nye pakker.

---

## 1. Mappestruktur

```
backend/src/main/java/dk/bilbase/backend/
├── mysql/                         ← urørt (eksisterende kode)
├── mongodb/                       ← anden gruppemedlems ansvar
├── neo4j/                         ← dette scope
│   ├── node/                      (@Node klasser)
│   ├── repository/                (Neo4jRepository interfaces)
│   ├── service/                   (Neo4j-specifik forretningslogik)
│   └── web/                       (controllers med /neo4j prefix)
├── dto/                           ← delte DTOs (aftales på tværs)
└── config/
    └── Neo4jConfig.java
```

---

## 2. Graf-model

### Nodes

| Label        | Properties                                                                                      | Kilde-tabel       |
|--------------|-------------------------------------------------------------------------------------------------|-------------------|
| `User`       | `id`, `username`, `email`, `passwordHash`, `firstName`, `lastName`, `phone`, `createdAt`       | `app_user`        |
| `Brand`      | `id`, `name`                                                                                    | `brand`           |
| `Model`      | `id`, `name`                                                                                    | `model`           |
| `FuelType`   | `id`, `name`                                                                                    | `fuel_type`       |
| `Region`     | `id`, `name`                                                                                    | `region`          |
| `Address`    | `id`, `street`, `postalCode`, `city`                                                            | `address`         |
| `Car`        | `id`, `year`, `mileageKm`, `color`, `price`                                                    | `car`             |
| `CarListing` | `id`, `description`, `createdAt`                                                                | `car_listing`     |
| `Sale`       | `id`, `soldAt`                                                                                  | `car_sale`        |
| `Message`    | `id`, `content`, `sentAt`, `isRead`                                                             | `message`         |
| `AuditEvent` | `id`, `action`, `changedAt`, `oldPrice`, `newPrice`                                             | `car_listing_audit` |

**Roller** repræsenteres som ekstra label på User (`:User:Admin` / `:User:Regular`) — ikke som
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

## 3. Spring Data Neo4j konfiguration

### Afhængighed (`pom.xml`)

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-neo4j</artifactId>
</dependency>
```

JPA/MySQL-afhængighederne fjernes ikke.

### `application-dev.yml`

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

### `Neo4jConfig.java`

`Neo4jConfig` markerer eksplicit at Neo4j-repositories kun scannes under
`dk.bilbase.backend.neo4j.repository` — så Spring ikke blander JPA og Neo4j repositories
sammen.

### Docker Compose

Neo4j tilføjes som ny service i den fælles `docker_compose/docker-compose.yml` ved siden
af MySQL og MongoDB. Ingen eksisterende services fjernes.

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
- `docker compose up -d` starter alle databaser uden fejl.
- Neo4j Browser tilgængelig på `http://localhost:7474`.
- Backend starter op med både JPA og Neo4j konfigureret uden fejl.
- En simpel `@Node`-klasse og tilhørende repository kan injectes og bruges i en test.

---

## 4. Node-modeller og repositories

### Node-klasser (`neo4j/node/`)

Opret én `@Node`-klasse pr. label svarende til graf-modellen ovenfor. Eksempel:

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

### Repositories (`neo4j/repository/`)

Hvert repository extends `Neo4jRepository<T, Long>`. Custom queries skrives i Cypher
via `@Query`. Eksempler der erstatter de tidligere views:

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
- Repositories kompilerer og kan kaldes mod Neo4j.

---

## 5. Services og controllers

### Controllers (`neo4j/web/`)

Alle Neo4j-controllers har `/neo4j`-præfiks og genbruger eksisterende DTOs fra `dto/`.
Fuld endpoint-paritet med MySQL-søjlen — samme funktionalitet, pagination, filtrering og sikkerhed.

```java
@RestController
@RequestMapping("/neo4j")
public class Neo4jListingController {
    // GET    /neo4j/listings
    // POST   /neo4j/listings
    // PUT    /neo4j/listings/{id}
    // DELETE /neo4j/listings/{id}
}
```

### Forretningsvalidering (`neo4j/service/`)

Services erstatter MySQL-triggers for Neo4j-søjlen:

| MySQL-trigger                        | Ny placering                                                                    |
|--------------------------------------|---------------------------------------------------------------------------------|
| `trg_message_before_insert`          | `Neo4jMessageService.send()` — guard: sender != receiver, listing ikke solgt    |
| `trg_favorite_before_insert`         | `Neo4jFavoriteService.add()` — guard: listing ikke solgt                        |
| `trg_car_before_insert` (årstal)     | Bean Validation på DTO: `@Min(1885)` + `@Max` dynamisk                         |
| `trg_car_listing_after_insert`       | `Neo4jListingService.create()` — opret AuditEvent i samme transaktion           |
| `trg_car_listing_after_delete`       | `Neo4jListingService.delete()` — opret AuditEvent før sletning                  |
| `trg_car_sale_after_insert`          | `Neo4jSaleService.record()` — opret AuditEvent med `action=SOLD`                |
| `trg_car_after_update` (prisændring) | `Neo4jCarService.update()` — opret AuditEvent hvis pris ændret                 |

### Constraints uden direkte Neo4j-support

Håndteres i service-laget frem for databasen:

- **Unique favorite (user + listing):** `MERGE (u)-[f:FAVORITED]->(l) ON CREATE SET f.createdAt = datetime()`
- **Én sale per listing:** tjek i service før oprettelse — returnér `409 Conflict` hvis relationen allerede eksisterer.

**Acceptance criteria**
- Alle endpoints under `/neo4j/...` returnerer korrekte data.
- Pagination, filtrering og sortering virker på listings-endpointet.
- Forretningsregler håndhæves korrekt (se triggers-tabel ovenfor).
- JWT-sikkerhed virker på tværs af begge søjler — samme token bruges mod `/mysql/` og `/neo4j/`.

---

## 6. Verifikation og integrationstests

Udvid `api-tests/` med Neo4j-specifikke tests der følger samme mønster som de eksisterende.

Opret `neo4j/verification.cypher` med spotchecks:

```cypher
// Alle listings i samme postnummer som en given listing
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
