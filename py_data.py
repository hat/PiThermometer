import time
import json


while True:
	with open('/sys/bus/w1/devices/28-0316a2e7adff/w1_slave', 'r') as f:
		for line in f:
			if 't' in line:
				celsius = str((float)(line[-6:]) / 1000)
	fahrenheit = str((float)(celsius) * 9/5 + 32)
	epochTime = (int)(time.time())
	newData = "%s;%s;%s" % (epochTime, celsius, fahrenheit)
	nd = open('/var/www/html/data', 'r')
	readData = nd.read()
	readData = readData.split('|')[1:]
	readData.append(newData)
	nd.close()
	newInfo =  "|".join(readData)

	ff = open('/var/www/html/data', 'w')
	ff.write(newInfo)
	ff.close()

	time.sleep(15)
