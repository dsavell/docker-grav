#!/bin/bash

# shellcheck source=files/home/grav/server/helpers.sh
source "/home/grav/server/helpers.sh"

cd /grav || exit

LogAction "Starting plugins update"
su grav -c 'bin/gpm update -n'
LogAction "Finished plugins update"
