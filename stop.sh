#!/usr/bin/env bash

DIR="$(cd "$(dirname "$0")" && pwd)"
PIDFILE="$DIR/.pids"

if [ ! -f "$PIDFILE" ]; then
  echo "No .pids file found — nothing to stop."
  exit 0
fi

while IFS='=' read -r name pid; do
  if kill -0 "$pid" 2>/dev/null; then
    echo "Stopping $name (pid $pid)..."
    kill "$pid" 2>/dev/null
    for i in $(seq 1 10); do
      kill -0 "$pid" 2>/dev/null || break
      sleep 0.5
    done
    if kill -0 "$pid" 2>/dev/null; then
      echo "  Force killing $name..."
      kill -9 "$pid" 2>/dev/null || true
    fi
  else
    echo "$name (pid $pid) already stopped."
  fi
done < "$PIDFILE"

rm -f "$PIDFILE"
echo "All services stopped."
