dofile("config.lua")

--###LED###--
function light(conditions)
	if conditions == "ON" then
		gpio.write(LED_PIN, gpio.HIGH)
        m:publish("testtopic/sensor1","LED ON",0,0, function(m) print("LED ON") end)
	else
		gpio.write(LED_PIN, gpio.LOW)
        m:publish("testtopic/sensor1","LED OFF",0,0, function(m) print("LED OFF") end)
	end
end

--loop para o blink inicial
gpio.mode(LED_PIN, gpio.OUTPUT)
for i=0,3 do
    light("ON")
    tmr.delay(2*100000)
    light("OFF")
    tmr.delay(2*100000)
end


--contador de tentativas de conexão
retriesCounter = 0

--##checker##--
function checker()
	if wifi.sta.getip() == nil then
		print("Conectando ao AP...")
		retriesCounter = retriesCounter + 1
	else
		retriesCounter = 0
		ip,mask,gw = wifi.sta.getip()
		print("------------------")
		print("Resumo da conexão")
		print("IP  :",ip)
		print("Mascara: ",mask)
		print("Gateway: ",gw)
		print("------------------")
		tmr.stop(0)
		light(ON)

        print("run main.lua")
		dofile("main.lua")
	end
end

--##configMyWiFi##--
function configMyWiFi()
	wifi.setmode(STATION)
	--conecta a sua rede
	wifi.sta.config(MySSID,MyPASSWD)

	--verificador de conexão
	tmr.alarm(0,1000,1,checker)
end

configMyWiFi()
