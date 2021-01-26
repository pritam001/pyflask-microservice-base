#!/usr/bin/env bash

declare -r style_bold_red="\033[1m\033[31m"
declare -r style_bold_green="\033[1m\033[32m"
declare -r style_bold_blue="\033[1m\033[34m"
declare -r style_bold_magenta="\033[1m\033[35m"
declare -r style_bold_cyan="\033[1m\033[36m"
declare -r style_reset="\033[0m"

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd & cd ../..)
declare PROJECT_DIR
PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# include common functions
. "$SCRIPT_DIR"/common.sh

function main() {
  # read pyflask-preferences.yaml file
  # shellcheck disable=SC2046
  eval $(parse_yaml "$PROJECT_DIR"/pyflask-preferences.yaml "pyflask_pref_")
  if [ $pyflask_pref_is_personalized == "false" ]; then
    echo "Starting project personalization . . ."
  fi
}

main "$@"
