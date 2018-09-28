#!/bin/bash

DT=$(date +'%Y%m%d-%H%M%S')
PIDFILE="/data/api.pid"
RESULT=0

if [ -s ${PIDFILE} ]
then
	kill $(cat ${PIDFILE})
	RESULT=$?
	rm -f ${PIDFILE}
else
	PID=$(ps -ef | grep -i "python api.py" | grep -v grep | tr -s " " | cut -d " " -f2)
	if [ "x${PID}" = "x" ]
	then
		RESULT=0
	else
		kill ${PID}
		RESULT=$?
	fi
fi

# delete all files
rm -f *.py *.yml *.sh

echo "stop.sh run at ${DT}, result is ${RESULT}" >> /data/stop.log
exit ${RESULT}
