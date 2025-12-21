#!/usr/bin/env bash

# Create an additional user with limited privileges

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ${MYAPP_USERNAME} WITH PASSWORD '${MYAPP_PASSWORD}';
    GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO ${MYAPP_USERNAME};
EOSQL
