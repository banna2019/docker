#!/bin/sh

cat /nginx.conf.template | \
  sed -e "s#@MERCHANT_ELB_ADD@#$MERCHANT_ELB_ADD#g"  | \
  sed -e "s#@MQTT_ELB_ADD@#$MQTT_ELB_ADD#g" | \
  cat > /etc/nginx/nginx.conf
  
nginx -g "daemon off;"
