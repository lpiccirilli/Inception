-- Set root password
-- Using environment variables (requires shell interpolation in entrypoint)
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MYSQL_ROOT_PASSWORD}');
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MYSQL_ROOT_PASSWORD}');
-- ... rest of the script-- Create database
CREATE DATABASE IF NOT EXISTS wordpress;

-- Create WordPress user with proper permissions
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'your_wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';

-- Ensure changes are applied
FLUSH PRIVILEGES;
