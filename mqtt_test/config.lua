--Wifi Setup
MySSID = "LASSE 2G Cisco"
MyPASSWD = "lassesemfio"
STATION = wifi.STATION

--MQTT
MQTT_CLIENTID = wifi.sta.getmac()
MQTT_HOST = "200.239.93.200"
MQTT_PORT = 1883

--LED
LED_PIN = 1
ON = 1
OFF = 0

print("Global vars loaded")
