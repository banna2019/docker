
#!/bin/bash
#
# chkconfig: - 90 10
# description: elasticsearch start and stop
# @dinghao
 
# Elasticsearch Home Diretory 
ES_HOME=/opt/elasticsearch
 
# Elasticsearch Binary File Directory
BIN_PATH=$ES_HOME/bin
 
# Elasticsearch Binary File Name
BINARY_NAME=elasticsearch
 
# Elasticsearch Binary File Absolute path
FULL_BINARY_PATH=$BIN_PATH/$BINARY_NAME
 
# Elasticsearch Pid File Path
PID_FILE=$ES_HOME/tmp/es.pid
 
# Elasticsearch Startup User
ES_USER=es
 
 
PID=$(ps aux | egrep "home=$ES_HOME " | grep -v grep | awk '{print $2}')
 
# es_status
#   0: $FULL_BINARY_PATH 运行中并且"$PID"与"$PID_FIL"中相同
#   1: $FULL_BINARY_PATH 没有在运行或者"$PID"与"$PID_FIL"中不符合
#   2: $FULL_BINARY_PATH 运行中但是"$PID_FIL"E不存在
 
if [ ! -z $PID ];then
    if [ -f $PID_FILE ];then
        if [ $PID -eq $(cat $PID_FILE) ];then
            es_status=0
        else
            es_status=1
        fi
    else
        es_status=2
    fi
else
    es_status=1
    rm -f $PID_FILE
fi
 
 
start(){
    if [ $es_status -eq 1 -o $es_status -eq 2 ];then
        su - $ES_USER -c "$FULL_BINARY_PATH -d -p $PID_FILE"
    fi
}
 
stop(){
    if [ $es_status -eq 0 ];then
    	pkill -F $PID_FILE
    elif [ $es_status -eq 2 ];then
        kill -9 $PID
    fi
    rm -f $PID_FILE
}
 
status(){
    if [ $es_status -eq 0 ];then
    	echo -e "\033[32;1m $BINARY_NAME already running\033[0m"
    else
    	echo -e "\033[31;1m $BINARY_NAME closed\033[0m"
    fi
}
 
restart(){
    stop
    start
}
 
help(){
    echo "usage: $1 {start|stop|restart|status|help}
	start        - start $BINARY_NAME
        stop         - stop $BINARY_NAME
        status       - $BINARY_NAME running status
        restart      - restart $BINARY_NAME
        help         - Display help information and exit"
    exit 0
}
 
case $1 in
    start)
    start
    ;;
    stop)
    stop
    ;;
    status)
    status
    ;;
    restart)
    restart
    ;;
    help|*)
    help
    ;;
esac
