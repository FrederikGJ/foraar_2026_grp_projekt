# Arkitektur — Bilbase

---

## 1. System-overblik

```
  ╔═══════════════════╗          ╔══════════════════════════╗          ╔══════════════════╗
  ║    BROWSER        ║          ║       BACKEND             ║          ║    DATABASE       ║
  ║                   ║          ║   Spring Boot 3 / Java 21  ║          ║   MySQL 8         ║
  ║  frontend/        ║  HTTP    ║   :8080                   ║  JDBC/   ║   :3306           ║
  ║  ┌─────────────┐  ║ ──────▶  ║                           ║  JPA     ║                   ║
  ║  │  index.html │  ║          ║  JwtAuthenticationFilter  ║ ───────▶ ║  Tables           ║
  ║  │  app.js     │  ║ ◀──────  ║  → SecurityConfig         ║          ║  Views            ║
  ║  │  style.css  │  ║  JSON    ║  → Controllers            ║ ◀─────── ║  Triggers         ║
  ║  └─────────────┘  ║          ║  → Services               ║          ║  Events           ║
  ║                   ║          ║  → Repositories           ║          ║  Stored procs     ║
  ╚═══════════════════╝          ╚══════════════════════════╝          ╚══════════════════╝
           ▲                                  ▲
           │           HTTP                   │
           └──────────────── api-tests/ ──────┘
                           (Playwright, TS)
```

---

## 2. Request-flow — eksempel: send besked

```
  Browser (app.js)
       │
       │  POST /api/messages  { carListingId, content }
       │  Authorization: Bearer <jwt>
       ▼
  ┌─────────────────────────────────────────────────────────────────────┐
  │  JwtAuthenticationFilter                                            │
  │   └─ valider JWT → sæt SecurityContext (AppUserPrincipal)          │
  └─────────────────────────────┬───────────────────────────────────────┘
                                 │
                                 ▼
  ┌─────────────────────────────────────────────────────────────────────┐
  │  MessageController  (@PostMapping /api/messages)                    │
  │   └─ @Valid @RequestBody SendMessageRequest                         │
  │   └─ @AuthenticationPrincipal → senderId                           │
  └─────────────────────────────┬───────────────────────────────────────┘
                                 │  send(senderId, req)
                                 ▼
  ┌─────────────────────────────────────────────────────────────────────┐
  │  MessageService  (@Transactional)                                   │
  │   ├─ AppUserRepository.findById(senderId)    → sender               │
  │   ├─ CarListingRepository.findById(listingId) → listing             │
  │   └─ listing.getSeller()                     → receiver (auto!)     │
  │                                                                     │
  │   └─ MessageRepository.save(new Message(...))                       │
  └─────────────────────────────┬───────────────────────────────────────┘
                                 │  INSERT INTO message (...)
                                 ▼
  ┌─────────────────────────────────────────────────────────────────────┐
  │  MySQL                                                              │
  │   ├─ DB-TRIGGER: sender_id != receiver_id  (SQLState 45000 → 400) │
  │   └─ DB-TRIGGER: listing ikke solgt                                 │
  └─────────────────────────────────────────────────────────────────────┘
```

---

## 3. Backend — lagarkitektur

