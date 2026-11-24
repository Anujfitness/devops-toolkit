#!/usr/bin/env bash
# backup.sh - kisi folder ka .tar.gz backup banata hai aur purane backups delete karta hai
# Usage: ./backup.sh <source_dir> [backup_dir] [keep_count]
set -euo pipefail

SRC="${1:-}"
DEST="${2:-$(dirname "$0")/../backups}"
KEEP="${3:-5}"

if [ -z "$SRC" ] || [ ! -d "$SRC" ]; then
  echo "Usage: $0 <source_dir> [backup_dir] [keep_count]" >&2
  exit 1
fi

mkdir -p "$DEST"
NAME="backup_$(basename "$SRC")_$(date +%Y%m%d_%H%M%S).tar.gz"
tar -czf "$DEST/$NAME" -C "$(dirname "$SRC")" "$(basename "$SRC")"
echo "Backup ban gaya: $DEST/$NAME"

# Rotation: sirf latest $KEEP rakho
ls -1t "$DEST"/backup_*.tar.gz 2>/dev/null | tail -n +$((KEEP+1)) | xargs -r rm -f
echo "Rotation done (latest $KEEP backups rakhe gaye)"
