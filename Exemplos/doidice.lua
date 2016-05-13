-- init mqtt client with keepalive timer 120sec
m = mqtt.Client("brunoid", 120, "lasse", "lassemqtt")

-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("Id", "offline", 0, 0)

m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)

-- on publish message receive event
m:on("message", function(client, topic, data) 
  print(topic .. ":" ) 
  if data ~= nil then
    print(data)
  end
end)

-- for TLS: m:connect("192.168.11.118", secure-port, 1)
m:connect("200.239.93.222", 1884, 0, function(client) print("connected") end, 
                                     function(client, reason) print("failed reason: "..reason) end)

-- Calling subscribe/publish only makes sense once the connection
-- was successfully established. In a real-world application you want
-- move those into the 'connect' callback or make otherwise sure the 
-- connection was established.

-- subscribe topic with qos = 0
m:subscribe("Id",0, function(client) print("subscribe success") end)
-- publish a message with data = hello, QoS = 0, retain = 0
m:publish("Id","hello",0,0, function(client) print("sent") end)

m:close();
-- you can call m:connect again