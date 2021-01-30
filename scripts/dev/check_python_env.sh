#!/usr/bin/env bash

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# include common functions
. "$SCRIPT_DIR"/common.sh

function show_env_activation_cmd() {
  # shellcheck disable=SC2154
  echo "$style_bold_cyan""Use following command to activate $pyflask_pref_python_env_manager environment :""$style_reset"
  # shellcheck disable=SC2154
  if [ "$pyflask_pref_python_env_manager" == "conda" ]; then
    # shellcheck disable=SC2154
    echo "$style_bold_magenta""conda activate $pyflask_pref_python_env_name""$style_reset"
  elif [ "$pyflask_pref_python_env_manager" == "venv" ]; then
    echo "$style_bold_magenta""source $pyflask_pref_python_env_name/bin/activate""$style_reset"
  else
    echo "$style_bold_red""Error : Unknown environment manager mentioned in pyflask-preferences.yaml""$style_reset"
    exit 1
  fi
}

function main() {
  # read pyflask-preferences.yaml file
  # shellcheck disable=SC2046
  eval $(parse_yaml "$PROJECT_DIR"/pyflask-preferences.yaml "pyflask_pref_")
  # shellcheck disable=SC2046
  eval $(get_python3_version)

  # shellcheck disable=SC2154
  if [[ $python3_base != *"$pyflask_pref_python_env_name"* ]]; then
    show_env_activation_cmd
    exit 1
  fi
}

main "$@"