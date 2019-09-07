#!/bin/bash

source /etc/profile

echo -n "Please enter your PACKAGE_DOWNLOAD_URL: " 
read PACKAGE_DOWNLOAD_URL

echo -n "Please enter your MERCHANT_ELB: " 
read MERCHANT_ELB

echo -n "Please enter your MQTT_ELB: " 
read MQTT_ELB

echo -n "Please enter your NGINX_IMAGE_NAME: " 
read NGINX_IMAGE_NAME


PACKAGE_NAME=alpine-nginx.tar.gz
NGINX_ORIG_DIR=alpine-nginx


wget ${PACKAGE_DOWNLOAD_URL}
if [ $? -eq 0 ];then
    echo "alpine-nginx package Download completed!"
else
    echo "alpine-nginx package Download failure!"
fi

tar xf ${PACKAGE_NAME}  && \
cd ${NGINX_ORIG_DIR} && \
docker build -t ${NGINX_IMAGE_NAME} .



if [ $? -eq 0 ];then
    echo "${NGINX_IMAGE_NAME} Build completed!"
else
    echo "${NGINX_IMAGE_NAME} Build failure!"\
	exit 1
fi

docker run -itd \
--name nginx-web2 \
--restart=always \
-p 80:80 \
-p 443:443 \
-e MERCHANT_ELB_ADD=${MERCHANT_ELB} \
-e MQTT_ELB_ADD=${MQTT_ELB} \
${NGINX_IMAGE_NAME}






