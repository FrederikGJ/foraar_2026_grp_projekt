# ─────────────────────────────────────────────
# MySQL Backup Script - Bilbase Projekt
# Krav: Docker skal kore, container Bilbase_MySQL
# ─────────────────────────────────────────────

$CONTAINER  = "Bilbase_MySQL"
$DB_NAME    = "bilbase_projekt"
$DB_USER    = "user"
$DB_PASS    = "123456"
$BACKUP_DIR = ".\backups"
$TIMESTAMP  = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$BACKUP_FILE = "$BACKUP_DIR\${DB_NAME}_$TIMESTAMP.sql"

# Opret backup-mappe hvis den ikke findes
if (-not (Test-Path $BACKUP_DIR)) {
    New-Item -ItemType Directory -Path $BACKUP_DIR | Out-Null
}

Write-Host "--- Starter backup af '$DB_NAME' ---"
Write-Host "Tidsstempel : $TIMESTAMP"
Write-Host "Destination : $BACKUP_FILE"
Write-Host ""

# Tjek om containeren korer
$running = docker ps --format "{{.Names}}" | Where-Object { $_ -eq $CONTAINER }

if (-not $running) {
    Write-Host "[FEJL] Containeren '$CONTAINER' korer ikke."
    Write-Host "Start den med: docker compose up -d"
    exit 1
}

# Udfør backup via mysqldump inde i containeren
docker exec $CONTAINER `
    mysqldump `
    --user=$DB_USER `
    --password=$DB_PASS `
    --single-transaction `
    --routines `
    --triggers `
    $DB_NAME | Out-File -FilePath $BACKUP_FILE -Encoding utf8

# Tjek om det lykkedes
if ($LASTEXITCODE -eq 0 -and (Test-Path $BACKUP_FILE) -and (Get-Item $BACKUP_FILE).Length -gt 0) {
    $size = "{0:N1} KB" -f ((Get-Item $BACKUP_FILE).Length / 1KB)
    Write-Host "[OK] Backup gennemfort."
    Write-Host "Filstoerrelse : $size"
    Write-Host "Placering     : $BACKUP_FILE"
} else {
    Write-Host "[FEJL] Backup mislykkedes eller filen er tom."
    Remove-Item -Path $BACKUP_FILE -ErrorAction SilentlyContinue
    exit 1
}

# ─────────────────────────────────────────────
# Valgfrit: Slet backups aeldere end 7 dage
# Kommenter ud hvis du ikke vil bruge det
# ─────────────────────────────────────────────
Get-ChildItem -Path $BACKUP_DIR -Filter "*.sql" |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } |
    Remove-Item
Write-Host "Gamle backups (7+ dage) slettet."

Write-Host ""
Write-Host "--- Backup faerdig ---"
