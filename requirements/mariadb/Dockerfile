FROM debian:bullseye

RUN apt update -y && apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin//entrypoint.sh
EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
