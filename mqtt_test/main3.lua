
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
    m:subscribe("/porta",0,function(m) print("Topico COMANDO alinhado")end)
end)

--na desconexão
m:on("offline",function(m) print("Desconectado do Broker")
    print("Heap: ", node.heap())
end)

--dispatcher e interpreter
m:on("message",function(m,t,pl) print("Payload: ",pl)
    print("Topic: ",t)
    
    if (pl == "Bruno") then
        light("ON")
    end
    
    tmr.delay(5*100000)
    light("OFF")
    --if pl~=nil and m_dist[t] then
        --m_dist[t](pl)
       --print("valor pl: ", pl)
    --end
end)

--conexão ao Broker
m:connect(MQTT_HOST,MQTT_PORT,0,1)
