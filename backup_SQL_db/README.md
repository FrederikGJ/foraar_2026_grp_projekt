# Database Backup Script - Bilbase Projekt

Dette script tager en backup af MySQL-databasen `bilbase_projekt` som korer i en Docker container.

---

## Krav

- Mac eller Linux
- Docker skal vaere installeret og kore
- Containeren `Bilbase_MySQL` skal vaere startet (`docker compose up -d`)

> **Windows:** Scriptet virker ikke nativt pa Windows. Det kraever enten WSL (Windows Subsystem for Linux) eller Git Bash.

---

## Kom i gang

### 1. Giv scriptet rettigheder

Forste gang skal du give scriptet tilladelse til at blive eksekveret:

```bash
chmod +x backup.sh
```

Dette beholder du kun gore en gang.

### 2. Kor scriptet

```bash
./backup.sh
```

---

## Hvad sker der nar man korer det?

1. Scriptet tjekker om Docker-containeren `Bilbase_MySQL` korer
2. Hvis ikke, vises en fejlbesked og scriptet stopper
3. Hvis ja, kores `mysqldump` inde i containeren
4. Backup-filen gemmes i mappen `./backups/`
5. Filer aeldere end 7 dage slettes automatisk

---

## Output

Backups gemmes som `.sql`-filer med timestamp i filnavnet:

```
backups/
  bilbase_projekt_2026-04-20_14-30-00.sql
  bilbase_projekt_2026-04-19_09-15-42.sql
```

Datoformatet er `YYYY-MM-DD_HH-MM-SS`, sa filerne sorterer korrekt kronologisk.

---

## Fejlbeskeder

| Besked | Betydning |
|---|---|
| `[FEJL] Containeren korer ikke` | Start containeren med `docker compose up -d` |
| `[FEJL] Backup mislykkedes eller filen er tom` | Tjek at brugernavn og password i scriptet er korrekte |
| `[OK] Backup gennemfort` | Alt gik godt # Database Backup Script - Bilbase Projekt

Dette script tager en backup af MySQL-databasen `bilbase_projekt` som korer i en Docker container.

---

## Krav

- Mac eller Linux
- Docker skal vaere installeret og kore
- Containeren `Bilbase_MySQL` skal vaere startet (`docker compose up -d`)

> **Windows:** Scriptet virker ikke nativt pa Windows. Det kraever enten WSL (Windows Subsystem for Linux) eller Git Bash.

---

## Kom i gang

### 1. Giv scriptet rettigheder

Forste gang skal du give scriptet tilladelse til at blive eksekveret:

```bash
chmod +x backup.sh
```

Dette beholder du kun gore en gang.

### 2. Kor scriptet

```bash
./backup.sh
```

---

## Hvad sker der nar man korer det?

1. Scriptet tjekker om Docker-containeren `Bilbase_MySQL` korer
2. Hvis ikke, vises en fejlbesked og scriptet stopper
3. Hvis ja, kores `mysqldump` inde i containeren
4. Backup-filen gemmes i mappen `./backups/`
5. Filer aeldere end 7 dage slettes automatisk

---

## Output

Backups gemmes som `.sql`-filer med timestamp i filnavnet:

```
backups/
  bilbase_projekt_2026-04-20_14-30-00.sql
    bilbase_projekt_2026-04-19_09-15-42.sql
    ```

    Datoformatet er `YYYY-MM-DD_HH-MM-SS`, sa filerne sorterer korrekt kronologisk.

    ---

    ## Fejlbeskeder

    | Besked | Betydning |
    |---|---|
    | `[FEJL] Containeren korer ikke` | Start containeren med `docker compose up -d` |
    | `[FEJL] Backup mislykkedes eller filen er tom` | Tjek at brugernavn og password i scriptet er korrekte |
    | `[OK] Backup gennemfort` | Alt gik godt ||
