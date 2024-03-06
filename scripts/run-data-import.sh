#!/bin/sh
# run-import_filess.sh

# Directory containing import_files scripts
IMPORT_DIR=./import

# Function to run a single import_files file
run_import_files() {
    import_files=$1
    echo "Applying import: $import_files"
    psql $DATABASE_URL -f $import_files

    # Check if import_files failed
    if [ $? -ne 0 ]; then
        echo "Error importing file: $import_files"
        exit 1
    fi
}

echo "Importing data from: $IMPORT_DIR"
for import_files in $(ls $IMPORT_DIR/*.sql | sort -n); do
    run_import_files $import_files
    if [ $? -ne 0 ]; then
        echo "Error applying files: $import_files"
        exit 1
    fi
done

echo "All imports loaded applied successfully."
exit 0
