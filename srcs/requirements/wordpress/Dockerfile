FROM debian:bookworm

RUN apt update && apt install -y \
	php \
	php-fpm \
	php-mysqli \
	curl \
	netcat-openbsd

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY script.sh .
RUN chmod +x script.sh
RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["./script.sh"]
