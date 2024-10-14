#!/bin/bash

service postgresql start
sleep 5

postgres -c "psql -tc \"SELECT 1 FROM pg_database WHERE datname = '${DB_NAME}'\" | grep -q 1 || psql -c \"CREATE DATABASE \\\"${DB_NAME}\\\";\""

postgres -c "psql -tc \"SELECT 1 FROM pg_roles WHERE rolname = '${DB_USER}'\" | grep -q 1 || psql -c \"CREATE USER \\\"${DB_USER}\\\" WITH PASSWORD '${DB_PASSWORD}';\""

postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE \\\"${DB_NAME}\\\" TO \\\"${DB_USER}\\\";\""

service postgresql restart