```
  ┌──────────────────────────────────────────────────────────────────────────┐
  │  WEB-LAG  (dk.bilbase.backend.web)                                       │
  │                                                                          │
  │  ┌────────────────┐ ┌─────────────────┐ ┌─────────────────┐             │
  │  │AuthController  │ │ListingController│ │MessageController│             │
  │  │POST /auth/login│ │GET  /listings   │ │GET  /messages/  │             │
  │  │POST /auth/reg. │ │POST /listings   │ │     inbox|outbox│             │
  │  └────────────────┘ │PUT  /listings/id│ │POST /messages   │             │
  │                     │DEL  /listings/id│ └─────────────────┘             │
  │  ┌────────────────┐ └─────────────────┘                                 │
  │  │CarController   │ ┌─────────────────┐ ┌─────────────────┐             │
  │  │GET /cars       │ │FavoriteController│ │AuditController  │             │
  │  │GET /cars/id    │ │GET  /favorites  │ │GET /admin/audit │             │
  │  └────────────────┘ │POST /favorites  │ └─────────────────┘             │
  │                     │DEL  /favorites/id│  GlobalExceptionHandler        │
  │                     └─────────────────┘  (SQLState 45000 → 400)        │
  └────────────────────────────┬─────────────────────────────────────────────┘
                               │  kalder
  ┌────────────────────────────▼─────────────────────────────────────────────┐
  │  SERVICE-LAG  (dk.bilbase.backend.service)                               │
  │                                                                          │
  │  ┌──────────────────────────┐  ┌────────────────┐  ┌─────────────────┐  │
  │  │ListingService            │  │FavoriteService │  │MessageService   │  │
  │  │+ ListingSpecifications   │  │                │  │modtager udledes │  │
  │  │(dynamisk JPA Criteria    │  │                │  │fra listing.seller│  │
  │  │ søgning: brand/model/    │  │                │  │                 │  │
  │  │ region/price/year/color) │  │                │  │                 │  │
  │  └──────────────────────────┘  └────────────────┘  └─────────────────┘  │
  └────────────────────────────┬─────────────────────────────────────────────┘
                               │  kalder
  ┌────────────────────────────▼─────────────────────────────────────────────┐
  │  REPOSITORY-LAG  (dk.bilbase.backend.repository)                         │
  │                                                                          │
  │  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐       │
  │  │AppUserRepository │  │CarListingRepository  │MessageRepository │       │
  │  │CarRepository     │  │CarSaleRepository │  │FavoriteRepository│       │
  │  │BrandRepository   │  │AddressRepository │  │AuditRepository   │       │
  │  │ModelRepository   │  │RegionRepository  │  │FuelTypeRepository│       │
  │  └──────────────────┘  └──────────────────┘  └──────────────────┘       │
  │                                                                          │
  │  view/ (read-only projektioner mod DB-views)                             │
  │  ┌───────────────────────────┐  ┌───────────────────────────┐           │
  │  │ActiveListingViewRepository│  │UserFavoriteViewRepository │           │
  │  │CarDetailsViewRepository   │  │                           │           │
  │  └───────────────────────────┘  └───────────────────────────┘           │
  └────────────────────────────┬─────────────────────────────────────────────┘
                               │  JPA / Spring Data
  ┌────────────────────────────▼─────────────────────────────────────────────┐
  │  DOMAIN-LAG  (dk.bilbase.backend.domain)                                 │
  │  (JPA @Entity klasser — se ER-diagram nedenfor)                          │
  └──────────────────────────────────────────────────────────────────────────┘
```

---

## 4. Sikkerhedsfilter-kæde (JWT)

```
  Inkommende request
       │
       ▼
  ┌──────────────────────────────────┐
  │  JwtAuthenticationFilter        │
  │  ├─ Læs "Authorization" header  │
  │  ├─ JwtService.validateToken()  │
  │  └─ Sæt SecurityContextHolder   │
  └────────────────┬─────────────────┘
                   │
                   ▼
  ┌──────────────────────────────────┐
  │  SecurityConfig                 │
  │  Åbne ruter (ingen JWT):        │
  │    POST /api/auth/login         │
  │    POST /api/auth/register      │
  │    GET  /api/listings  (læs)    │
  │    GET  /api/cars/**   (læs)    │
  │                                 │
  │  Kræver auth:                   │
  │    /api/messages/**             │
  │    /api/favorites/**            │
  │    POST/PUT/DEL /api/listings   │
  │                                 │
  │  Kræver ROLE_ADMIN:             │
  │    /api/admin/**                │
  └────────────────┬─────────────────┘
                   │
                   ▼
  ┌──────────────────────────────────┐
  │  RestAuthenticationEntryPoint   │
  │  Uautoriseret → 401 JSON        │
  └──────────────────────────────────┘
```

---

## 5. Databasemodel (ER-diagram)

