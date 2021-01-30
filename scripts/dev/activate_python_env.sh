#!/usr/bin/env bash

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# include common functions
. "$SCRIPT_DIR"/common.sh

function activate_python_env() {
  # shellcheck disable=SC2154
  if [ "$pyflask_pref_python_env_manager" == "conda" ]; then
    echo "$style_bold_cyan""Activating conda environment""$style_reset"
    source_conda_commands
    conda activate "$pyflask_pref_python_env_name"
  elif [ "$pyflask_pref_python_env_manager" == "venv" ]; then
    echo "$style_bold_cyan""Activating venv environment""$style_reset"
    source "$pyflask_pref_python_env_name"/bin/activate
    which python
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

  activate_python_env
}

main "$@"