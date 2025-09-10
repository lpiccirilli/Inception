# Inception Project

Questo progetto implementa un'infrastruttura Docker completa per il progetto Inception di 42, con WordPress, MariaDB, NGINX e servizi bonus.

## 🏗️ Architettura

Il progetto include i seguenti servizi:

### Servizi Principali (Obbligatori)
- **NGINX**: Server web con supporto TLS/SSL (porta 443)
- **WordPress**: CMS con PHP-FPM (porta 9000)
- **MariaDB**: Database MySQL (porta 3306)

### Servizi Bonus
- **Redis**: Cache per WordPress (porta 6379)
- **FTP Server**: Server FTP per gestione file (porta 21)
- **Static Website**: Sito web statico portfolio (porta 8080)
- **Adminer**: Interfaccia web per database (porta 8080)
- **Prometheus**: Sistema di monitoraggio (porta 9090)
- **Grafana**: Dashboard per visualizzazione metriche (porta 3000)

## 📁 Struttura del Progetto

```
inception/
├── Makefile                 # Comandi principali
├── README.md               # Questo file
├── srcs/
│   ├── docker-compose.yml  # Configurazione Docker Compose
│   ├── env.example         # Esempio variabili d'ambiente
│   └── requirements/
│       ├── nginx/          # Configurazione NGINX
│       ├── mariadb/        # Configurazione MariaDB
│       ├── wordpress/      # Configurazione WordPress
│       └── bonus/          # Servizi bonus
│           ├── redis/
│           ├── ftp/
│           ├── static-website/
│           ├── adminer/
│           ├── prometheus/
│           └── grafana/
└── secrets/                # File di configurazione sicuri
    ├── db_password.txt
    ├── db_root_password.txt
    └── credentials.txt
```

## 🚀 Installazione e Configurazione

### 1. Configurazione Iniziale VM Debian

#### Installazione Docker
```bash
# Aggiorna il sistema
sudo apt update && sudo apt upgrade -y

# Installa dipendenze
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Aggiungi la chiave GPG ufficiale di Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Aggiungi il repository Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installa Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Aggiungi l'utente al gruppo docker
sudo usermod -aG docker $USER

# Avvia e abilita Docker
sudo systemctl start docker
sudo systemctl enable docker
```

#### Installazione Docker Compose
```bash
# Installa Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verifica installazione
docker-compose --version
```

#### Installazione Make
```bash
# Installa Make
sudo apt install -y make

# Verifica installazione
make --version
```

#### Riavvia la sessione
```bash
# IMPORTANTE: Riavvia la sessione per applicare i permessi Docker
# Oppure esegui:
newgrp docker
```

#### Configurazione Firewall (opzionale)
```bash
# Se usi ufw, apri le porte necessarie
sudo ufw allow 443/tcp
sudo ufw allow 8080/tcp
sudo ufw allow 9090/tcp
sudo ufw allow 3000/tcp

# Se usi iptables
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 9090 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
```

### 2. Setup Progetto

#### Clona il repository
```bash
# Clona il progetto
git clone <repository-url>
cd inception
```

### 3. Setup Rapido

```bash
# 1. Setup iniziale
make setup

# 2. Configurazione
cp srcs/env.example srcs/.env
nano srcs/.env  # Modifica con le tue configurazioni

# 3. Password (modifica i file secrets)
nano secrets/db_password.txt
nano secrets/db_root_password.txt
nano secrets/credentials.txt

# 4. Dominio (aggiungi in /etc/hosts)
sudo nano /etc/hosts
# Aggiungi: 127.0.0.1 your_login.42.fr

# 5. Build e avvio
make build
make up
```

**Configurazioni importanti nel .env:**
- `DOMAIN_NAME`: Il tuo dominio (es. `your_login.42.fr`)
- `MYSQL_USER`: Nome utente database
- `MYSQL_DATABASE`: Nome database

## 🛠️ Comandi Principali

### Build e Avvio
```bash
# Build delle immagini Docker
make build

# Avvio di tutti i servizi
make up

# Build e avvio in un comando
make all
```

### Pulizia per la Correzione
```bash
# Pulizia completa come richiesto dalla correzione
make clean-all

# Poi esegui:
make build
make up
```

## 🔍 Verifica Configurazione

### Verifica Installazione
```bash
# Verifica Docker
docker --version
docker-compose --version
make --version

# Verifica che l'utente sia nel gruppo docker
groups $USER
```

### Verifica Progetto
```bash
# Controlla che le directory esistano
ls -la /home/$(whoami)/data/

# Controlla che il dominio sia configurato
grep "42.fr" /etc/hosts

# Controlla che i file secrets non siano vuoti
ls -la secrets/
```

### Gestione Servizi
```bash
# Visualizza status dei servizi
make status

# Visualizza log in tempo reale
make logs

# Stop dei servizi
make down
```

### Pulizia
```bash
# Rimuovi container e immagini
make clean

# Pulizia completa (tutto)
make fclean

# Rebuild completo
make re
```

### Help
```bash
# Mostra tutti i comandi disponibili
make help
```

## 🌐 Accesso ai Servizi

Dopo aver avviato i servizi, puoi accedere a:

### Servizi Principali
- **WordPress**: https://your_login.42.fr
- **NGINX**: https://your_login.42.fr (stesso di WordPress)

### Servizi Bonus
- **Static Website**: http://localhost:8080
- **Adminer**: http://localhost:8080
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000
  - Username: `admin`
  - Password: `grafana_password` (configurata in .env)

### FTP
- **Host**: localhost
- **Porta**: 21
- **Username**: `ftpuser` (configurato in .env)
- **Password**: `ftp_password` (configurato in .env)

## 🔧 Configurazione WordPress

1. Accedi a https://your_login.42.fr
2. Completa la configurazione iniziale di WordPress
3. Usa le credenziali configurate nei file secrets

## 📊 Monitoraggio

### Prometheus
- URL: http://localhost:9090
- Configurato per raccogliere metriche da tutti i servizi

### Grafana
- URL: http://localhost:3000
- Dashboard pre-configurato per visualizzare le metriche
- Datasource Prometheus già configurato

## 🔒 Sicurezza

- Tutte le password sono gestite tramite Docker Secrets
- NGINX configurato con TLS 1.2/1.3
- Certificati SSL auto-generati
- Nessuna password hardcoded nei Dockerfile

## 🐛 Troubleshooting

### Problemi Comuni

```bash
# Controlla i log
make logs

# Verifica configurazione
docker-compose -f srcs/docker-compose.yml config

# Verifica container
docker ps

# Verifica volumi
docker volume ls

# Reset completo
make fclean
make re
make up
```

## 📝 Note Importanti

- **Dominio**: Configura correttamente in `/etc/hosts`
- **Porte**: Verifica che non siano già in uso
- **Memoria**: Richiede almeno 4GB di RAM
- **Disco**: Almeno 10GB di spazio libero
- **Docker**: Riavvia la sessione dopo l'installazione per applicare i permessi
- **Firewall**: Assicurati che le porte 443, 8080, 9090, 3000 siano aperte

---

**Buon lavoro con il progetto Inception! 🚀**
