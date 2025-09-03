-- Set root password
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('root');
-- Create database
CREATE DATABASE IF NOT EXISTS wordpress;

-- Create WordPress user with proper permissions
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'your_wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';

-- Ensure changes are applied
FLUSH PRIVILEGES;
