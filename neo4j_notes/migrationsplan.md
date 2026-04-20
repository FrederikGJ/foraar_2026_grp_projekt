# Migrationsplan: MySQL → Neo4j

Denne plan beskriver migration af Bilbase-databasen fra MySQL 8 til Neo4j. Begge databaser kører som Docker-containere lokalt. Planen skal eksekveres i rækkefølge — hver fase har tydelige acceptance criteria før næste fase startes.

---

## 0. Mål og scope

**In scope**
- Nyt graf-skema i Neo4j der dækker al nuværende funktionalitet.
- Et migrerings-script der overfører data fra den kørende MySQL-container til Neo4j-containeren (én-gangs load, ikke sync).
- Omstilling af Spring Boot-backend fra Spring Data JPA til Spring Data Neo4j.
- Genetablering af alle unique constraints som Neo4j-constraints.
- Flytning af forretnings-validering fra MySQL-triggers til backend service-laget.

**Out of scope**
- To-vejs synkronisering mellem MySQL og Neo4j.
- Performance-tuning ud over basis-indekser.
- Produktionsmiljø — dette er et lokalt studieprojekt.

---

## 1. Ny graf-model

### Nodes

| Label         | Properties                                                                | Kilde-tabel          |
|---------------|---------------------------------------------------------------------------|----------------------|
| `User`        | `id`, `username`, `email`, `passwordHash`, `firstName`, `lastName`, `phone`, `createdAt` | `app_user`           |
| `Brand`       | `id`, `name`                                                              | `brand`              |
| `Model`       | `id`, `name`                                                              | `model`              |
| `FuelType`    | `id`, `name`                                                              | `fuel_type`          |
| `Region`      | `id`, `name`                                                              | `region`             |
| `Address`     | `id`, `street`, `postalCode`, `city`                                      | `address`            |
| `Car`         | `id`, `year`, `mileageKm`, `color`, `price`                               | `car`                |
| `CarListing`  | `id`, `description`, `createdAt`                                          | `car_listing`        |
| `Sale`        | `id`, `soldAt`                                                            | `car_sale`           |
| `Message`     | `id`, `content`, `sentAt`, `isRead`                                       | `message`            |
| `AuditEvent`  | `id`, `action`, `changedAt`, `oldPrice`, `newPrice`                       | `car_listing_audit`  |

**Role** repræsenteres som ekstra label på User (`:User:Admin` / `:User:Regular`) — ikke som selvstændig node. Det gør admin-queries trivielle (`MATCH (u:Admin)`).

**id-felt:** MySQL's primary keys bevares som property `id` (BIGINT) på alle noder. Det gør cross-referencing under migrationen enkelt og bevarer stabile ID'er udadtil i API'et. Neo4j's interne `elementId` bruges ikke i backend-koden.

### Relationships

```
(User)-[:LISTED]->(CarListing)                      // seller
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

**Designnoter**
- `Car` og `CarListing` er adskilte noder (1:1 i dag, men åbner for re-listing af solgte biler).
- `Sale` er en node, ikke en relation — så den kan berikes med pris ved salg, betalingsinfo, anmeldelser o.l. senere.
- `Address` er en node for at understøtte elegante queries som "alle biler med samme postnummer".
- `AuditEvent` ligger i grafen så audit-historik kan traverseres sammen med resten af domænet.

---

## 2. Constraints og indexes (skal reetableres)

### Unique constraints (Neo4j)

```cypher
CREATE CONSTRAINT user_id_unique       FOR (u:User)       REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT user_username_unique FOR (u:User)       REQUIRE u.username IS UNIQUE;
CREATE CONSTRAINT user_email_unique    FOR (u:User)       REQUIRE u.email IS UNIQUE;

CREATE CONSTRAINT brand_id_unique      FOR (b:Brand)      REQUIRE b.id IS UNIQUE;
CREATE CONSTRAINT brand_name_unique    FOR (b:Brand)      REQUIRE b.name IS UNIQUE;

