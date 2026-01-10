#!/usr/bin/env bash
set -euo pipefail

OUT="n8n-backup-$(date +%F-%H%M%S).tar.gz"
docker run --rm -v n8n_data:/data -v "$PWD":/backup alpine \
  tar czf "/backup/$OUT" -C /data .

echo "Backup created: $OUT"