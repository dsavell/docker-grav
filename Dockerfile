FROM bitnami/minideb:bookworm

ARG GRAV_VERSION=1.7.43

LABEL maintainer="dsavell21@gmail.com"

ENV USER grav

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  install_packages \
    ca-certificates \
    cron \
    curl \
    git \
    lsb-release \
    nano \
    nginx \
    tzdata \
    unzip \
    vim && \
  # Create unpriviliged user
  useradd -m "${USER}" && \
  # Install PHP APT Repository
  curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list && \
  # Install PHP 8.2
  install_packages \
    php8.2 \
    php8.2-fpm \
    php8.2-gd \
    php8.2-curl \
    php8.2-zip \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-intl && \
  # Grav download
  curl -o /tmp/grav.zip -L https://github.com/getgrav/grav/releases/download/"${GRAV_VERSION}"/grav-v"${GRAV_VERSION}".zip

COPY files/ /

RUN \
  chmod +x /home/grav/server/*.sh && \
  mv /home/grav/server/update-plugins.sh /usr/local/bin/update-plugins && \
  mv /home/grav/server/backup.sh /usr/local/bin/backup

WORKDIR /home/grav/server

EXPOSE 80

ENTRYPOINT ["/home/grav/server/init.sh"]
