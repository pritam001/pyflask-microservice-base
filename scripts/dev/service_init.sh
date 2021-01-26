#!/usr/bin/env bash

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# include common functions
. "$SCRIPT_DIR"/common.sh

function check_python3_dep_versions() {
  # shellcheck disable=SC2154
  echo "$style_bold_blue""Checking python3 dependencies . . .""$style_reset"
  local python3_base
  python3_base=$(which python3)
  # shellcheck disable=SC2154
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
  if [[ $conda_base != "" ]]; then
    local conda_version
    conda_version=$(conda --version)
    echo "installed conda version: $conda_version"
  else
    # shellcheck disable=SC2154
    echo "$style_bold_red""Error : conda is not installed""$style_reset"
    exit 1
  fi
}

function recreate_conda_env() {
  source_conda_commands
  remove_conda_env
  echo "$style_bold_cyan""Creating new conda environment""$style_reset"
  # shellcheck disable=SC2154
  local conda_python_version="$pyflask_pref_python_base_version_major"".""$pyflask_pref_python_base_version_minor"
  # shellcheck disable=SC2154
  conda create -n "$pyflask_pref_python_env_name" python="$conda_python_version"
  echo "$style_bold_cyan""Activating new conda environment""$style_reset"
  conda activate "$pyflask_pref_python_env_name"
}

function validate_venv_installation() {
  # shellcheck disable=SC2154
  if [[ $python3_version_major -eq 3 && $python3_version_minor -ge 6 ]]; then
    echo "python3 version $python3_version has inbuilt venv support"
  else
    echo "$style_bold_red""Error : venv requires python3 version >= 3.6.0""$style_reset"
    exit 1
  fi
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
  # shellcheck disable=SC2154
  echo "$style_bold_cyan""Selected environment manager :$style_reset $pyflask_pref_python_env_manager"
  if [ "$pyflask_pref_python_env_manager" == "conda" ]; then
    validate_conda_installation
    recreate_conda_env
    # shellcheck disable=SC2154
    echo "$style_bold_green""Conda environment initialization complete""$style_reset"
  elif [ "$pyflask_pref_python_env_manager" == "venv" ]; then
    validate_venv_installation
    recreate_venv_env
    echo "$style_bold_green""Venv environment initialization complete""$style_reset"
  else
    echo "$style_bold_red""Error : Unknown environment manager mentioned in pyflask-preferences.yaml""$style_reset"
    exit 1
  fi

}

main "$@"
