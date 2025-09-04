FROM debian:latest

RUN apt update && apt install -y mariadb-server

# Copy configuration files
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
COPY init.sql /etc/mysql/init.sql

# Create socket directory with proper permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
