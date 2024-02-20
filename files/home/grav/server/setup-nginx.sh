#!/bin/bash

# shellcheck source=home/grav/server/helpers.sh
source "/home/grav/server/helpers.sh"

LogAction "Generating php www.conf"
sed -i -e 's/www-data/grav/g' /etc/php/8.2/fpm/pool.d/www.conf
LogAction "Finished generating php www.conf"

LogAction "Generating nginx.conf"
if [[ -n ${NGINX_CLIENT_MAX_BODY_SIZE} ]]; then
  sed -i "s/client_max_body_size .*;/client_max_body_size ${NGINX_CLIENT_MAX_BODY_SIZE};/g" /etc/nginx/nginx.conf
fi

ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log
LogAction "Finished generating nginx.conf"
