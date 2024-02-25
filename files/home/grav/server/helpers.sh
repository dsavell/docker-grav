#!/bin/bash

#
# Logging
#

export LINE='\n'
export RESET='\033[0m'             # Text Reset
export WhiteText='\033[0;37m'      # White
export RedBoldText='\033[1;31m'    # Red
export GreenBoldText='\033[1;32m'  # Green
export YellowBoldText='\033[1;33m' # Yellow
export CyanBoldText='\033[1;36m'   # Cyan

Log() {
  local message="$1"
  local color="$2"
  local prefix="$3"
  local suffix="$4"
  printf "$color%s$RESET$LINE" "$prefix$message$suffix"
}

LogInfo() {
  Log "$1" "$WhiteText"
}
LogWarn() {
  Log "$1" "$YellowBoldText"
}
LogError() {
  Log "$1" "$RedBoldText"
}
LogSuccess() {
  Log "$1" "$GreenBoldText"
}
LogAction() {
  Log "$1" "$CyanBoldText" "****" "****"
}
