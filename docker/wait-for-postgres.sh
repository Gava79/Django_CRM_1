#!/bin/bash
# wait-for-postgres.sh

set -e

host="$1"
shift
cmd=( "$@" )

echo "Testing Postgres connection with psql ..."

# Wait for PostgreSQL to be available
until PGPASSWORD="$DBPASSWORD" psql -h "$host" -U "$DBUSER" -d "$DBNAME" -c "\q" >/dev/null 2>&1; do
  >&2 echo -n "."
  sleep 1
done

# Notify that PostgreSQL is ready and execute the passed command
>&2 echo "Postgres is up - executing command"
exec "${cmd[@]}"
