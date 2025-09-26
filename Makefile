build:
	sudo mkdir -p /home/luca/data/mariadb /home/luca/data/wordpress
	sudo chown -R 999:999 /home/luca/data/mariadb
	sudo chmod -R 750 /home/luca/data/mariadb
	sudo chown -R 33:33 /home/luca/data/wordpress
	sudo chmod -R 755 /home/luca/data/wordpress

	sudo docker compose up --build

clean:
	sudo docker compose down -v

reset:
	sudo docker stop $(sudo docker ps -qa); sudo docker rm $(sudo docker ps -qa); sudo docker rmi -f $(sudo docker images -qa); sudo docker volume rm $(sudo docker volume ls -q); sudo docker network rm $(sudo docker network ls -q) 2>/dev/null

tls_check:
	openssl s_client -connect lpicciri.42.fr:443 -tls1_2  </dev/null 2>/dev/null && openssl s_client -connect lpicciri.42.fr:443 -tls1_3  </dev/null 2>/dev/null && openssl s_client -connect lpicciri.42.fr:80 -tls1_1
