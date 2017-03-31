#!/bin/bash

cd /sys/bus/w1/devices
cd 28-0316a2e7adff
TEMP=0

while true
do
	TEMP="$(cat w1_slave | grep -Eho '[0-9][0-9][0-9][0-9][0-9]')"
	echo $TEMP
	CEL="$(echo "scale=2; ${TEMP} / 1000" | bc -l)"
	echo $CEL
	sed -i "/TEMP_C/c\<!--TEMP_C-->${CEL}" ~/Desktop/simple_temp/index.html
	sleep 5
done

