# MySQL → Neo4j Migrator

Migrerer data fra MySQL (bilbase) til Neo4j.

## Forudsætninger

- Java 17+
- Maven
- Docker (for Neo4j)
- MySQL med seeded bilbase-data

## Opsætning

### 1. Start Neo4j

```bash
docker compose up -d
```

### 2. Kør constraints

Åbn Neo4j Browser (http://localhost:7474) og kør indholdet af `neo4j/constraints.cypher`.

### 3. Sæt miljøvariabler

```bash
export MYSQL_URL=jdbc:mysql://localhost:3306/bilbase
export MYSQL_USER=migrator_ro
export MYSQL_PASSWORD=<password>
export NEO4J_URI=bolt://localhost:7687
export NEO4J_USER=neo4j
export NEO4J_PASSWORD=bilbasen
```

### 4. Kør migrationen

```bash
mvn compile exec:java
```

## Migrationsrækkefølge

1. Region, Brand, FuelType (uafhængige)
2. Model → Brand
3. Address → Region
4. User (standalone, Admin-label fra rolle)
5. Car → Model, FuelType
6. CarListing → Car, User, Address
7. Sale → CarListing, User
8. Favorite → User, CarListing
9. Message → User, CarListing
10. AuditEvent → CarListing, User

Scriptet er idempotent — det kan køres flere gange uden duplikater (bruger MERGE).
