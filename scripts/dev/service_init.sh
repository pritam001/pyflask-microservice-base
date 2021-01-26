#!/usr/bin/env bash

declare -r style_bold_red="\033[1m\033[31m"
declare -r style_bold_green="\033[1m\033[32m"
declare -r style_bold_blue="\033[1m\033[34m"
declare -r style_bold_magenta="\033[1m\033[35m"
declare -r style_bold_cyan="\033[1m\033[36m"
declare -r style_reset="\033[0m"

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
declare PROJECT_DIR
PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# include common functions
. "$SCRIPT_DIR"/common.sh

function check_python3_dep_versions() {
  echo "$style_bold_blue""Checking python3 dependencies . . .""$style_reset"
  local python3_base
  python3_base=$(which python3)
  echo "$style_bold_cyan""Python3 Base :""$style_reset $python3_base"
  local python3_version
  python3_version=$(python3 --version)
  echo "$style_bold_cyan""Python3 Version :""$style_reset $python3_version"
  local pip3_base
  pip3_base=$(which pip3)
  echo "$style_bold_cyan""Pip3 Base :""$style_reset $pip3_base"
  local pip3_version
  pip3_version=$(pip3 --version)
  echo "$style_bold_cyan""Pip3 Version :""$style_reset $pip3_version"
}

function validate_conda_installation() {
  local conda_base
  conda_base=$(which conda)
  if [[ $conda_base != *"not found"* ]]; then
    local conda_version
    conda_version=$(conda --version)
    echo "installed conda version: $conda_version"
  else
    echo "$style_bold_red""Error : conda is not installed""$style_reset"
    exit 1
  fi
}

function validate_venv_installation() {
  # shellcheck disable=SC2154
  if [[ $python3_version_major -eq 3 && $python3_version_minor -ge 6 ]]; then
    echo "python3 version $python3_version has inbuilt venv support"
    # python3 -m venv search-microservice-venv
  else
    echo "$style_bold_red""Error : venv requires python3 version >= 3.6.0""$style_reset"
    exit 1
  fi
}

function main() {
  # read pyflask-preferences.yaml file
  # shellcheck disable=SC2046
  eval $(parse_yaml "$PROJECT_DIR"/pyflask-preferences.yaml "pyflask_pref_")
  # shellcheck disable=SC2046
  eval $(get_python3_version)
  printf "\n"

  # shellcheck disable=SC2154
  if [ "$pyflask_pref_is_personalized" == "false" ]; then
    echo "$style_bold_blue""Starting project personalization . . .""$style_reset"
    printf "\n"
  fi

  # check python3 and pip3 versions
  check_python3_dep_versions
  printf "\n"

  # shellcheck disable=SC2154
  echo "$style_bold_blue""Checking environment manager . . .""$style_reset"
  echo "$style_bold_cyan""Selected environment manager :$style_reset $pyflask_pref_python_env_manager"
  if [ "$pyflask_pref_python_env_manager" == "conda" ]; then
    validate_conda_installation
  elif [ "$pyflask_pref_python_env_manager" == "venv" ]; then
    validate_venv_installation
  else
    echo "$style_bold_red""Error : Unknown environment manager mentioned in pyflask-preferences.yaml""$style_reset"
    exit 1
  fi

}

main "$@"
