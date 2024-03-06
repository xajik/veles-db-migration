#!/bin/bash
# wait-for-db.sh

# Set your PostgreSQL database connection parameters
DB_PORT="5432"       # Change to your PostgreSQL port

# Wait for the PostgreSQL server to start
until pg_isready -p $DB_PORT
do
  echo "Postgres is unavailable - sleeping"
  sleep 5
done
