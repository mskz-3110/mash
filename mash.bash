#!/bin/bash

exit_assert(){
  exit_status=$1
  if [ 0 -ne ${exit_status} ]; then
    echo "$2"
    exit ${exit_status}
  fi
}

execute(){
  args=()
  while [ 0 -lt $# ]
  do
    args+=("$1")
    shift
  done
  "${args[@]}"
}

sh(){
  caption="[${PWD}] $@"
  echo "${caption}"
  execute "$@"
  exit_assert $? "Failed($?): ${caption}"
}

remove(){
  sh rm -fr "$@"
}

rename(){
  sh mv "$@"
}

copy(){
  sh cp -r "$@"
}

changed(){
  path=$1
  if [ -d "${path}" ]; then
    pushd ${path}
  else
    exit_assert 1 "Not found: ${path}"
  fi
}

maked(){
  path=$1
  sh mkdir -p ${path}
  changed ${path}
}

remaked(){
  path=$1
  remove ${path}
  maked ${path}
}

if [[ ! "$-" =~ \i ]]; then
  "$@"
  exit_assert $? "Failed($?): $@"
fi
