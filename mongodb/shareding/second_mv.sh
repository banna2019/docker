#!/bin/bash
for item in /database/vol/
 do
   for item2 in `ls $item`
    do
     if [ $item2 = 'mongos' ]
     then
        echo $item2
        cp mongos.conf $item$item2/config/mongos.conf
     else
        echo "no"
        cp mongod.conf $item$item2/config/mongod.conf
    fi
    done
done
