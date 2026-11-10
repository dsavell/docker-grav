FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

ARG GRAV_VERSION
ARG GRAV_ADMIN

# Upgrade base libraries affected by reported CVEs using the latest Alpine 3.24 packages.
RUN apk add --no-cache --upgrade musl zlib

## Install Packages
RUN apk add --no-cache \
  bash \
  busybox-suid \
  ca-certificates \
  curl \
  git \
  nano \
  shadow \
  unzip \
  util-linux \
  vim \
  wget

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

## Install WebServer and PHP
RUN apk add --no-cache \
  nginx \
  php84 \
  php84-ctype \
  php84-curl \
  php84-dom \
  php84-exif \
  php84-fileinfo \
  php84-fpm \
  php84-gd \
  php84-iconv \
  php84-intl \
  php84-mbstring \
  php84-opcache \
  php84-openssl \
  php84-pdo \
  php84-pecl-apcu \
  php84-pecl-memcache \
  php84-pecl-memcached \
  php84-pecl-redis \
  php84-pecl-yaml \
  php84-phar \
  php84-session \
  php84-simplexml \
  php84-tokenizer \
  php84-xml \
  php84-xmlreader \
  php84-xmlwriter \
  php84-zip

RUN ln -s /usr/bin/php84 /usr/bin/php \
  && if awk -F: '$3 == 33 && $1 != "www-data" { found = 1 } END { exit !found }' /etc/passwd; then \
      echo >&2 "UID 33 is already assigned to another user"; exit 1; \
    fi \
  && if ! grep -q '^www-data:' /etc/group; then \
      addgroup -S -g 33 www-data; \
    elif [ "$(awk -F: '$1 == "www-data" { print $3 }' /etc/group)" != 33 ]; then \
      if awk -F: '$3 == 33 && $1 != "www-data" { found = 1 } END { exit !found }' /etc/group; then \
        echo >&2 "GID 33 is already assigned to another group"; exit 1; \
      fi; \
      groupmod --gid 33 www-data; \
    fi \
  && if ! grep -q '^www-data:' /etc/passwd; then \
      adduser -S -D -H -u 33 -G www-data -s /sbin/nologin www-data; \
    fi \
  && usermod --uid 33 --gid www-data --home /nonexistent --shell /sbin/nologin www-data \
  && rm -f /etc/nginx/http.d/default.conf \
  && mkdir -p /run/php \
  && sed -i 's|^;*error_log = .*|error_log = /dev/stderr|' \
      /etc/php84/php-fpm.conf \
  && sed -i \
      -e 's|^user = .*|user = www-data|' \
      -e 's|^group = .*|group = www-data|' \
      -e 's|^listen = .*|listen = /run/php/php84-fpm.sock|' \
      -e 's|^;*listen.owner = .*|listen.owner = www-data|' \
      -e 's|^;*listen.group = .*|listen.group = www-data|' \
      -e 's|^;*listen.mode = .*|listen.mode = 0660|' \
      -e 's|^;*catch_workers_output = .*|catch_workers_output = yes|' \
      /etc/php84/php-fpm.d/www.conf \
  && printf '%s\n' \
      'php_admin_flag[log_errors] = on' \
      'php_admin_flag[session.upload_progress.enabled] = off' \
      'php_admin_value[error_log] = /dev/stderr' \
      >> /etc/php84/php-fpm.d/www.conf

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
  '* * * * * cd /var/www/html;/usr/bin/php bin/grav scheduler 1>> /dev/null 2>&1' \
  | crontab -u www-data -

COPY root/ /

EXPOSE 80 443

CMD ["/init"]
