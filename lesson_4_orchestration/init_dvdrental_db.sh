#!/bin/bash


# Enable strict error handling
# The 'set -e' command causes the script to exit immediately if any command fails
# This helps prevent partial initialization and ensures the database is either fully set up or not at all
# Without this, the script might continue after errors, leading to an incomplete database setup
set -e


# Create a new PostgreSQL database named 'dvdrental'
# This command runs SQL inside the PostgreSQL server to create our database
# Key components:
# - psql: The PostgreSQL command-line client
# - -v ON_ERROR_STOP=1: Makes psql exit with an error code if an SQL error occurs
# - --username "$POSTGRES_USER": Uses the username provided by the PostgreSQL container environment variable
# - --dbname "$POSTGRES_DB": Connects to the default database (usually 'postgres')
# - The heredoc (<<-EOSQL to EOSQL) contains the SQL commands to execute
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE dvdrental;
EOSQL


# Restore the DVD rental sample database from the provided archive file
# This command loads the database structure and data from a pre-existing backup file
# Key components:
# - pg_restore: PostgreSQL tool for restoring databases from archives
# - -U $POSTGRES_USER: The PostgreSQL user who will own the restored objects
# - -d dvdrental: The target database we just created
# - -Ft: Specifies that the input is a tar format archive
# - -v: Verbose mode, shows detailed progress information
# - -e: Exit on error rather than continuing
# - /mydata/dvdrental.tar: The path to our database archive file
#   This file is available inside the container because we mounted the 
#   ./data directory to /mydata in the docker-compose.yml
pg_restore -U $POSTGRES_USER -d dvdrental -Ft -v -e /mydata/dvdrental.tar