-- file : config.lua
local module = {}

module.SSID = {}  
module.SSID["LASSE 2G Cisco"] = "lassesemfio"

module.HOST = "200.239.93.222'"
module.PORT = 1884
module.ID = node.chipid()

module.ENDPOINT = "Id"  
return module  
