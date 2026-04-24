# API-tests

Java-tests (JUnit 5 + RestAssured) der rammer backenden via HTTP.

## Forudsætninger

- Java 21
- Maven
- Backenden skal køre på `http://localhost:8080`

## Kør alle tests

Stå i mappen `api-tests` og kør:

```
mvn test
```

## Kør en enkelt testklasse

```
mvn test -Dtest=AuthTest
```

## Brug en anden base-URL

```
mvn test -Dapi.base.url=http://localhost:9090
```
