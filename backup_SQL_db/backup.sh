#!/bin/bash

# ─────────────────────────────────────────────
# MySQL Backup Script - Bilbase Projekt
# Krav: Docker skal kore, container Bilbase_MySQL
# ─────────────────────────────────────────────

CONTAINER="Bilbase_MySQL"
DB_NAME="bilbase_projekt"
DB_USER="user"
DB_PASS="123456"
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$TIMESTAMP.sql"

# Opret backup-mappe hvis den ikke findes
mkdir -p "$BACKUP_DIR"

echo "--- Starter backup af '$DB_NAME' ---"
echo "Tidsstempel : $TIMESTAMP"
echo "Destination : $BACKUP_FILE"
echo ""

# Tjek om containeren korer
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER}$"; then
    echo "[FEJL] Containeren '$CONTAINER' korer ikke."
    echo "Start den med: docker compose up -d"
    exit 1
fi

# Udfør backup via mysqldump inde i containeren
docker exec "$CONTAINER" \
    mysqldump \
    --user="$DB_USER" \
    --password="$DB_PASS" \
    --single-transaction \
    --routines \
    --triggers \
    "$DB_NAME" > "$BACKUP_FILE"

# Tjek om det lykkedes
if [ $? -eq 0 ] && [ -s "$BACKUP_FILE" ]; then
    SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
    echo "[OK] Backup gennemfort."
    echo "Filstoerrelse : $SIZE"
    echo "Placering     : $BACKUP_FILE"
else
    echo "[FEJL] Backup mislykkedes eller filen er tom."
    rm -f "$BACKUP_FILE"
    exit 1
fi

# ─────────────────────────────────────────────
# Valgfrit: Slet backups aeldere end 7 dage
# Kommenter ud hvis du ikke vil bruge det
# ─────────────────────────────────────────────
find "$BACKUP_DIR" -name "*.sql" -mtime +7 -delete
echo "Gamle backups (7+ dage) slettet."

echo ""
echo "--- Backup faerdig ---"
