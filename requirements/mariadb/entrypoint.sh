#!/bin/bash
set -e

# Initialize database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB temporarily
    mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
    MARIADB_PID=$!

    # Wait for MariaDB to start
    echo "Waiting for MariaDB to start..."
    for i in {30..0}; do
        if mysqladmin ping --silent; then
            break
        fi
        echo "Waiting for MariaDB... $i"
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo "MariaDB did not start"
        exit 1
    fi

    # Run initialization script
    echo "Running initialization script..."
    mysql < /etc/mysql/init.sql

    # Stop temporary MariaDB
    kill $MARIADB_PID
    wait $MARIADB_PID

    echo "MariaDB initialization complete"
fi

# Start MariaDB normally
exec mariadbd --datadir=/var/lib/mysql "$@"
