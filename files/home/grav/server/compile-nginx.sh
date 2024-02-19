#!/bin/bash

# shellcheck source=/dev/null
source "/home/grav/server/helpers.sh"

LogAction "Generating php www.conf"
sed -i -e 's/www-data/grav/g' /etc/php/8.2/fpm/pool.d/www.conf
LogAction "Finished generating php www.conf"

LogAction "Generating nginx.conf"
if [[ -n ${NGINX_CLIENT_MAX_BODY_SIZE} ]]; then
  sed -i "s/client_max_body_size .*;/client_max_body_size ${NGINX_CLIENT_MAX_BODY_SIZE};/g" /etc/nginx/nginx.conf
fi
LogAction "Finished generating nginx.conf"
