#!/usr/bin/env bash

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# include common functions
. "$SCRIPT_DIR"/common.sh

function check_python_version() {
  # shellcheck disable=SC2154
  echo "Python base : $python3_base"
  # shellcheck disable=SC2154
  echo "Python version : $python3_version"
  # shellcheck disable=SC2154
  local pref_py_major=$pyflask_pref_python_base_version_major
  # shellcheck disable=SC2154
  local pref_py_minor=$pyflask_pref_python_base_version_minor
  # shellcheck disable=SC2154
  if ! [[ $python3_version_major -eq $pref_py_major && $python3_version_minor -eq $pref_py_minor ]]; then
    echo "$style_bold_red""Error : Required python version == $pref_py_major.$pref_py_minor.x""$style_reset"
    exit 1
  fi
}

function main() {
  # shellcheck disable=SC2046
  eval $(parse_yaml "$PROJECT_DIR"/pyflask-preferences.yaml "pyflask_pref_")
  # shellcheck disable=SC2046
  eval $(get_python3_version)

  check_python_version
}

main "$@"