CREATE CONSTRAINT model_id_unique      FOR (m:Model)      REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT fuel_id_unique       FOR (f:FuelType)   REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT fuel_name_unique     FOR (f:FuelType)   REQUIRE f.name IS UNIQUE;
CREATE CONSTRAINT region_id_unique     FOR (r:Region)     REQUIRE r.id IS UNIQUE;
CREATE CONSTRAINT region_name_unique   FOR (r:Region)     REQUIRE r.name IS UNIQUE;

CREATE CONSTRAINT address_id_unique    FOR (a:Address)    REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT car_id_unique        FOR (c:Car)        REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT listing_id_unique    FOR (l:CarListing) REQUIRE l.id IS UNIQUE;
CREATE CONSTRAINT sale_id_unique       FOR (s:Sale)       REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT message_id_unique    FOR (m:Message)    REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT audit_id_unique      FOR (a:AuditEvent) REQUIRE a.id IS UNIQUE;
```

### Constraints der IKKE findes som direkte Neo4j-feature

Disse håndteres ved brug af `MERGE` i service-laget i stedet for `CREATE`:

- **UNIQUE(user_id, car_listing_id) på `favorite`**  
  → `MERGE (u)-[f:FAVORITED]->(l) ON CREATE SET f.createdAt = datetime()`
- **UNIQUE(car_listing_id) på `car_sale`**  
  → tjek i service: `MATCH (l:CarListing)<-[:FOR_LISTING]-(:Sale)` før oprettelse, ellers smid 409 Conflict.

### Indexes (ydelse)

```cypher
CREATE INDEX address_postal  FOR (a:Address) ON (a.postalCode);
CREATE INDEX car_price       FOR (c:Car)     ON (c.price);
CREATE INDEX car_year        FOR (c:Car)     ON (c.year);
CREATE INDEX listing_created FOR (l:CarListing) ON (l.createdAt);
CREATE INDEX message_sent    FOR (m:Message) ON (m.sentAt);
```

---

## 3. Faser

### Fase 1 — Opsætning af Neo4j-container

**De to backends er fuldt adskilte stacks.** SQL-versionen (på sin git-branch) har sin egen `docker-compose.yml` med MySQL. Neo4j-versionen (på sin git-branch) har sin egen `docker-compose.yml` med Neo4j. De to compose-filer deler ikke noget, og de to databaser kører ikke normalt samtidig — kun undtagelsesvist i migrations-øjeblikket (se Fase 2).

- På Neo4j-branchen: erstat MySQL-servicen i `docker_compose/docker-compose.yml` med en Neo4j-service. Compose-filen skal ikke kende til MySQL.
  - Image: `neo4j:5.26-community` (LTS — stabil og bedst dokumenteret for studieprojekt; APOC Core er fuldt supporteret i denne version).
  - Porte: `7474` (browser/HTTP) og `7687` (Bolt).
  - Env:
    - `NEO4J_AUTH=neo4j/<password>`
    - `NEO4J_PLUGINS=["apoc"]` (APOC Core — officielt supporteret i 5.x, ingen ekstra download nødvendig).
    - `NEO4J_apoc_import_file_enabled=true` og `NEO4J_apoc_export_file_enabled=true` hvis I senere vil bruge `apoc.import` / `apoc.export`.
  - Volume for data-persistens: `./neo4j_data:/data`.
- Brug et unikt compose project name når I starter op (`docker compose -p bilbase-neo4j up -d`) så stacken ikke kolliderer hvis SQL-stacken tilfældigvis også kører.
- Læg en `neo4j/constraints.cypher`-fil i projektet med alle constraints og indexes fra afsnit 2.

**SQL-branchen må ikke røres af denne plan.** Alle ændringer sker på Neo4j-branchen. Hvis en ændring kræver at man rører SQL-branchen, er det et tegn på at planen er afsporet.

**Acceptance criteria**
- `docker compose -p bilbase-neo4j up -d` starter Neo4j uden fejl på Neo4j-branchen.
- SQL-branchen er bit-for-bit uændret — `git diff main...sql-branch` for filer relateret til SQL-opsætningen viser ingen ændringer forårsaget af denne plan.
- Neo4j Browser tilgængelig på `http://localhost:7474` og login virker.
- `constraints.cypher` kan køres mod en tom Neo4j-instans uden fejl.

