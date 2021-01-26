#!/usr/bin/env bash

function parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

function get_python3_version() {
  local python3_version
  python3_version=$(python3 --version | cut -d " " -f 2)
  local python3_version_major
  python3_version_major=$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1)
  local python3_version_minor
  python3_version_minor=$(python3 --version | cut -d " " -f 2 | cut -d "." -f 2)
  echo 'python3_version="'"$python3_version"'"; python3_version_major="'"$python3_version_major"'"; python3_version_minor="'"$python3_version_minor"'"'
}
