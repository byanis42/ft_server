FROM debian:buster

# INSTALL NGINX
RUN apt-get update && apt-get upgrade -y && apt-get -y install nginx
# INSTALL WIN
RUN apt -y install vim
# INSTALL WGET
RUN apt-get -y install wget
# INSTALL MYSQL
RUN apt-get -y install mariadb-server
# INSTALL PHP
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

COPY ./srcs/init.sh ./
COPY ./srcs/nginx-conf ./tmp/nginx-conf
COPY ./srcs/wp-config.php ./tmp/wp-config.php
COPY ./srcs/phpmyadmin.inc.php ./tmp/phpmyadmin.inc.php

CMD bash init.sh