### Fase 2 — Data-migrerings-script (Java-projekt)

Migrationen lever som et selvstændigt Maven-projekt i monorepoet under `migration_2_neo4j/` — altså på samme niveau som `backend/`, `frontend/` og `api-tests/`. Det gør det nemt for resten af holdet at køre scriptet uden at lære et nyt sprog.

**Projekt-opsætning**
- Mappe: `migration_2_neo4j/`
- `pom.xml` med Java 21 (matcher backend) og dependencies:
  - `mysql-connector-j` (læse fra kilde-MySQL)
  - `neo4j-java-driver` (skrive til Neo4j via Bolt)
  - `slf4j-simple` (logging)
- Hoved-klasse: `dk.bilbase.migration.MigrationMain` med en `public static void main(String[] args)`.
- Config via environment-variabler eller `application.properties` i projektet: MySQL-URL, bruger, password, Neo4j-Bolt-URI, bruger, password.
- Kørsel: `cd migration_2_neo4j && mvn compile exec:java`.

**Vigtigt — migrations-øjeblikket er den eneste gang begge databaser kører samtidig:**

De to stacks er ellers fuldt adskilte. Migration foregår som én-gangs-kørsel ved at starte begge containere midlertidigt, køre scriptet, og derefter lukke MySQL ned igen. Fremgangsmåde:

1. Terminal A: check SQL-branch ud et andet sted på disken (eller i en `git worktree`). Start MySQL-stacken: `docker compose -p bilbase-sql up -d`.
2. Terminal B: stå på Neo4j-branch. Start Neo4j-stacken: `docker compose -p bilbase-neo4j up -d`.
3. Kør migrerings-scriptet fra `migration_2_neo4j/` — det forbinder til MySQL på `localhost:3306` og Neo4j på `localhost:7687`.
4. Når scriptet er færdigt og verifikation i Fase 5 er grøn, stop MySQL-stacken igen: `docker compose -p bilbase-sql down`.
5. Neo4j-branchen lever herefter sit eget liv uden nogen afhængighed til MySQL.

Scriptet må KUN udføre `SELECT` mod MySQL. Ingen `UPDATE`, `DELETE`, `INSERT` eller DDL — SQL-databasens dump/data-filer skal være bit-for-bit identiske før og efter migrationen. Forbind helst med en dedikeret read-only MySQL-bruger for at gøre det teknisk umuligt at komme til at skrive.

**Migrationsrækkefølge** (respekterer afhængigheder):

1. `Role` bliver til labels — ingen data-overførsel, men husk mapping: `role.name = "ADMIN"` → extra label `Admin` på User.
2. Reference-data: `Region` → `Brand` → `Model` → `FuelType`.
3. `Address` (afhænger af Region).
4. `User` (afhænger af Role for label-valget).
5. `Car` (afhænger af Model + FuelType).
6. `CarListing` (afhænger af Car, User, Address).
7. `Sale` (afhænger af CarListing + User) — bemærk: i MySQL hedder det `car_sale`.
8. `Favorite` → som `:FAVORITED`-relation (ingen node, ingen ID).
9. `Message` (afhænger af User + CarListing).
10. `AuditEvent` (afhænger af CarListing + User).

**Metode**
- Struktur: én migrator-klasse pr. tabel (`RegionMigrator`, `UserMigrator`, `CarListingMigrator` osv.) der alle implementerer et fælles `Migrator`-interface med `migrate(Connection mysql, Session neo4j)`.
- For hver tabel: `SELECT *` fra MySQL (helst streamet med `Statement.setFetchSize`), saml rækker i batches af fx 1000, send til Neo4j som `UNWIND $rows AS row ... MERGE`.
- Brug `MERGE` på id-property for at gøre scriptet idempotent — kan køres flere gange uden duplikater.
- Alle Neo4j-skrivninger skal ske i transaktioner (`session.executeWrite(tx -> ...)`).
- Log antal nodes/relations skabt pr. trin til stdout, så det er tydeligt hvad der skete.

