# Database Setup Guide

## Forudsætninger
- Docker Desktop installeret og kørende
- MySQL Workbench installeret

## Start databasen

`docker-compose.yml` filen definerer en lokal MySQL 8.0 instans med følgende konfiguration:
- **Database:** `bilbase_projekt`
- **Bruger:** `user`
- **Password:** `123456`
- **Port:** `3307`

Kør følgende kommando i terminalen fra projektmappen:

```bash
docker compose up -d --build
```

## Forbind via MySQL Workbench

1. Åbn MySQL Workbench og klik **+** ved siden af *MySQL Connections*
2. Udfyld felterne:
   - **Connection Name:** Bilbase Projekt
   - **Hostname:** `127.0.0.1`
   - **Port:** `3307`
   - **Username:** `user`
3. Klik **Test Connection**, indtast password `123456`
4. Klik **OK** – forbindelsen er klar. 
