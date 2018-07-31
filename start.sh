#!/bin/bash

FULLEXEC="/data/api.py"
EXEC="api.py"
#PORT=9000
PORT=${1:-9000}
LOG="/data/$(basename ${EXEC}).log"
RESULT=0
DT=$(date +'%Y%m%d-%H%M%S')

# Check whether same program is running
PID=$(ps -ef | grep -i "python ${FULLEXEC}" | grep -v grep | tr -s " " | cut -d " " -f2)

if [ "x${PID}" = "x" ]
then
	:
else
	kill ${PID}
	RESULT=$?
fi

if [ "${RESULT}" = "0" ]
then
	nohup python ${FULLEXEC} --port=${PORT} >> ${LOG} 2>&1 &
	echo $! > "/data/api.pid"
else
	:
fi

echo "start.sh executed at ${DT}, result ${RESULT}" >> /data/start.log
exit ${RESULT}