**Acceptance criteria**
- Scriptet kan køres mod en tom Neo4j-instans og fylde den med alle data fra MySQL.
- MySQL-databasen er uændret efter kørsel — row counts i alle tabeller er identiske før og efter.
- Rækker i MySQL og noder i Neo4j matcher:
  - `SELECT COUNT(*) FROM app_user` == `MATCH (u:User) RETURN count(u)`
  - Tilsvarende for alle øvrige tabeller.
- Relationer er til stede: hver `CarListing` har præcis ét `FEATURES`, ét `LOCATED_AT`, ét `LISTED`-kant fra User.
- Scriptet er idempotent — kørsel to gange giver samme resultat som én kørsel.

### Fase 3 — Backend-omstilling til Spring Data Neo4j

- Skift Maven-dependency: fjern `spring-boot-starter-data-jpa` + MySQL-driver, tilføj `spring-boot-starter-data-neo4j`.
- Opdater `application-dev.yml`: Bolt-URI, bruger, password.
- Konverter domain-klasser:
  - `@Entity` → `@Node`
  - `@Id @GeneratedValue` → `@Id @GeneratedValue(UUIDStringGenerator.class)` eller behold `Long id` hvis I vil bevare MySQL-ID'erne.
  - `@ManyToOne` / `@OneToMany` → `@Relationship(type = "...", direction = ...)`
  - Join-tabel-entiteten bag `favorite` forsvinder — User får en `Set<CarListing> favorites` med `@Relationship("FAVORITED")`.
- Konverter repositories: `JpaRepository` → `Neo4jRepository`. Custom queries skrives om fra JPQL/native SQL til Cypher via `@Query`.
- `ListingSpecifications` (JPA Criteria-builder for dynamisk søgning) — skrives om til Cypher-querybuilder. Dette er det mest arbejdstunge skridt; overvej at starte med de almindeligste filtre (brand, model, prisrange, år) og udvide derfra.
- View-repositories (`ActiveListingViewRepository`, `CarDetailsViewRepository`, `UserFavoriteViewRepository`) erstattes med Cypher-queries — views findes ikke i Neo4j, men projektioner via `RETURN`-statements dækker samme behov.

**Acceptance criteria**
- Backend starter op uden fejl mod den migrerede Neo4j-database.
- Alle read-endpoints (GET `/api/listings`, GET `/api/cars/{id}`, GET `/api/favorites`, GET `/api/messages/inbox|outbox`) returnerer samme data som før migrationen.

### Fase 4 — Flytning af forretningslogik fra triggers

MySQL-triggers eksisterer ikke længere efter migrationen. Erstat hver trigger med tilsvarende tjek:

| MySQL-trigger                        | Ny placering                                                   |
|--------------------------------------|----------------------------------------------------------------|
| `trg_message_before_insert` (sender != receiver + ikke solgt) | `MessageService.send()` — guard clauses før `save()`; returnér `400 Bad Request` |
| `trg_favorite_before_insert` (ikke solgt)                     | `FavoriteService.add()` — samme mønster                        |
| `trg_car_before_insert` (årstal 1885..nextYear)               | Bean Validation på DTO: `@Min(1885)` + custom `@MaxYear`-validator |
| `trg_car_listing_after_insert`                                | `ListingService.create()` — opret `AuditEvent` med action=INSERT i samme transaktion |
| `trg_car_listing_after_delete`                                | `ListingService.delete()` — opret AuditEvent INSERT før delete-kald |
| `trg_car_sale_after_insert`                                   | `SaleService.record()` — opret AuditEvent action=SOLD         |
| `trg_car_after_update` (prisændring)                          | `CarService.update()` — hvis `oldPrice != newPrice`, opret AuditEvent action=UPDATE |

Alternativt kan audit-logning centraliseres i en `@EventListener` / Spring Data Neo4j lifecycle-callback, så den sker automatisk på alle `save`/`delete`.

