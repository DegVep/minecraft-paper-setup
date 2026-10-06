#!/usr/bin/env bash
# Backup comprimido de los mundos. Conserva los últimos KEEP backups.
# Uso con cron (cada día a las 4:00):  0 4 * * * /ruta/al/servidor/backup.sh
set -euo pipefail
cd "$(dirname "$0")"
DEST="${DEST:-./backups}"
KEEP="${KEEP:-7}"
mkdir -p "$DEST"
STAMP="$(date +%Y-%m-%d_%H-%M)"
tar -czf "$DEST/world_$STAMP.tar.gz" world world_nether world_the_end 2>/dev/null || \
tar -czf "$DEST/world_$STAMP.tar.gz" world
ls -1t "$DEST"/world_*.tar.gz | tail -n +$((KEEP+1)) | xargs -r rm --
echo "Backup creado: $DEST/world_$STAMP.tar.gz"
