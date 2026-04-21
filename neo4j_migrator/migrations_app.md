# Migrations-applikation: MySQL → Neo4j
## `migrator_neo4j/` — selvstændigt Maven-projekt

Denne applikation læser data fra MySQL og skriver det til Neo4j. Den køres én gang når
MySQL er seeded med testdata.

---

## 1. Mappestruktur

```
migrator_neo4j/
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

## 2. Afhængigheder (`pom.xml`)

```xml
<dependencies>
    <dependency>
        <groupId>com.mysql</groupId>
        <artifactId>mysql-connector-j</artifactId>
        <version>8.3.0</version>
    </dependency>
    <dependency>
        <groupId>org.neo4j.driver</groupId>
        <artifactId>neo4j-java-driver</artifactId>
        <version>5.18.0</version>
    </dependency>
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-simple</artifactId>
        <version>2.0.12</version>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
            <groupId>org.codehaus.mojo</groupId>
            <artifactId>exec-maven-plugin</artifactId>
            <version>3.1.0</version>
            <configuration>
                <mainClass>dk.bilbase.migrator.neo4j.MigrationMain</mainClass>
            </configuration>
        </plugin>
    </plugins>
</build>
```

---

## 3. Konfiguration og kørsel

Config hentes fra miljøvariabler:

| Variabel          | Eksempel                              |
|-------------------|---------------------------------------|
| `MYSQL_URL`       | `jdbc:mysql://localhost:3306/bilbase` |
| `MYSQL_USER`      | `migrator_ro`                         |
| `MYSQL_PASSWORD`  | `<password>`                          |
| `NEO4J_URI`       | `bolt://localhost:7687`               |
| `NEO4J_USER`      | `neo4j`                               |
| `NEO4J_PASSWORD`  | `<password>`                          |

MySQL-forbindelsen bruger en **read-only bruger** — scriptet må kun udføre `SELECT`.

**Kørsel:**
```bash
cd migrator_neo4j
mvn compile exec:java
```

---

## 4. Design og metode

### Migrator-interface

```java
public interface Migrator {
    void migrate(Connection mysql, Driver neo4j);
}
```

Én implementering pr. tabel/relation. Hver migrator:

1. Streamer rækker fra MySQL med `setFetchSize(1000)` for at undgå at loade hele tabellen i hukommelsen.
2. Samler rækker i batches.
3. Skriver til Neo4j med `UNWIND $rows AS row MERGE (n:Label {id: row.id}) SET n += row`.

Brug af `MERGE` på `id` gør scriptet **idempotent** — det kan køres flere gange uden duplikater.
Antal oprettede noder/relationer logges til stdout pr. trin.

### Migrationsrækkefølge

Rækkefølgen respekterer fremmednøgle-afhængigheder:

| Trin | Migrator(e)                          | Kilde-tabel(ler)        | Afhænger af       |
|------|--------------------------------------|-------------------------|-------------------|
| 1    | `RegionMigrator`, `BrandMigrator`, `FuelTypeMigrator` | `region`, `brand`, `fuel_type` | — |
| 2    | `ModelMigrator`                      | `model`                 | Brand             |
| 3    | `AddressMigrator`                    | `address`               | Region            |
| 4    | `UserMigrator`                       | `app_user`              | —                 |
| 5    | `CarMigrator`                        | `car`                   | Model, FuelType   |
| 6    | `CarListingMigrator`                 | `car_listing`           | Car, User, Address |
| 7    | `SaleMigrator`                       | `car_sale`              | CarListing, User  |
| 8    | `FavoriteMigrator`                   | `favorite`              | User, CarListing  |
| 9    | `MessageMigrator`                    | `message`               | User, CarListing  |
| 10   | `AuditEventMigrator`                 | `car_listing_audit`     | CarListing, User  |

`UserMigrator` sætter `:Admin`-label baseret på rolle-kolonnen i `app_user` — rollen
repræsenteres ikke som selvstændig node.

---

## 5. Constraints og indexes

Filen `neo4j/constraints.cypher` køres én gang mod en tom Neo4j-instans **inden** migrationen startes.

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

### Performance indexes

```cypher
CREATE INDEX address_postal  FOR (a:Address)    ON (a.postalCode);
CREATE INDEX car_price       FOR (c:Car)        ON (c.price);
CREATE INDEX car_year        FOR (c:Car)        ON (c.year);
CREATE INDEX listing_created FOR (l:CarListing) ON (l.createdAt);
CREATE INDEX message_sent    FOR (m:Message)    ON (m.sentAt);
```

---

## 6. Acceptance criteria

- [ ] Scriptet kører mod en tom Neo4j-instans og fylder den med alle data fra MySQL.
- [ ] MySQL er uændret efter kørsel — row counts identiske før og efter.
- [ ] Node counts matcher MySQL:
  - `SELECT COUNT(*) FROM app_user` == `MATCH (u:User) RETURN count(u)`
  - Tilsvarende for alle tabeller.
- [ ] Scriptet er idempotent — to kørsler giver samme resultat som én.
- [ ] `constraints.cypher` kan køres mod tom instans uden fejl.
