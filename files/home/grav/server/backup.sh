#!/bin/bash

# shellcheck source=files/home/grav/server/helpers.sh
source "/home/grav/server/helpers.sh"

cd /grav || exit

LogAction "Starting backup"
su grav -c 'bin/grav backup -n --no-ansi'
LogAction "Finished backup"
