#!/bin/bash

DATA_PATH=/data/mongo

function check_directory() {
  if [ ! -d "${DATA_PATH}" ]; then
    echo "directory: ${DATA_PATH} not exists, please run before-depoly.sh."
  fi
}

function generate_keyfile() {
  cd "${DATA_PATH}/script"
  if [ ! -f "${DATA_PATH}/script/mongo-keyfile" ]; then
    echo 'create mongo-keyfile.'
    openssl rand -base64 756 -out mongo-keyfile
    echo "${PWD}" | sudo -S chmod 600 mongo-keyfile
    echo "${PWD}" | sudo -S chown 999 mongo-keyfile
  else
    echo 'mongo-keyfile already exists.'
  fi
}

check_directory
generate_keyfile