```
  ┌──────────┐        ┌────────────────────────────────────┐
  │  role    │        │            app_user                │
  │──────────│1      N│────────────────────────────────────│
  │ id       │◀───────│ id                                 │
  │ name     │        │ username, email, password_hash     │
  └──────────┘        │ first_name, last_name, phone       │
                      │ role_id  (FK → role)               │
                      │ created_at, updated_at             │
                      └──────┬──────────────┬──────────────┘
                             │              │
                     seller  │1           1 │ buyer / sender / receiver / user
                             │              │
           ┌─────────────────▼──┐     ┌────▼──────────────────────────────┐
           │    car_listing     │     │  (bruges som FK i flere tabeller) │
           │────────────────────│     └───────────────────────────────────┘
           │ id                 │
           │ car_id    (FK)     │◀──────────────────────────────────┐
           │ seller_id (FK)     │                                   │
           │ address_id(FK)     │──────────────┐                    │
           │ description        │              │                    │
           │ created_at         │              │                    │
           └───┬──────────┬─────┘              │                    │
               │          │ 1                  │ N                  │ N
             1 │        ┌─▼───────────┐   ┌────▼──────────┐   ┌────▼──────────┐
               │        │  car_sale   │   │   favorite    │   │   message     │
               │        │─────────────│   │───────────────│   │───────────────│
               │        │ id          │   │ id            │   │ id            │
             N │        │ car_listing │   │ user_id (FK)  │   │ sender_id(FK) │
               │        │ buyer_id(FK)│   │ car_listing   │   │ receiver_id   │
               │        │ sold_at     │   │   _id (FK)    │   │ car_listing   │
               │        │             │   │ created_at    │   │   _id (FK)    │
               │        │ UNIQUE(car_ │   │               │   │ content, text │
               │        │ listing_id) │   │ UNIQUE(user,  │   │ sent_at       │
               │        └─────────────┘   │   listing)    │   │ is_read       │
               │                          └───────────────┘   └───────────────┘
               │
  ┌────────────▼────────┐
  │        car          │
  │─────────────────────│
  │ id                  │
  │ model_id   (FK)     │──▶ ┌─────────┐     ┌──────────┐
  │ fuel_type_id (FK)   │    │  model  │     │  brand   │
  │ price, year         │    │─────────│N   1│──────────│
  │ mileage_km, color   │    │ id      │────▶│ id       │
  └─────────────────────│    │ name    │     │ name     │
                        │    │brand_id │     └──────────┘
  ┌─────────────────────┘    └─────────┘
  │
  └──▶ ┌─────────────┐     ┌──────────┐     ┌──────────┐
       │  fuel_type  │     │ address  │     │  region  │
       │─────────────│     │──────────│N   1│──────────│
       │ id, name    │     │ id       │────▶│ id       │
       └─────────────┘     │ street   │     │ name     │
                           │postal_code     └──────────┘
                           │ city     │
                           │region_id │
                           └──────────┘

  ┌───────────────────────────┐
  │    car_listing_audit      │
  │───────────────────────────│
  │ id                        │
  │ listing_id (NOT NULL)     │
  │ action     (VARCHAR(10))  │  -- 'INSERT','SOLD','DELETE','UPDATE'
  │ changed_at (TIMESTAMP)    │
  │ changed_by (BIGINT)       │
  │ old_price  (DECIMAL)      │
  │ new_price  (DECIMAL)      │
  └───────────────────────────┘
```

---

## 6. Database-lag (SQL_scripts/)

