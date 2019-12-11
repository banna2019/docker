#!/bin/bash

source /etc/profile

docker run -d --log-driver=fluentd --log-opt fluentd-address=10.10.10.106:24224 --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}" --log-opt fluentd-async-connect busybox sh -c 'while true; do echo "`date +"%Y-%m-%d %H:%M:%S"` [error] 11641#0: *38857054 FastCGI sent in stderr: PHP message: PHP Fatal error:  Uncaught UnexpectedValueException: The stream or file /mnt/web/.../logs/2018-11-26.log could not be opened: failed to open stream: Permission denied in /mnt/..../Monolog/Handler/StreamHandler.php:107"; sleep 10; done;'
