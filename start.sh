#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
PIDFILE="$DIR/.pids"

if [ -f "$PIDFILE" ]; then
  echo "Services seem to be running already. Run ./stop.sh first."
  exit 1
fi

> "$PIDFILE"

LOGDIR="$DIR/.logs"
mkdir -p "$LOGDIR"

echo "Starting backend (port 8080)..."
cd "$DIR/backend"
mvn -q spring-boot:run > "$LOGDIR/backend.log" 2>&1 &
echo "backend=$!" >> "$PIDFILE"
echo "  backend started with PID $!"

echo "Starting backend_neo4j (port 8081)..."
cd "$DIR/backend_neo4j"
mvn -q spring-boot:run > "$LOGDIR/backend_neo4j.log" 2>&1 &
echo "backend_neo4j=$!" >> "$PIDFILE"
echo "  backend_neo4j started with PID $!"

echo "Starting mongodb_backend (port 8082)..."
cd "$DIR/mongodb/mongodb_backend"
mvn -q spring-boot:run -Dspring-boot.run.arguments=--server.port=8082 > "$LOGDIR/mongodb_backend.log" 2>&1 &
echo "mongodb_backend=$!" >> "$PIDFILE"
echo "  mongodb_backend started with PID $!"

echo "Starting frontend (port 3000)..."
cd "$DIR/frontend"
python3 -m http.server 3000 > "$LOGDIR/frontend.log" 2>&1 &
echo "frontend=$!" >> "$PIDFILE"
echo "  frontend started with PID $!"

echo ""
echo "All services started:"
echo "  Frontend:         http://localhost:3000"
echo "  Backend (MySQL):  http://localhost:8080"
echo "  Backend (Neo4j):  http://localhost:8081"
echo "  Backend (MongoDB):http://localhost:8082"
echo ""
echo "Logs are in .logs/ — use 'tail -f .logs/<service>.log' to follow."
echo "Run ./stop.sh to stop all services."
