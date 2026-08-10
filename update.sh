#!/bin/bash
# This ensures the update script will *halt* if
# any one command fails (e.g., stopping a Docker
# image) preventing data corruption
set -e

# Update Ubuntu
(apt update && apt upgrade -y)

# Pull and update all Docker images with minimal downtime
(cd immich/ && docker compose pull && docker compose up -d)
(cd lab/ && docker compose pull && docker compose up -d)
(cd memos/ && docker compose pull && docker compose up -d)

# Cleanup unused images
docker image prune -f

# Update successful
echo "Success!"
