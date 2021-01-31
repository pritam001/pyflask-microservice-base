#!/usr/bin/env bash

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# include common functions
. "$SCRIPT_DIR"/common.sh

function recreate_conda_env() {
  source_conda_commands
  remove_conda_env
  # shellcheck disable=SC2154
  echo "$style_bold_cyan""Creating new conda environment""$style_reset"
  # shellcheck disable=SC2154
  local conda_python_version="$pyflask_pref_python_base_version_major"".""$pyflask_pref_python_base_version_minor"
  # shellcheck disable=SC2154
  conda create -n "$pyflask_pref_python_env_name" python="$conda_python_version"
  echo "$style_bold_cyan""Activating new conda environment""$style_reset"
  conda activate "$pyflask_pref_python_env_name"
}

function recreate_venv_env() {
  remove_venv_env
  echo "$style_bold_cyan""Creating new venv environment""$style_reset"
  python3 -m venv "$pyflask_pref_python_env_name"
  echo "$style_bold_cyan""Activating new venv environment""$style_reset"
  source "$pyflask_pref_python_env_name"/bin/activate
}

function main() {
  # read pyflask-preferences.yaml file
  # shellcheck disable=SC2046
  eval $(parse_yaml "$PROJECT_DIR"/pyflask-preferences.yaml "pyflask_pref_")
  # shellcheck disable=SC2046
  eval $(get_python3_version)
  printf "\n"

  # check python3 and pip3 versions
  check_python3_dep_versions
  printf "\n"

  # shellcheck disable=SC2154
  echo "$style_bold_blue""Checking environment manager . . .""$style_reset"
  # shellcheck disable=SC2154
  echo "$style_bold_cyan""Selected environment manager :$style_reset $pyflask_pref_python_env_manager"

  . "$SCRIPT_DIR"/check_env_manager.sh

  # shellcheck disable=SC2154
  if [ "$pyflask_pref_is_personalized" == "false" ]; then
    echo "$style_bold_blue""Starting project personalization . . .""$style_reset"
    rm -rf .github
    pip3 install pyyaml
    pip3 install inquirer
    python3 scripts/dev/personalize.py "$pyflask_pref_python_env_name"
    printf "\n"
  fi

  if [ "$pyflask_pref_python_env_manager" == "conda" ]; then
    recreate_conda_env
    # shellcheck disable=SC2154
    echo "$style_bold_green""Conda environment initialization complete""$style_reset"
  elif [ "$pyflask_pref_python_env_manager" == "venv" ]; then
    recreate_venv_env
    echo "$style_bold_green""Venv environment initialization complete""$style_reset"
  else
    # shellcheck disable=SC2154
    echo "$style_bold_red""Error : Unknown environment manager mentioned in pyflask-preferences.yaml""$style_reset"
    exit 1
  fi

  . "$SCRIPT_DIR"/check_python_version.sh
}

main "$@"
