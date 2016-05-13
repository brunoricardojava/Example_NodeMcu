print(wifi.sta.getip())
--nil
wifi.setmode(wifi.STATION)
wifi.sta.config("LASSE 2G Cisco","lassesemfio")
print(wifi.sta.getip())
