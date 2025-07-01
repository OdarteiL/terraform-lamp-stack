#!/bin/bash
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install mysql-server -y
systemctl start mysql
systemctl enable mysql

# Set MySQL root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${mysql_root_password}';"
mysql -e "FLUSH PRIVILEGES;"
