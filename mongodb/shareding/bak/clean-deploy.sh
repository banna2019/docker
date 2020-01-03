#!/bin/bash


DATA_PATH="/data/mongo"

docker-compose -f docker-compose.yaml down

if [ -d "${DATA_PATH}" ]; then
    echo "delete directory: ${DATA_PATH}"
    echo ${PWD} | sudo -S rm -rf ${DATA_PATH}/*
fi
