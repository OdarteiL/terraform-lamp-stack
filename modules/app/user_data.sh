#!/bin/bash
apt-get update -y
apt-get install php php-mysql apache2 -y
systemctl start apache2
systemctl enable apache2

# Simple test page
cat <<EOF > /var/www/html/index.php
<?php
\$conn = new mysqli("10.0.2.68", "root", "MyStrongRootPassword123!");

if (\$conn->connect_error) {
    die("Connection failed: " . \$conn->connect_error);
}
echo "Connected to MySQL successfully!";
?>
EOF
