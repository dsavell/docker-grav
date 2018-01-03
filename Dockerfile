FROM ej52/alpine-nginx-php

MAINTAINER David Savell https://github.com/dsavell

# Install Core Packages
RUN apk add --no-cache git curl unzip --virtual=build-dependencies

# Download GRAV
WORKDIR /var/www
RUN \
        rm -fR /var/www/* \
        && GRAV_VERSION=$(curl -sX GET "https://api.github.com/repos/getgrav/grav/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') \
        && curl -o grav-v${GRAV_VERSION}.zip -L https://github.com/getgrav/grav/releases/download/${GRAV_VERSION}/grav-v${GRAV_VERSION}.zip \
        && unzip grav-v${GRAV_VERSION}.zip \
        && cp -R /var/www/grav/* /var/www 

# Install GRAV
RUN \
	chown -R www-data:www-data * \
	&& find . -type f | xargs chmod 664 \
	&& find . -type d | xargs chmod 775 \
	&& find . -type d | xargs chmod +s \
	&& umask 0002

# Clean
RUN \
	apk del --purge build-dependencies

# Exposed Ports
EXPOSE 80
