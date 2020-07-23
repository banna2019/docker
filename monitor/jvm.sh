#!/bin/bash

IP=`hostname -I|awk '{print $1}'`
label=tomcat_${IP}

PID=`docker exec $(docker ps -qa --filter name='tomcat') ps|awk 'NR==2{print $1}'`
docker exec $(docker ps -qa --filter name='tomcat') jstat -gcutil $PID | awk 'NR!=1{printf "S0 %f\nS1 %f\nE %f\nO %f\nM %f\nCCS %f\nYGC %i\nYGCT %f\nFGC %i\nFGCT %f\nGCT %f\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11;fflush();}' > "/tmp/jvm.txt"
#docker exec $(docker ps -qa --filter name='tomcat') jstat -gcutil $PID | awk 'NR!=1{printf "${label}_jvm,host=${IP} S0 %f,S1 %f,E %f,O %f,M %f,CCS %f,YGC %i,YGCT %f,FGC %i,FGCT %f,GCT %f\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11;fflush();}' > "/tmp/jvm.txt"

#curl -XPOST --data-binary @/tmp/jvm.txt http://10.10.10.106:9091/metrics/job/jvm_metrics/instance/${label}

while read line
do
    #echo $label $line
    echo "$line" | curl --data-binary @- http://10.10.10.106:9091/metrics/job/jvm_metrics/instance/${label}
done < /tmp/jvm.txt

