#!/usr/bin/env bash
set -euo pipefail
echo "Waiting for Supabase DB to be ready..."
until pg_isready -h db -p 5432 -U postgres >/dev/null 2>&1; do
  sleep 1
done
echo "Supabase is ready."
