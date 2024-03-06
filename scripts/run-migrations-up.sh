#!/bin/sh
# run-migrations.sh

# Directory containing migration scripts
MIGRATIONS_DIR=./migrations

# Function to run a single migration file
run_migration() {
    migration=$1
    echo "Applying migration: $migration"
    psql $DATABASE_URL -f $migration

    # Check if migration failed
    if [ $? -ne 0 ]; then
        echo "Error applying migration: $migration"
        echo "Rolling back changes..."
        psql $DATABASE_URL -c 'ROLLBACK'
        exit 1
    fi
}

echo "Migrations UP directory: $MIGRATIONS_DIR"
for migration in $(ls $MIGRATIONS_DIR/*.up.sql | sort -n); do
    echo "Executing migration: $migration"
    run_migration $migration
    if [ $? -ne 0 ]; then
        echo "Error applying migration: $migration"
        exit 1
    fi
done

echo "All migrations applied successfully."
exit 0
