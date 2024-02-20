#!/bin/bash

# shellcheck source=files/home/grav/server/helpers.sh
source "/home/grav/server/helpers.sh"

cd /grav || exit

bin/gpm update -n
