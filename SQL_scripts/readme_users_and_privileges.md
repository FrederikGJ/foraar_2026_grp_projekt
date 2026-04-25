# MySQL-forbindelser og brugerrettigheder – Bilbasen

## Overblik
Denne fil dokumenterer de MySQL-forbindelser, der er oprettet til Bilbasen-projektet, og forklarer hvad hver databasebruger kan og ikke kan gøre.

Disse brugere er database-brugere på MySQL-niveau.  
De er ikke det samme som applikationens brugere i `app_user`-tabellen, såsom `dealer1`, `admin` eller `customer`.

---

## 1. root

**Formål:**  
Administrator for hele MySQL-serveren.

**Forbindelsesoplysninger:**
- Hostname: `127.0.0.1`
- Port: `3307`
- Username: `root`
- Password: `123456` *(eller den root-adgangskode der er konfigureret i miljøet)*
- Default schema: `bilbase_projekt`

**Rettigheder:**
- Fuld adgang til hele MySQL-serveren
- Kan se og administrere alle databaser
- Kan oprette og slette databaser
- Kan oprette, opdatere og slette MySQL-brugere
- Kan give og fjerne privileges
- Kan læse, indsætte, opdatere og slette alle data

**Bruges til:**
- Administration i MySQL Workbench
- Kørsel af scripts til users og privileges
- Administration af selve databaseserveren

---

## 2. bilbase_app

**Formål:**  
Applikationens databasebruger til backend.

**Forbindelsesoplysninger:**
- Hostname: `127.0.0.1`
- Port: `3307`
- Username: `bilbase_app`
- Password: `app123`
- Default schema: `bilbase_projekt`

**Rettigheder:**
- `SELECT`
- `INSERT`
- `UPDATE`
- `DELETE`
- `EXECUTE`

**Det betyder:**
- Kan læse applikationens data
- Kan oprette nye data
- Kan opdatere eksisterende data
- Kan slette data
- Kan udføre stored procedures/functions efter behov

**Det kan brugeren ikke:**
- Kan ikke oprette MySQL-brugere
- Kan ikke slette MySQL-brugere
- Kan ikke give privileges
- Kan ikke administrere MySQL-serveren

**Bruges til:**
- Almindelige backend-/databaseoperationer

---

## 3. bilbase_readonly

**Formål:**  
Read-only databasebruger.

**Forbindelsesoplysninger:**
- Hostname: `127.0.0.1`
- Port: `3307`
- Username: `bilbase_readonly`
- Password: `readonly123`
- Default schema: `bilbase_projekt`

**Rettigheder:**
- `SELECT` på `bilbase_projekt.*`

**Det betyder:**
- Kan kun læse data fra databasen
- Kan ikke oprette, opdatere eller slette data

**Det kan brugeren ikke:**
- Kan ikke bruge `INSERT`
- Kan ikke bruge `UPDATE`
- Kan ikke bruge `DELETE`
- Kan ikke oprette MySQL-brugere
- Kan ikke give privileges
- Kan ikke administrere MySQL-serveren

**Bruges til:**
- Sikker read-only adgang
- Rapportering eller inspektion uden risiko for at ændre data

---

## 4. bilbase_restricted

**Formål:**  
Begrænset read-only databasebruger.

**Forbindelsesoplysninger:**
- Hostname: `127.0.0.1`
- Port: `3307`
- Username: `bilbase_restricted`
- Password: `restricted123`
- Default schema: `bilbase_projekt`

**Rettigheder:**
Denne bruger har kun `SELECT` på udvalgte ikke-følsomme tabeller/views:
- `brand`
- `model`
- `fuel_type`
- `region`
- `active_listings`

**Det betyder:**
- Kan kun læse udvalgte ikke-følsomme data
- Kan ikke læse alle tabeller i databasen
- Kan ikke oprette, opdatere eller slette data

**Det kan brugeren ikke:**
- Kan ikke bruge `INSERT`
- Kan ikke bruge `UPDATE`
- Kan ikke bruge `DELETE`
- Kan ikke læse følsomme tabeller som:
  - `app_user`
  - `message`
  - `favorite`
- Kan ikke oprette MySQL-brugere
- Kan ikke give privileges
- Kan ikke administrere MySQL-serveren

**Bruges til:**
- Meget begrænset databaseadgang
- Kontrolleret adgang til udvalgte offentlige/ikke-følsomme data

---

## 5. bilbase_admin

**Formål:**  
Databaseadministrator for den enkelte projektdatabase.

**Forbindelsesoplysninger:**
- Hostname: `127.0.0.1`
- Port: `3307`
- Username: `bilbase_admin`
- Password: `admin123`
- Default schema: `bilbase_projekt`

**Rettigheder:**
- `ALL PRIVILEGES` på `bilbase_projekt.*`

**Det betyder:**
- Fuld adgang til alt inde i databasen `bilbase_projekt`
- Kan læse, indsætte, opdatere og slette alle data i denne database
- Kan arbejde med tabeller, views, procedures, functions, triggers og events i projektdatabasen

**Vigtig note:**
- Denne bruger er ikke det samme som `root`
- Brugeren har fuld adgang til den enkelte projektdatabase
- Brugeren har ikke automatisk fulde server-wide MySQL-administrationsrettigheder
- Brugeren kan ikke nødvendigvis oprette nye MySQL-brugere, medmindre globale privileges gives særskilt

**Bruges til:**
- Fuld administration af `bilbase_projekt`-databasen

---

## Opsummering

### Forskel på applikationsbrugere og MySQL-brugere
Applikationsbrugere som `dealer1`, `admin` og `customer` tilhører selve Bilbasen-systemet og gemmes i `app_user`-tabellen.

MySQL-brugere som `root`, `bilbase_app`, `bilbase_readonly`, `bilbase_restricted` og `bilbase_admin` er databasebrugere, som bruges til at forbinde til MySQL og styre, hvad den enkelte forbindelse må gøre.

### Kort opsummering af rollerne
- `root` → fuld administrator for hele MySQL-serveren
- `bilbase_app` → normal applikationsbruger til databasen
- `bilbase_readonly` → read-only adgang til hele projektdatabasen
- `bilbase_restricted` → begrænset read-only adgang til udvalgte tabeller/views
- `bilbase_admin` → fuld adgang til alt inde i `bilbase_projekt`

