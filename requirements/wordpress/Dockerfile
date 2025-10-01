FROM debian:bullseye

RUN apt update && apt install -y \
	php \
	php-fpm \
	php-mysqli \
	curl \
	netcat

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY script.sh .
RUN chmod +x script.sh
RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["./script.sh"]
