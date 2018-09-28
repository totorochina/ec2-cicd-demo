#!/bin/bash

DT=$(date +'%Y%m%d-%H%M%S')

cd /data
shopt -s extglob
rm *.!(log)
#find -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} \;
find -mindepth 1 -maxdepth 1 -type f ! -iname "*.pid" -exec rm -rf {} \;

echo "clearfiles.sh executed at ${DT}" >> /data/clearfiles.log
exit 0
