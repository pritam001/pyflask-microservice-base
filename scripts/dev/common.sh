#!/usr/bin/env bash

# shellcheck disable=SC2034
declare style_bold_red="\033[1m\033[31m"
declare style_bold_green="\033[1m\033[32m"
declare style_bold_blue="\033[1m\033[34m"
declare style_bold_magenta="\033[1m\033[35m"
declare style_bold_cyan="\033[1m\033[36m"
declare style_reset="\033[0m"

declare SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
declare PROJECT_DIR
PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

function parse_yaml() {
   local prefix=$2
   # shellcheck disable=SC2155
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$1" |
   awk -F"$fs" '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'"$prefix"'",vn, $2, $3);
      }
   }'
}

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

function get_python3_version() {
  local python3_base
  python3_base=$(which python3)
  local python3_version
  python3_version=$(python3 --version | cut -d " " -f 2)
  local python3_version_major
  python3_version_major=$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1)
  local python3_version_minor
  python3_version_minor=$(python3 --version | cut -d " " -f 2 | cut -d "." -f 2)
  echo 'python3_base="'"$python3_base"'"; python3_version="'"$python3_version"'"; python3_version_major="'"$python3_version_major"'"; python3_version_minor="'"$python3_version_minor"'"'
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

function remove_venv_env() {
  # shellcheck disable=SC2154
  echo "$style_bold_cyan""Deactivating existing venv environment""$style_reset"
  deactivate
  echo "$style_bold_cyan""Removing existing venv environment""$style_reset"
  # shellcheck disable=SC2154
  rm -rf "$pyflask_pref_python_env_name"
}

function source_conda_commands() {
  # run conda commands from bash
  # https://github.com/conda/conda/issues/7980
  local conda_info_base
  conda_info_base=$(conda info --base)
  source "$conda_info_base"/etc/profile.d/conda.sh
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

function remove_conda_env() {
  echo "$style_bold_cyan""Deactivating existing conda environment""$style_reset"
  conda deactivate

  echo "$style_bold_cyan""Removing existing conda environment""$style_reset"
  # shellcheck disable=SC2154
  conda env remove --name "$pyflask_pref_python_env_name"
}
