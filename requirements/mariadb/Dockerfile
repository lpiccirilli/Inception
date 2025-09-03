FROM debian:latest

RUN apt update && apt install -y mariadb-server

# Copy configuration files
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
COPY init.sql /etc/mysql/init.sql
# Create socket directory with proper permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Create entrypoint script that initializes the database
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Initialize database if it doesn'\''t exist\n\
if [ ! -d "/var/lib/mysql/mysql" ]; then\n\
    echo "Initializing MariaDB database..."\n\
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql\n\
    \n\
    # Start MariaDB temporarily\n\
    mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &\n\
    MARIADB_PID=$!\n\
    \n\
    # Wait for MariaDB to start\n\
    echo "Waiting for MariaDB to start..."\n\
    for i in {30..0}; do\n\
        if mysqladmin ping --silent; then\n\
            break\n\
        fi\n\
        echo "Waiting for MariaDB... $i"\n\
        sleep 1\n\
    done\n\
    \n\
    if [ "$i" = 0 ]; then\n\
        echo "MariaDB did not start"\n\
        exit 1\n\
    fi\n\
    \n\
    # Run initialization script\n\
    echo "Running initialization script..."\n\
    mysql < /tmp/init.sql\n\
    \n\
    # Stop temporary MariaDB\n\
    kill $MARIADB_PID\n\
    wait $MARIADB_PID\n\
    \n\
    echo "MariaDB initialization complete"\n\
fi\n\
\n\
# Start MariaDB normally\n\
exec mariadbd --user=mysql --datadir=/var/lib/mysql "$@"' > /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/docker-entrypoint.sh"]
