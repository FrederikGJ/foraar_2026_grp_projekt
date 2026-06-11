# Rejse gennem applikationslagene — Bilbase

> En bruger opretter en bilannonce. Følg requesten fra browser til database
> og svaret hele vejen tilbage.

---

## Overblik — lagene vi rejser igennem

```
  ╔═══════════════════════════════════════════════════════════════════════════╗
  ║                                                                         ║
  ║   FRONTEND          index.html / app.js / style.css                     ║
  ║       │                                                                 ║
  ║       │  HTTP POST /api/listings   (JSON + JWT)                         ║
  ║       ▼                                                                 ║
  ║   SECURITY          JwtAuthenticationFilter → SecurityConfig            ║
  ║       │                                                                 ║
  ║       ▼                                                                 ║
  ║   WEB-LAG           Controllers  (+ GlobalExceptionHandler)             ║
  ║       │                  ↕ DTO'er (Request/Response)                    ║
  ║       ▼                                                                 ║
  ║   SERVICE-LAG       Services  (forretningslogik)                        ║
  ║       │                                                                 ║
  ║       ▼                                                                 ║
  ║   REPOSITORY-LAG    Repositories  (Spring Data JPA)                     ║
  ║       │                                                                 ║
  ║       ▼                                                                 ║
  ║   DOMAIN-LAG        Entities  (@Entity JPA-klasser)                     ║
  ║       │                                                                 ║
  ║       ▼                                                                 ║
  ║   DATABASE          MySQL 8  (tabeller, views, triggers, events)        ║
  ║                                                                         ║
  ╚═══════════════════════════════════════════════════════════════════════════╝
```


### SECURITY-LAG (dk.bilbase.backend.security/)

```
  ┌──────────────────────────────────────────────────────────────────────┐
  │  security/                                                          │
  │                                                                     │
  │  ┌──────────────────────────────────────────────────────────────┐   │
  │  │  JwtAuthenticationFilter.java                                │   │
  │  │                                                              │   │
  │  │  1. Læser "Authorization: Bearer <token>" fra headeren       │   │
  │  │  2. Kalder JwtService.validateToken(token)                   │   │
  │  │  3. Slår bruger op via AppUserDetailsService                 │   │
  │  │  4. Sætter SecurityContextHolder med AppUserPrincipal        │   │
  │  └──────────────────────────────────────────────────────────────┘   │
  │                          │                                          │
  │  Hjælpeklasser:          │                                          │
  │  ┌────────────────────┐  │  ┌───────────────────────────────────┐   │
  │  │ JwtService.java    │  │  │ AppUserDetailsService.java        │   │
  │  │ (generér/validér)  │  │  │ (find bruger i DB via username)   │   │
  │  └────────────────────┘  │  └───────────────────────────────────┘   │
  │  ┌────────────────────┐  │  ┌───────────────────────────────────┐   │
  │  │ SecurityConfig.java│  │  │ AppUserPrincipal.java             │   │
  │  │ (rute-regler)      │  │  │ (holder bruger-info i context)    │   │
  │  └────────────────────┘  │  └───────────────────────────────────┘   │
  │  ┌─────────────────────────────────────────────────────────────┐    │
  │  │ RestAuthenticationEntryPoint.java                           │    │
  │  │ (returnerer 401 JSON hvis JWT mangler/ugyldig)              │    │
  │  └─────────────────────────────────────────────────────────────┘    │
  │                          │                                          │
  │   ✓ JWT godkendt!        │                                          │
  └──────────────────────────┼──────────────────────────────────────────┘
                             │
                             ▼
```

---


---

## Returrejsen — svaret op igennem lagene

```
  DATABASE
    │  INSERT OK → auto-genereret id returneres
    ▼
  DOMAIN (domain/)
    │  Hibernate hydrerer CarListing entity med det nye id
    ▼
  REPOSITORY (repository/)
    │  CarListingRepository.save() returnerer den gemte entity
    ▼
  SERVICE (service/)
    │  ListingService mapper CarListing entity → ListingResponse DTO
    ▼
  WEB (web/)
    │  ListingController wrapper i ResponseEntity<ListingResponse>
    │  med HTTP 201 Created
    ▼
  SECURITY (security/)
    │  (intet at gøre på vej ud — allerede autoriseret)
    ▼
  FRONTEND (frontend/)
    │  app.js modtager JSON-svaret
    │  Viser "Annonce oprettet!" og navigerer til listings-siden
    ▼
  BROWSER
    ✓  Brugeren ser sin nye annonce i listen
```


## Hvem kalder hvem? — afhængigheds-retning

```
  frontend/
      │
      │  (HTTP/JSON)
      ▼
  security/  ──▶  repository/  (AppUserDetailsService slår bruger op)
      │
      ▼
  web/  ──────▶  dto/  (modtager Request-DTO'er, returnerer Response-DTO'er)
      │
      ▼
  service/  ──▶  repository/  (CRUD-operationer)
      │           │
      ▼           ▼
  domain/  ◀───  repository/  (entities som JPA mapper til/fra DB)
      │
      ▼
  MySQL 8  (tabeller, views, triggers, events, stored procs)


  REGEL: Afhængigheder peger kun NEDAD.
         web/ kender service/, men service/ kender IKKE web/.
         repository/ kender domain/, men domain/ kender IKKE repository/.
```
