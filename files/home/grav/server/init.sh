#!/bin/bash

# shellcheck source=files/home/grav/server/helpers.sh
source "/home/grav/server/helpers.sh"

if [[ ! "${PUID}" -eq 0 ]] && [[ ! "${PGID}" -eq 0 ]]; then
  LogAction "Executing usermod"
  usermod -o -u "${PUID}" grav
  groupmod -o -g "${PGID}" grav
  chown -R grav:grav /grav /home/grav
else
  LogError "Running as root is not supported, please fix your PUID and PGID!"
  exit 1
fi

#
# Install Grav
#
LogAction "Starting Grav Installation"
su grav -c 'unzip -qn /tmp/grav.zip -d /'
su grav -c '(crontab -l; echo "* * * * * grav cd /grav;/usr/bin/php bin/grav scheduler 1>> /dev/null 2>&1") | crontab -'
rm -rf /tmp/grav.zip
LogAction "Finished Grav Installation"

if [[ "${ROBOTS_DISALLOW,,}" = true ]]; then
  LogAction "Overwrite default robots.txt with disallow /"
  su grav -c 'cp -f /tmp/robots.disallow.txt /grav/robots.txt'
  LogAction "Finished overwrite of robots.txt"
fi

#
# Install Grav Plugins
#
if [[ "${GRAV_PLUGINS}x" != "x" ]]; then
  IFS=',' read -ra plugins <<< "$GRAV_PLUGINS"
  for plugin in "${plugins[@]}"; do
    LogAction "Starting ${plugin} plugin Installation"
    cd /grav || exit
    su grav -c "bin/gpm install -qn \"${plugin}\""
    LogAction "Finished ${plugin} plugin Installation"
  done
fi

#
# Setup Multisite
#
if [[ "${GRAV_MULTISITE}" == "subdirectory" ]]; then
  LogAction "Starting subdirectory multisite installation"
  su grav -c 'cp /tmp/setup_subdirectory.php /grav/setup.php'
  su grav -c 'mkdir -p /grav/user/sites'
  LogAction "Finished subdirectory multisite installation"
elif [[ "${GRAV_MULTISITE}" == "subdomain" ]]; then
  LogAction "Starting subdomain multisite installation"
  su grav -c 'cp /tmp/setup_subdomain.php /grav/setup.php'
  su grav -c 'mkdir -p /grav/user/sites'
  LogAction "Finished subdomain multisite installation"
fi

#
# Setup Nginx & start
#
/home/grav/server/setup-nginx.sh
service php8.2-fpm start
service nginx start
