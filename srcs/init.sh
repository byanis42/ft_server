service mysql start

# Config Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Generate website folder
mkdir /var/www/yayasite # && touch /var/www/yayasite/index.php
#echo "<?php phpinfo(); ?>" >> /var/www/yayasite/index.php

# SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/yayasite.pem -keyout /etc/nginx/ssl/yayasite.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=yanboudr/CN=yayasite"

# Config NGINX
mv ./tmp/nginx-conf /etc/nginx/sites-available/yayasite
ln -s /etc/nginx/sites-available/yayasite /etc/nginx/sites-enabled/yayasite
rm -rf /etc/nginx/sites-enabled/default

# Config MYSQL
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
mysql -u root -e "CREATE USER 'yaya'@'localhost' IDENTIFIED BY 'MDP'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'yaya'@'localhost'"
#echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
mysql -u root -e "FLUSH PRIVILEGES;"

# DL phpmyadmin
mkdir /var/www/yayasite/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/yayasite/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/yayasite/phpmyadmin/config.inc.php

# DL wordpress
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/yayasite
mv /tmp/wp-config.php /var/www/yayasite/wordpress

service php7.3-fpm start
service nginx start
bash
