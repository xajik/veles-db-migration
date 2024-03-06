#!/bin/sh
# run-migrations-down.sh

# Directory containing migration scripts
MIGRATIONS_DIR=./migrations

# Run each ".down.sql" migration script found in $MIGRATIONS_DIR
# Files are sorted in reverse order based on their timestamp prefix
echo "Migrations UP directory: $MIGRATIONS_DIR"
for migration in $(ls $MIGRATIONS_DIR/*.down.sql | sort -nr); do
    echo "Reverting migration: $migration"
    psql $DATABASE_URL -f $migration
    if [ $? -ne 0 ]; then
        echo "Error reverting migration: $migration"
        echo "Rolling back changes..."
        psql $DATABASE_URL -c 'ROLLBACK'
        exit 1
    fi
done

echo "All down migrations applied successfully."
