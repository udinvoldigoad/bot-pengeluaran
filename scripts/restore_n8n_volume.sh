#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <backup.tar.gz>"
  exit 1
fi

FILE="$1"
docker run --rm -v n8n_data:/data -v "$PWD":/backup alpine \
  sh -c "rm -rf /data/* && tar xzf /backup/$FILE -C /data"

echo "Restore complete from: $FILE"
