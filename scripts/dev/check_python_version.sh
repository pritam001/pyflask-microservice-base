#!/usr/bin/env bash

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# include common functions
. "$SCRIPT_DIR"/common.sh

function check_python_version() {
  # shellcheck disable=SC2154
  echo "Python version : $python3_version"
  # shellcheck disable=SC2154
  if ! [[ $python3_version_major -eq 3 && $python3_version_minor -ge 8 ]]; then
    echo "$style_bold_red""Error : Required python version >= 3.8""$style_reset"
    exit 1
  fi
}

function main() {
  # shellcheck disable=SC2046
  eval $(get_python3_version)

  check_python_version
}

main "$@"
