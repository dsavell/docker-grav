FROM ej52/alpine-nginx-php

MAINTAINER David Savell https://github.com/dsavell

# Install Core Packages
RUN apk add --no-cache git --virtual=build-dependencies

# Download GRAV
RUN \
	rm -fR /var/www/* \
	&& git clone -b master https://github.com/getgrav/grav.git /var/www/

# Install GRAV
WORKDIR /var/www/
RUN \
	bin/grav install \
	&& bin/gpm selfupgrade \
	&& bin/gpm update \
	&& chown -R www-data:www-data * \
	&& find . -type f | xargs chmod 664 \
	&& find . -type d | xargs chmod 775 \
	&& find . -type d | xargs chmod +s \
	&& umask 0002

# Clean
RUN \
	apk del --purge build-dependencies

# Exposed Ports
EXPOSE 80