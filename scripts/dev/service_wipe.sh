#!/usr/bin/env bash

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# include common functions
. "$SCRIPT_DIR"/common.sh

function main() {
  # read pyflask-preferences.yaml file
  # shellcheck disable=SC2046
  eval $(parse_yaml "$PROJECT_DIR"/pyflask-preferences.yaml "pyflask_pref_")

  # shellcheck disable=SC2154
  if [ "$pyflask_pref_python_env_manager" == "conda" ]; then
    source_conda_commands
    remove_conda_env
    echo "$style_bold_green""Conda environment is wiped""$style_reset"
  elif [ "$pyflask_pref_python_env_manager" == "venv" ]; then
    remove_venv_env
    echo "$style_bold_green""Venv environment is wiped""$style_reset"
  else
    echo "$style_bold_red""Error : Unknown environment manager mentioned in pyflask-preferences.yaml""$style_reset"
    exit 1
  fi
}

main "$@"
