#!/bin/bash

S_PATH=/database/vol

for i in {config,config,config1,config1,config2,config2,shard1,shard1,shard1,shard2,shard2,shard2,shard3,shard3,shard3,shard4,shard4,shard4,mongos,mongos,mongos1,mongos1}
do
    for j in {db,config,backup}
    do
        mkdir -pv ${S_PATH}/$i/$j
    done
done


mkdir -pv /database/vol/keyfile
openssl rand -base64 741 > /database/vol/keyfile/key.file
chmod 600 /database/vol/keyfile/key.file
chown 999 /database/vol/keyfile/key.file
