#!/bin/bash
apt-get update -y
apt-get install apache2 php libapache2-mod-php -y
systemctl start apache2
systemctl enable apache2

echo "<?php phpinfo(); ?>" > /var/www/html/index.php