`GlobalExceptionHandler`-mappingen af SQLState 45000 → 400 fjernes og erstattes med specifikke exception-typer (`IllegalArgumentException` / custom `DomainValidationException` → 400).

**Acceptance criteria**
- Forsøg på at sende besked til sig selv giver `400 Bad Request`.
- Forsøg på at favorisere en solgt bil giver `400 Bad Request`.
- Bil med årstal 1800 eller 2100 afvises ved create.
- Oprettelse/sletning af listing og salg af bil skaber tilsvarende `AuditEvent`-noder.
- En prisændring på `Car.price` skaber AuditEvent med `oldPrice` og `newPrice` sat korrekt.

### Fase 5 — Verifikation og regressionstest

- Kør den eksisterende Playwright-testsuite (`api-tests/`) mod den nye backend. Alle tests skal stadig passere.
- Tilføj nye Cypher-baserede spotchecks som en markdown-tjekliste i `neo4j/verification.cypher`:
  - "Alle biler med samme postnummer som listing X" — bevis at graf-modellen løser denne use case elegant.
  - Antal favorit-relationer == rækker i gammel `favorite`-tabel.
  - Antal Sale-noder == rækker i gammel `car_sale`-tabel.
  - Alle AuditEvents har både `FOR_LISTING` og `BY_USER`-relationer.
- Sammenlign udvalgte endpoints-responses pre/post ved hjælp af fx `diff` på JSON for at fange regressioner.

**Acceptance criteria**
- Playwright-suite grøn.
- Verification-queries giver matchende tal mod MySQL-kilden.
- README opdateret med Neo4j-setup-instruktioner.

---

## 4. Leverancer (filer der skal eksistere når planen er færdig)

- `docker_compose/docker-compose.yml` — udvidet med Neo4j-service (MySQL-servicen urørt).
- `neo4j/constraints.cypher` — alle constraints og indexes.
- `neo4j/verification.cypher` — queries til datavalidering efter migration.
- `migration_2_neo4j/` — selvstændigt Maven-projekt med Java-baseret migrerings-script + README.
- `backend/` — omskrevet til Spring Data Neo4j (på dedikeret git-branch så MySQL-versionen bevares på main).
- `README.md` — opdateret med nye run-instruktioner, inkl. hvordan man skifter mellem SQL- og Neo4j-backend via branches.
- Opdateret `arkitektur.md` — nye diagrammer der afspejler graf-modellen.

---

## 5. Afklarede beslutninger

Disse valg er truffet på forhånd og skal respekteres gennem hele migrationen:

1. **ID-strategi:** MySQL's `Long id` bevares som property `id` på alle noder. Neo4j's interne `elementId` bruges ikke i backend-koden. Dette minimerer ændringer i API og tests.

2. **Migrerings-sprog:** Java (matcher backend, hele teamet kan læse og vedligeholde det). Scriptet ligger som selvstændigt Maven-projekt i `migration_2_neo4j/` ved siden af `backend/`, `frontend/` og `api-tests/` i monorepoet.

3. **SQL- og Neo4j-versionerne er fuldt adskilte stacks.** Hver lever på sin egen git-branch med sin egen `docker-compose.yml`. De to compose-filer deler ikke services og kører ikke normalt samtidig. Den eneste gang begge databaser er oppe er under selve migrations-kørslen (Fase 2), hvor begge containere midlertidigt startes med hver sit `-p` project-name, scriptet kører én gang, og MySQL lukkes derefter ned igen. Neo4j-branchen har efter migrationen ingen afhængighed til MySQL overhovedet. SQL-branchen røres ikke af denne plan — alle ændringer i planen sker på Neo4j-branchen.

4. **APOC bruges.** Image er `neo4j:5.26-community` (LTS), hvor APOC Core er fuldt supporteret og følger med databasen. Ingen ekstra licens eller download. APOC-procedurer som `apoc.periodic.iterate` kan bruges hvis migrationen viser sig at være langsom, men standard-driver-batches via `UNWIND` er første valg for enkelhedens skyld.
