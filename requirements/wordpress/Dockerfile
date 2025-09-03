FROM debian:latest

RUN apt update && apt install -y \
	php-fpm \
	php-mysqli \
	curl 
COPY www.conf /etc/php/8.4/fpm/pool.d/www.conf
COPY script.sh .
RUN chmod +x script.sh

CMD ["./script.sh"]