```
  ┌──────────────────────────────────────────────────────────────────────┐
  │  MySQL Database                                                      │
  │                                                                      │
  │  TABELLER (01_schema.sql)          VIEWS (04_views.sql)             │
  │  ┌──────────────────────┐          ┌──────────────────────────────┐  │
  │  │ role                 │          │ active_listings              │  │
  │  │ app_user             │          │   car + listing + seller     │  │
  │  │ address / region     │          │   + adresse + model + brand  │  │
  │  │ brand / model        │   ────▶  │   (kun ikke-solgte)          │  │
  │  │ fuel_type            │          ├──────────────────────────────┤  │
  │  │ car                  │          │ car_details                  │  │
  │  │ car_listing          │          │   fuld bil-detalje pr. id    │  │
  │  │ car_sale             │          ├──────────────────────────────┤  │
  │  │ favorite             │          │ user_favorites               │  │
  │  │ message              │          │   brugerens favoritter       │  │
  │  │ car_listing_audit    │          ├──────────────────────────────┤  │
  │  └──────────────────────┘          │ user_messages                │  │
  │                                    │   beskeder med brugernavne   │  │
  │                                    └──────────────────────────────┘  │
  │                                                                      │
  │  TRIGGERS (05_audit_triggers.sql)  EVENTS (07_events.sql)           │
  │  ┌──────────────────────────────┐  ┌──────────────────────────────┐  │
  │  │ BEFORE INSERT message:       │  │ Scheduled cleanup-events     │  │
  │  │  sender != receiver          │  │ (kører periodisk i DB)       │  │
  │  │  listing ikke solgt          │  └──────────────────────────────┘  │
  │  │ BEFORE INSERT favorite:      │                                    │
  │  │  listing ikke solgt          │  STORED PROCS (06_transactions)   │
  │  │ BEFORE INSERT car:           │  ┌──────────────────────────────┐  │
  │  │  årstal-validering           │  │ Eksplicitte transaktioner    │  │
  │  │ AFTER INSERT car_listing     │  │ med ROLLBACK-håndtering      │  │
  │  │  → car_listing_audit         │  └──────────────────────────────┘  │
  │  │ AFTER DELETE car_listing     │                                    │
  │  │  → car_listing_audit         │                                    │
  │  │ AFTER INSERT car_sale        │                                    │
  │  │  → car_listing_audit (SOLD)  │                                    │
  │  │ AFTER UPDATE car (pris)      │                                    │
  │  │  → car_listing_audit         │                                    │
  │  │ (SQLState 45000 → 400 i API) │                                    │
  │  └──────────────────────────────┘                                    │
  │                                                                      │
  │  INDEKSER (03_indexing.sql)                                          │
  │  seller_id, buyer_id, sender/                                        │
  │  receiver_id, model_id, brand_id                                     │
  └──────────────────────────────────────────────────────────────────────┘
```

---

## 7. Frontend — SPA-router (app.js)

```
  Browser-navigation (navigate(view))
  │
  ├─▶  'listings'   ──▶  showListings()   ──▶  GET /api/listings?[filters]
  │                        └─ openDetail(id)  ──▶  GET /api/cars/{id}
  │                        └─ openMessageModal()
  │                        └─ doAddFav()      ──▶  POST /api/favorites
  │
  ├─▶  'messages'   ──▶  showMessages()
  │                        ├─ tab: inbox     ──▶  GET /api/messages/inbox
  │                        ├─ tab: outbox    ──▶  GET /api/messages/outbox
  │                        └─ tab: new
  │                             └─ doSend()  ──▶  POST /api/messages
  │
  ├─▶  'favorites'  ──▶  showFavorites()   ──▶  GET /api/favorites
  │                        └─ doRemoveFav() ──▶  DEL /api/favorites/{id}
  │
  ├─▶  'login'      ──▶  showLogin()       ──▶  POST /api/auth/login  → gem JWT
  ├─▶  'register'   ──▶  showRegister()    ──▶  POST /api/auth/register
  ├─▶  'create'     ──▶  showCreate()      ──▶  POST /api/listings
  └─▶  'admin'      ──▶  showAdmin()       ──▶  GET /api/admin/audit
```

---

## 8. Udviklingsmiljø

```
  ┌──────────────────────────────────────────────────────────┐
  │  Lokal maskine                                           │
  │                                                          │
  │  docker_compose/docker-compose.yml                       │
  │  ┌────────────────────────────────────────────────────┐  │
  │  │  MySQL container  :3306                            │  │
  │  │  - init via SQL_scripts/                           │  │
  │  └────────────────────────────────────────────────────┘  │
  │           ▲                                              │
  │           │ JDBC (application-dev.yml)                  │
  │  ┌────────┴───────────────────────────────────────────┐  │
  │  │  backend/  mvn spring-boot:run   :8080             │  │
  │  │  (DevDataInitializer seeder ved dev-profil)        │  │
  │  └────────────────────────────────────────────────────┘  │
  │           ▲                                              │
  │           │ HTTP                                         │
  │  ┌────────┴───────────────────────────────────────────┐  │
  │  │  frontend/  (åbn index.html i browser)             │  │
  │  └────────────────────────────────────────────────────┘  │
  │           ▲                                              │
  │           │ HTTP (Playwright)                            │
  │  ┌────────┴───────────────────────────────────────────┐  │
  │  │  api-tests/  npx playwright test                   │  │
  │  └────────────────────────────────────────────────────┘  │
  └──────────────────────────────────────────────────────────┘
```
