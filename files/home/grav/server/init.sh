#!/bin/bash

# shellcheck source=files/home/grav/server/helpers.sh
source "/home/grav/server/helpers.sh"

if [[ ! "${PUID}" -eq 0 ]] && [[ ! "${PGID}" -eq 0 ]]; then
  LogAction "Executing usermod"
  usermod -o -u "${PUID}" grav
  groupmod -o -g "${PGID}" grav
else
    LogError "Running as root is not supported, please fix your PUID and PGID!"
    exit 1
fi

chown -R grav:grav /grav /home/grav

#
# Install Grav
#
LogAction "Starting Grav Installation"
unzip -qn /tmp/grav.zip -d /
su grav -c '(crontab -l; echo "* * * * * grav cd /grav;/usr/bin/php bin/grav scheduler 1>> /dev/null 2>&1") | crontab -'
ln -sf /dev/stderr /grav/logs/grav.log
LogAction "Finished Grav Installation"

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

if [[ ${ROBOTS_DISALLOW} ]]; then
  LogAction "Overwrite default robots.txt with disallow /"
  cp -f /tmp/robots.disallow.txt /grav/robots.txt
  LogAction "Finished overwrite of robots.txt"
fi

chown -R grav:grav /grav

#
# Setup Nginx & start
#
/home/grav/server/setup-nginx.sh
service php8.2-fpm start
service nginx start
