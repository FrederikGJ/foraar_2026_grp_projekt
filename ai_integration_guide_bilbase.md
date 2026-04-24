# AI integration og test – Bilbase

## Formål
I Bilbase-projektet er AI integration implementeret som en lokal moderation- og kvalitetskontrolfunktion for annoncebeskrivelser. Formålet er at kunne analysere en annoncebeskrivelse og vurdere, om teksten fremstår som spam, lav kvalitet, irrelevant eller passende til en seriøs bilannonce.

Løsningen er bygget som en backend-integration mellem Spring Boot og en lokal AI-model, der køres via Ollama. Resultatet fra AI’en gemmes på den enkelte annonce og kan efterfølgende returneres via backendens API.

## Hvad AI integrationen gør
Når en annonce er oprettet, kan backend kalde et dedikeret endpoint, som sender annoncebeskrivelsen til den lokale AI-model. AI’en returnerer en vurdering i form af moderationsdata.

Følgende felter bruges i løsningen:

- `aiFlagged` – angiver om annoncen vurderes som problematisk
- `aiCategory` – kategori som fx `OK`, `SPAM`, `LOW_QUALITY`, `INAPPROPRIATE` eller `IRRELEVANT`
- `aiModerationNote` – kort forklaring fra AI’en
- `aiCheckedAt` – tidspunkt for hvornår moderation blev kørt

## Arkitektur for AI integrationen
AI integrationen indgår i backendens lagdelte struktur:

- Controller-laget eksponerer moderation-endpointet
- Service-laget håndterer moderationslogikken
- AI-klienten kommunikerer med den lokale model
- Domain-/entity-laget repræsenterer annoncen og AI-felterne
- Persistenslaget gemmer resultatet i MySQL

Det betyder, at løsningen følger samme arkitektoniske principper som resten af CRUD-applikationen.

## Teknisk implementering
Den tekniske løsning består af følgende dele:

### Database
Tabellen `car_listing` er udvidet med disse felter:

- `ai_flagged`
- `ai_category`
- `ai_moderation_note`
- `ai_checked_at`

Disse felter bruges til at lagre moderationsresultatet direkte på annoncen.

### Domain/entity
`CarListing` er udvidet med tilsvarende felter i backendens entity-model, så AI-data kan læses og gemmes gennem JPA/Hibernate.

### DTO
`ListingResponse` returnerer nu også AI-relaterede felter, så resultatet kan ses i API-svar.

### AI-klient
Den lokale AI integration er implementeret i en klientklasse, der sender annoncebeskrivelsen til Ollama på:

`http://localhost:11434/api/generate`

Der anvendes modellen `llama3`.

### Service
`AiModerationService` finder den relevante annonce, kalder AI-klienten, opdaterer moderationsfelterne og gemmer ændringerne i databasen.

### Controller
`ListingController` er udvidet med endpointet:

`POST /api/listings/{id}/moderate`

Dette endpoint kræver authentication og bruges til at køre moderation på en eksisterende annonce.

## Hvordan AI’en vurderer spam
AI’en får annoncebeskrivelsen som input via en prompt. Prompten instruerer modellen i at analysere teksten og klassificere den i en fast kategori.

AI’en vurderer ikke spam ud fra hårdkodede `if`-regler, men ud fra:

- promptens instruktioner
- modellens sproglige forståelse
- dens evne til at genkende mønstre i tekst

Det betyder, at AI’en fx kan reagere på:

- overdreven brug af udråbstegn
- spam-lignende formuleringer
- manglende reel information om bilen
- useriøs eller irrelevant tekst

Et eksempel på en spam-lignende beskrivelse er:

`Mega fed bil!!! skriv på snap billig billig!!!`

Her vurderede AI’en annoncen som:

- `aiFlagged = true`
- `aiCategory = "SPAM"`

## Test af AI integrationen
AI integrationen testes manuelt via Postman.

### Testflow
1. Log ind via backendens auth-endpoint
2. Hent JWT-token
3. Opret eller find en annonce
4. Kald moderation-endpointet med annonce-id
5. Kontroller at moderationsfelterne returneres korrekt

### Brugte requests i Postman
Collection:

**Bilbase - AI Moderation Test**

Requests:

1. **Auth - Login dealer1**
2. **Listings - Get listings**
3. **AI - Moderate listing**

### Login-request
Der logges ind med en dealer-bruger for at få et gyldigt Bearer token.

Eksempel:

- `POST /api/auth/login`
- body med brugernavn og password

### Hent annoncer
Efter login bruges `GET /api/listings` til at finde en annonce og dens `id`.

### Kør moderation
Moderation testes via:

`POST /api/listings/{id}/moderate`

Requesten sendes med Bearer token, og der bruges ingen request body.

## Resultat af testen
Løsningen blev testet på en annonce oprettet af `dealer1` med en tydelig spam-lignende beskrivelse.

Eksempel på testbeskrivelse:

`Mega fed bil!!! skriv på snap billig billig!!!`

Ved kald til moderation-endpointet blev annoncen returneret med følgende resultat:

- `aiFlagged = true`
- `aiCategory = "SPAM"`
- `aiCheckedAt` blev sat

Det viser, at:

- endpointet virker
- authentication virker
- backend kan kalde den lokale AI-model
- AI-resultatet parses korrekt
- moderationsdata gemmes i databasen
- de nye felter returneres i API-svaret

## Manuel og ikke automatisk moderation
I den nuværende version kører AI moderation ikke automatisk, når en annonce oprettes. Moderationen udføres manuelt via endpointet.

Det betyder:

- annoncen oprettes først normalt
- bagefter kan AI moderation kaldes på annoncen
- resultatet gemmes derefter i databasen

Denne løsning gør det nemt at teste og demonstrere integrationen, uden at moderation nødvendigvis skal køre ved hver oprettelse eller opdatering.

## Fordele ved den valgte løsning
Den valgte løsning har flere fordele:

- AI integrationen er reel og ikke stub-baseret
- modellen kører lokalt og kræver ingen ekstern API-nøgle
- løsningen passer ind i backendens eksisterende arkitektur
- moderationsresultatet gemmes som en del af datamodellen
- integrationen kan testes og dokumenteres tydeligt i Postman

## Mulige videreudviklinger
Løsningen kan udvides på flere måder:

- automatisk moderation ved oprettelse af annonce
- automatisk moderation ved redigering af annonce
- visning af moderationsstatus i frontend
- strengere håndtering af spam- eller lavkvalitetstekster
- forbedring af prompten, så `aiModerationNote` altid udfyldes mere præcist

## Delkonklusion
AI integrationen i Bilbase er implementeret som en lokal moderationstjeneste, der analyserer annoncebeskrivelser via en lokal `llama3`-model kørt gennem Ollama. Løsningen er integreret i backendens controller-, service- og persistenslag og kan testes gennem et dedikeret endpoint i Postman. Testen viser, at systemet kan identificere spam-lignende beskrivelser, gemme moderationsresultatet i databasen og returnere det som en del af annonceobjektet.

