#!/usr/bin/env bash
# health_check.sh - CPU, RAM, Disk check karta hai aur threshold cross hone par WARNING deta hai
set -euo pipefail

CPU_LIMIT="${CPU_LIMIT:-80}"
MEM_LIMIT="${MEM_LIMIT:-80}"
DISK_LIMIT="${DISK_LIMIT:-80}"
LOG_DIR="${LOG_DIR:-$(dirname "$0")/../logs}"
LOG_FILE="$LOG_DIR/health.log"
mkdir -p "$LOG_DIR"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"; }

# CPU usage (/proc/stat se, 1 second sample)
read -r _ u1 n1 s1 i1 _ < /proc/stat
sleep 1
read -r _ u2 n2 s2 i2 _ < /proc/stat
total=$(( (u2+n2+s2+i2) - (u1+n1+s1+i1) ))
idle=$(( i2 - i1 ))
cpu=$(( total > 0 ? 100 * (total - idle) / total : 0 ))

mem=$(free | awk '/Mem:/ {printf "%d", $3/$2*100}')
disk=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

log "CPU=${cpu}% MEM=${mem}% DISK=${disk}%"

status=0
if [ "$cpu"  -ge "$CPU_LIMIT" ];  then log "WARNING: CPU high ($cpu%)";  status=1; fi
if [ "$mem"  -ge "$MEM_LIMIT" ];  then log "WARNING: Memory high ($mem%)"; status=1; fi
if [ "$disk" -ge "$DISK_LIMIT" ]; then log "WARNING: Disk high ($disk%)"; status=1; fi
if [ "$status" -eq 0 ]; then log "OK: sab kuch normal hai"; fi
exit "$status"
