#!/bin/bash

# shellcheck source=/dev/null
source "/home/grav/server/helpers.sh"

cd /grav || exit

bin/gpm update -n
