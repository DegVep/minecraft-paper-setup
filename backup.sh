#!/usr/bin/env bash
# Compressed world backup. Keeps the latest KEEP backups.
# Cron usage (every day at 4:00):  0 4 * * * /path/to/server/backup.sh
set -euo pipefail
cd "$(dirname "$0")"
DEST="${DEST:-./backups}"
KEEP="${KEEP:-7}"
mkdir -p "$DEST"
STAMP="$(date +%Y-%m-%d_%H-%M)"
tar -czf "$DEST/world_$STAMP.tar.gz" world world_nether world_the_end 2>/dev/null || \
tar -czf "$DEST/world_$STAMP.tar.gz" world
ls -1t "$DEST"/world_*.tar.gz | tail -n +$((KEEP+1)) | xargs -r rm --
echo "Backup created: $DEST/world_$STAMP.tar.gz"
