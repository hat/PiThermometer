#!/bin/bash

cd /sys/bus/w1/devices
cd 28-0316a2e7adff
TEMP=0

while true
do
	TEMP="$(cat w1_slave | grep -Eho '[0-9][0-9][0-9][0-9][0-9]')"
	CEL="$(echo "scale=2; ${TEMP} / 1000" | bc -l)"
	FHR="$(echo "scale=2; ${CEL} * (9/5) + 32" | bc -l)"
	sudo sed -i "/TEMP_C/c\<!--TEMP_C-->${CEL}" /var/www/html/index.html
	sudo sed -i "/TEMP_F/c\<!--TEMP_F-->${FHR}" /var/www/html/index.html
	sleep 1
done

