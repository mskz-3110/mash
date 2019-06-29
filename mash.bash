#!/bin/bash

exit_assert(){
  exit_status=$1
  msg=$2
  if [ 0 -ne ${exit_status} ]; then
    if [ -n "${msg}" ]; then
      echo ${msg}
    fi
    exit ${exit_status}
  fi
}

sh(){
  command="$*"
  echo "${PWD}$ ${command}"
  ${command}
  exit_assert $? "Failed($?): ${PWD}$ ${command}"
}

chdir(){
  dir=$1
  if [ ! -d ${dir} ]; then
    exit_assert 1 "Not found: ${dir}"
  fi
  cd ${dir}
}

rmdir(){
  dir=$1
  if [ -d ${dir} ]; then
    sh rm -fr ${dir}
  fi
}

if [ 0 -ne $# ]; then
  $*
  exit_assert $? "Failed($?): $*"
fi
