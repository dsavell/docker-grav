#!/bin/bash

# shellcheck source=home/grav/server/helpers.sh
source "/home/grav/server/helpers.sh"

cd /grav || exit

bin/gpm update -n
