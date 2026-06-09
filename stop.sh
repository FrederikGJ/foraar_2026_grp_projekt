#!/usr/bin/env bash

NAMES="backend backend_neo4j mongodb_backend frontend"
PORTS="8080 8081 8082 3000"

stopped=0
i=1
for name in $NAMES; do
  port=$(echo "$PORTS" | cut -d' ' -f$i)
  i=$((i + 1))
  pids=$(lsof -ti :"$port" 2>/dev/null)
  if [ -n "$pids" ]; then
    echo "Stopping $name (port $port, pids: $pids)..."
    echo "$pids" | xargs kill 2>/dev/null
    for _ in $(seq 1 10); do
      lsof -ti :"$port" >/dev/null 2>&1 || break
      sleep 0.5
    done
    if lsof -ti :"$port" >/dev/null 2>&1; then
      echo "  Force killing $name..."
      lsof -ti :"$port" 2>/dev/null | xargs kill -9 2>/dev/null || true
    fi
    stopped=$((stopped + 1))
  else
    echo "$name (port $port) not running."
  fi
done

rm -f "$(cd "$(dirname "$0")" && pwd)/.pids"

if [ $stopped -gt 0 ]; then
  echo "Stopped $stopped service(s)."
else
  echo "No services were running."
fi
