# Backend
Denne mappe indeholder projektets backend.

## Forudsætninger

- Java 21
- Maven
- Docker (til MySQL via Docker Compose + Testcontainers)

## Kør MySQL

MySQL startes via Docker Compose fra projektets rod:

```bash
cd docker_compose
docker compose up -d
```

MySQL kører på `localhost:3307` med database `bilbase_projekt`.

Kør derefter SQL-scripts (01-07) mod databasen for at oprette schema, views, triggers og seed data.

## Start appen

```bash
cd backend
mvn spring-boot:run
```

Appen starter med `dev`-profilen, connecter til MySQL på `localhost:3307`, og kører på `http://localhost:8080`.

## Swagger UI

Når appen kører, er API-dokumentationen tilgængelig på:

`http://localhost:8080/swagger-ui.html`

## Kør tests

Tests bruger Testcontainers og spinner automatisk en MySQL-container op (kræver Docker):

```bash
mvn test
```
