--como um dicionario em python, apenas criado. Sera alimentado mais adiante
m_dist = {}

--variavel para o loop da conexão
local count = 0

--função para acender ou apagar o LED
function manipulateLED(STATUS)
	m:publish("testtopic/sensor1","ON/OFF",0,0,function(m) print("ON/OFF")end)

	light(STATUS)

	if STATUS == "OFF" then
		--confirma a recepção de menssagem no topico /mcu/comando
		m:publish("testtopic/sensor1","LED OFF",0,0, function(m) print("LED OFF") end)
	else
		-- confirma a recepcao de mensagem no topico /mcu/comando
		m:publish("testtopic/sensor1","LED ON",0,0, function(m) print("LED ON") end)
	end
end

-- Como dicionario em Python, um array que no momento esta armazenando apenas a funcao de LED
m_dist["testtopic/sensor1"] = manipulateLED

m = mqtt.Client(MQTT_CLIENTID, 60, "lasse", "lassemqtt")

m:lwt("/lwt","online",0,0)

m:on("connect",function(m) print("nClient: ",
	MQTT_CLIENTID,
	"nBroker: ",
	MQTT_HOST,
	"nPorta: ",
	MQTT_PORT,
	"nn")
	--Topico para receber os comandos remotos
	m:subscribe("/mcu/comandos/#",0,function(m) print("Topico COMANDO alinhado")end)
end)

--na desconexão
m:on("offline",function(m) print("Desconectado do Broker")
	print("Heap: ", node.heap())
end)

--dispatcher e interpreter
m:on("message",function(m,t,pl) print("Payload: ",pl)
	print("Topic: ",t)
    light(pl)
	--if pl~=nil and m_dist[t] then
		--m_dist[t](pl)
       --print("valor pl: ", pl)
	--end
end)

--conexão ao Broker
m:connect(MQTT_HOST,MQTT_PORT,0,1)
