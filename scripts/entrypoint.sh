#!/usr/bin/env bash
# Container start hone par har INTERVAL second me health check + backup chalata hai
set -u
INTERVAL="${INTERVAL:-60}"
echo "DevOps Toolkit started (interval=${INTERVAL}s)"
while true; do
  /app/scripts/health_check.sh || true
  /app/scripts/backup.sh /app/data /app/backups "${KEEP_BACKUPS:-5}" || true
  sleep "$INTERVAL"
done
