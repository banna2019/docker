#!/bin/bash

source /etc/profile

read -p "请输入您要替换的目标IP地址:" IP_ADD

SOURCE_ADD=`cat kibana/config/kibana.yml |grep http|awk -F '://' '{print $2}'|awk -F ':' '{print $1}'`

for i in `ls ./{data01,data02,data03,kibana,master,tribe}/config/*.yml`
do 
    sed -i "s/${SOURCE_ADD}/${IP_ADD}/g" $i
done


