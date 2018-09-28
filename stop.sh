#!/bin/bash

DT=$(date +'%Y%m%d-%H%M%S')
PIDFILE="api.pid"
kill $(cat ${PIDFILE})
RESULT=$?
rm -f ${PIDFILE}

if [ ${RESULT} = "0" ]
then
	:
else
	PID=$(ps -ef | grep -i "python api.py" | grep -v grep | tr -s " " | cut -d " " -f2)
	kill ${PID}
	#RESULT=$?
	RESULT=0
fi

# delete all files
rm -f *.py *.yml *.sh

echo "stop.sh run at ${DT}, result is ${RESULT}" >> /data/stop.log
exit ${RESULT}
