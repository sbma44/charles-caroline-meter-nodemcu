MAX_CLIENTS = 5
PORT = 8081

active_clients = 0
next_byte = 0
found_server = false

function next_ip()
	out = ""
	byte_count = 0
	for i in string.gmatch(wifi.sta.getip(), "%d+") do
		if byte_count < 3 then
			out = out .. i .. "."
		else
			next_byte = (next_byte + 1) % 256
			out = out .. tostring(next_byte)
		end
		byte_count = byte_count + 1
		if byte_count > 255 then
			return "DONE"
		end
	end
	return out
end

function network_search()
	while active_clients < MAX_CLIENTS do
		active_clients = active_clients + 1
		srv = net.createConnection(net.TCP, 0)
		srv:on("connection", function(sck)
		  if not found_server then
		  	found_server = true
		  	start_ws(sck)
		  end
		end)
		srv:on("disconnection", function(sck, reason)
			active_clients = active_clients - 1
			addr = sck.getaddr()
			print(reason .. " from " .. addr[1] .. ":" .. addr[0])
			network_search()
		end)
		ip = next_ip()
		if ip == "DONE" then
			print('exhausted address space')
			return
		else
			srv:connect(PORT, next_ip())
		end
	end
end

function start_ws(sck)
	addr = sck.getaddr()
	print("Starting websocket connection to " .. addr[1] .. ":" addr[0])
end

network_search()