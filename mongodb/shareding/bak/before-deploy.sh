#!/bin/bash

DATA_PATH=/data/mongo
DATA_DIR_LIST=('config1' 'config2' 'config3' 'shard1' 'shard2' 'shard3' 'script')

function check_directory() {
  if [ ! -d "${DATA_PATH}" ]; then
    echo "create directory: ${DATA_PATH}"
    echo ${PWD} | sudo -S mkdir -p ${DATA_PATH}
  else
    echo "directory ${DATA_PATH} already exists."
  fi


  cd "${DATA_PATH}"

  for SUB_DIR in ${DATA_DIR_LIST[@]}
  do
    if [ ! -d "${DATA_PATH}/${SUB_DIR}" ]; then
      echo "create directory: ${DATA_PATH}/${SUB_DIR}"
      echo "${PWD}" | sudo -S mkdir -p "${DATA_PATH}/${SUB_DIR}"
    else
      echo "directory: ${DATA_PATH}/${SUB_DIR} already exists."
    fi
  done

  echo "change directory owner to $USER:$USER"
  echo "${PWD}" | sudo -S chown -R $USER:$USER "${DATA_PATH}"

  echo "change directory owner to chmod -R 777"
  echo "${PWD}" | sudo -S chmod -R 777 "${DATA_PATH}"
}

check_directory

