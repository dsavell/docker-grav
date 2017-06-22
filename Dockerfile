FROM php:7.0-apache

MAINTAINER David Savell <dsavell21@gmail.com>

# Install Core Packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git libpng12-dev libjpeg-dev libpq-dev
RUN apt-get clean -q && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setting up php extensions
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr
RUN docker-php-ext-install gd zip

# Config WebServer
RUN a2enmod rewrite

# Download GRAV
RUN rm -fR /var/www/html/
RUN git clone -b master https://github.com/getgrav/grav.git /var/www/html

# Install GRAV
WORKDIR /var/www/html/
RUN bin/grav install
RUN bin/gpm selfupgrade
RUN bin/gpm update
RUN chown -R www-data:www-data *
RUN find . -type f | xargs chmod 664
RUN find . -type d | xargs chmod 775
RUN find . -type d | xargs chmod +s
RUN umask 0002

# Exposed Ports
EXPOSE 80
