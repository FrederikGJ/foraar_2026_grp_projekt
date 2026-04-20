# Database Backup Script - Bilbase Projekt

Dette script tager en backup af MySQL-databasen `bilbase_projekt` som korer i en Docker container.

---

## Krav

- Docker skal vaere installeret og kore
- Containeren `Bilbase_MySQL` skal vaere startet (`docker compose up -d`)

---

## 1. Backup - Mac / Linux

Giv scriptet rettigheder forste gang:

```bash
chmod +x backup.sh
```

Kor backup:

```bash
./backup.sh
```

---

## 2. Backup - Windows (PowerShell)

Tillad koersel af scripts forste gang - abn PowerShell som administrator og kors:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Kor backup:

```powershell
.\backup.ps1
```

---

## 3. Gendannelse af backup (Restore)

Backups gemmes i mappen `./backups/` med timestamp i filnavnet:

```
backups/
  bilbase_projekt_2026-04-20_14-30-00.sql
  bilbase_projekt_2026-04-19_09-15-42.sql
```

Udskift filnavnet i kommandoerne nedenfor med den backup du vil gendanne.

### Mac / Linux

```bash
docker exec -i Bilbase_MySQL mysql \
  --user=user \
  --password=123456 \
  bilbase_projekt < ./backups/bilbase_projekt_2026-04-20_14-30-00.sql
```

### Windows (PowerShell)

```powershell
Get-Content .\backups\bilbase_projekt_2026-04-20_14-30-00.sql | `
  docker exec -i Bilbase_MySQL mysql `
  --user=user `
  --password=123456 `
  bilbase_projekt
```

---

## Fejlbeskeder

| Besked | Betydning |
|---|---|
| `[FEJL] Containeren korer ikke` | Start containeren med `docker compose up -d` |
| `[FEJL] Backup mislykkedes eller filen er tom` | Tjek at brugernavn og password i scriptet er korrekte |
| `[OK] Backup gennemfort` | Alt gik godt |
