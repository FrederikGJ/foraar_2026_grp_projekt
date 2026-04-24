# Bilbase Frontend

Simpel HTML/CSS/JS frontend til Bilbase backend-API'et.

---

## Forudsætninger

Sørg for at backend og database kører, inden du starter frontenden.

**1. Start MySQL (Docker):**
```bash
cd docker_compose
docker compose up -d
```

**2. Start Spring Boot backend:**
```bash
cd backend
./mvnw spring-boot:run
```

Backenden kører på `http://localhost:8080`.

---

## Start frontenden

```bash
cd frontend
npx serve .
```

Åbn `http://localhost:3000` i din browser.

> **Alternativt** kan du bruge VS Code Live Server (højreklik på `index.html` → *Open with Live Server*). Den serverer typisk på `http://localhost:5500`.

---

## Brugertest — login-profiler

Alle testbrugere har adgangskoden **`password123`**.

### Admin

| Felt | Værdi |
|---|---|
| Brugernavn | `admin` |
| Adgangskode | `password123` |
| Rolle | ADMIN |

**Hvad du kan teste:**
- Se alle annoncer og klik ind på detaljer
- Åbn **Admin**-fanen og se den fulde auditlog (oprettelser, prisopdateringer, sletninger)
- Send beskeder til andre brugere via **Beskeder**-fanen
- Opret annoncer (admin har samme rettigheder som dealer)

---

### Forhandler (Dealer)

| Felt | Værdi |
|---|---|
| Brugernavn | `dealer1` |
| Adgangskode | `password123` |
| Rolle | DEALER |

Andre forhandlere du kan logge ind med: `dealer2` … `dealer20` (samme adgangskode).

**Hvad du kan teste:**
- Åbn **Mine annoncer** og se dine egne annoncer
- Opret en ny annonce via formularen (vælg mærke → model udfyldes automatisk)
- Klik på en af dine egne annoncer → **Rediger** pris/beskrivelse eller **Slet**
- Forsøg at slette en annonce med et salg tilknyttet → du får en 409-fejl
- Se beskeder fra kunder i **Beskeder → Indbakke**

---

### Kunde (Customer)

| Felt | Værdi |
|---|---|
| Brugernavn | `customer22` |
| Adgangskode | `password123` |
| Rolle | CUSTOMER |

**Hvad du kan teste:**
- Brug søgefiltrene (mærke, brændstof, pris, årgang) til at finde annoncer
- Klik på en annonce → **Tilføj favorit** eller **Køb bilen**
- Åbn **Favoritter**-fanen og fjern en favorit
- Forsøg at tilføje en allerede købt (solgt) bil til favoritter → du får en fejl
- Send en besked til en forhandler via **Kontakt sælger** i detalje-modalen
- Tjek **Beskeder → Sendt** for at se beskeden

---

### Ny bruger (registrering)

Klik **Log ind** → **Registrer her** og udfyld formularen.
Nye brugere får automatisk rollen **CUSTOMER**.

---

## Rolle-oversigt

| Rolle | Annoncer | Mine annoncer | Favoritter | Beskeder | Admin |
|---|---|---|---|---|---|
| Ikke logget ind | Læse | — | — | — | — |
| CUSTOMER | Læse + Køb | — | Ja | Ja | — |
| DEALER | Læse | Opret/Rediger/Slet | — | Ja | — |
| ADMIN | Læse | Opret/Rediger/Slet | — | Ja | Ja |
