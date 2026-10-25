FROM bitnami/minideb:trixie

ARG GRAV_VERSION
ARG GRAV_ADMIN

## Install Packages
RUN install_packages \
  ca-certificates \
  cron \
  curl \
  nano \
  unzip \
  vim \
  wget

## Install WebServer and PHP
RUN install_packages \
  nginx \
  php \
  php-fpm \
  php-cli \
  php-apcu \
  php-curl \
  php-gd \
  php-intl \
  php-memcache \
  php-memcached \
  php-mbstring \
  php-opcache \
  php-redis \
  php-xml \
  php-yaml \
  php-zip

RUN rm -f /etc/nginx/sites-enabled/default

RUN sed -i 's|^;*error_log = .*|error_log = /dev/stderr|' \
      /etc/php/8.4/fpm/php-fpm.conf \
  && sed -i 's|^;*catch_workers_output = .*|catch_workers_output = yes|' \
      /etc/php/8.4/fpm/pool.d/www.conf \
  && printf '%s\n' \
      'php_admin_flag[log_errors] = on' \
      'php_admin_value[error_log] = /dev/stderr' \
      >> /etc/php/8.4/fpm/pool.d/www.conf

## Download GRAV
RUN set -eux; \
  : "${GRAV_VERSION:?GRAV_VERSION build argument is required}"; \
  : "${GRAV_ADMIN:?GRAV_ADMIN build argument is required}"; \
  case "${GRAV_ADMIN}" in \
    true) archive="grav-admin-v${GRAV_VERSION}.zip" ;; \
    false) archive="grav-v${GRAV_VERSION}.zip" ;; \
    *) echo >&2 "GRAV_ADMIN must be true or false"; exit 1 ;; \
  esac; \
  curl --fail --location --retry 3 \
    "https://github.com/getgrav/grav/releases/download/${GRAV_VERSION}/${archive}" \
    --output /tmp/grav.zip; \
  mkdir -p /tmp/grav /var/www/html; \
  unzip -q /tmp/grav.zip -d /tmp/grav; \
  if [ -f /tmp/grav/index.php ]; then \
    grav_root=/tmp/grav; \
  else \
    set -- /tmp/grav/*; \
    if [ "$#" -ne 1 ] || [ ! -f "$1/index.php" ]; then \
      echo >&2 "Unexpected Grav archive layout"; exit 1; \
    fi; \
    grav_root="$1"; \
  fi; \
  cp -a "${grav_root}/." /var/www/html/; \
  mkdir -p /var/www/html/cache /var/www/html/logs /var/www/html/tmp \
    /var/www/html/backup /var/www/html/images /var/www/html/assets \
    /var/www/html/user; \
  chown -R www-data:www-data \
    /var/www/html/cache /var/www/html/logs /var/www/html/tmp \
    /var/www/html/backup /var/www/html/images /var/www/html/assets \
    /var/www/html/user; \
  chmod -R u+rwX \
    /var/www/html/cache /var/www/html/logs /var/www/html/tmp \
    /var/www/html/backup /var/www/html/images /var/www/html/assets \
    /var/www/html/user; \
  rm -rf /tmp/grav /tmp/grav.zip

RUN printf '%s\n' \
  '* * * * * cd /var/www/html && /usr/bin/php8.4 bin/grav scheduler >/dev/null 2>&1' \
  | crontab -u www-data -

COPY root/ /

EXPOSE 80 443

CMD ["/init"]